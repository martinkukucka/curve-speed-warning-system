clc; clear all; close all; format longg;

% load config
run('config.m');

% check if input data loaded from config are valid
validation(predictionTime, maximumLateralAcceleration, safeLimit, lowerRadius, upperRadius);

% check if received data / simulation results will be written to file
if(logReceivedData)
    if(~endsWith(receivedDataFile,'.xlsx'))
        error('Invalid received data file name format. Use .xlsx instead')
    end
else
    receivedDataFile = '-1';
end
    
if(saveResults)
    if(~endsWith(simulationResultsFile,'.xlsx'))
        error('Invalid simulation results file name format. Use .xlsx instead')
    end
else
    simulationResultsFile = '-1';
end


% receiver and NMEA parser initialization
device = serialport(PORT,4800,'Timeout',3);
pnmea = nmeaParser("MessageIDs", "RMC");

% fig1 = figure;
% ax = axes;
% xlim([-10 10])
% ylim([-10 10])
% 
flag = 1;
index = 3;
data = [];
originalData = [];

%% Main program loop
% record = device.readline;
record = readline(device);
while ~isempty(record) 
    
    % fill data structure with inicialization data
    if isempty(data) || (~isempty(data) && length(data(:,1)) ~= index)
        data = updateDataArray(receivedDataFile, data, record, pnmea, 1);
    else
        if flag
            originalData = data;
            flag = 0;
        end
        originalData = updateDataArray(receivedDataFile, originalData, record, pnmea, 0);
        data = originalData;
        
        % convert coordinates to Cartesian coordinate system and center coordinates along Y axis
        data = centerDataArray(data);
        
        allData = [data(index - 2,1) data(index - 2,2) data(index - 2,3); 
            data(index - 1,1) data(index - 1,2) data(index - 1,3); 
            data(index,1) data(index,2) data(index,3)
            ];
        predictedData = [data(index,1) data(index,2) data(index,3)];

        tempData = [
            data(length(data(:,1))-2,1) data(length(data(:,1))-2,2) data(length(data(:,1))-2,3) data(length(data(:,1))-2,4);
            data(length(data(:,1))-1,1) data(length(data(:,1))-1,2) data(length(data(:,1))-1,3) data(length(data(:,1))-1,4); 
            data(length(data(:,1)),1) data(length(data(:,1)),2) data(length(data(:,1)),3) data(length(data(:,1)),4)
            ];
        
        % decode time values
        time1 = datetime(data(1,4),'ConvertFrom','posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss');
        time2 = datetime(data(2,4),'ConvertFrom','posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss');
        time3 = datetime(data(3,4),'ConvertFrom','posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss');
        
        % difference between recording times
        deltaTime12 = seconds(diff(datetime([time1;time2])));
        deltaTime23 = seconds(diff(datetime([time2;time3])));
        
        % check validation of time differences (it's expected, that records will be received with same time frequency)
        if (deltaTime12 ~= deltaTime23)
            if(visualizeTrajectory)
                plot(0,0);
                title('invalid records, retrying...');
                set(gca, 'Color',[1 1 0]);
            end

        else
            timeRate = deltaTime23;

            if (timeRate > 0)
                steps = ceil(predictionTime / timeRate);

                % prediction loop in which are future coordinates predicted
                for time = 1:steps
                    [predictedX, predictedY] = predictCoordinates(tempData, 3, timeRate);  

                    tempData = [tempData(2,1) tempData(2,2) tempData(2,3) tempData(2,4);
                        tempData(3,1) tempData(3,2) tempData(3,3) tempData(3,4);
                        predictedX predictedY getNextSpeed(tempData, 3) 0;
                        ];

                    allData = [allData; [tempData(3,1) tempData(3,2) tempData(3,3)]];
                    predictedData = [predictedData; [tempData(3,1) tempData(3,2) tempData(3,3)]];
                end

                % computes radius and speed of actual and predicted data
                allData = computeCurvatureRadiusAndSpeed(allData,maximumLateralAcceleration*((100-safeLimit)/100));

                N = size(allData,1);
                allData = [allData,zeros(N,1)];

                % decide if warning should be invoked
                allData = checkCurvatureRadiusAndSpeed(allData, lowerRadius, upperRadius);

                % write results to file
                if(~isequal(simulationResultsFile,'-1'))
                    writeResults(simulationResultsFile, allData, data(3,4));
                end

                % trajectory visualization containing referenced and predicted data
                if(visualizeTrajectory)
                    plotOutput(allData, predictedData, timeRate);
                end
            else
                continue
            end
        end
    end
%     record = device.readline;
    record = readline(device);
end