%% insert / update data structure by GPS data

function data = updateDataArray(fileName, data, record, pnmea, insertData)
    persistent outputFileInitialized;

    % convert NMEA-0183 record
    nmeaRecord = pnmea(record);
    
    % parse NMEA-0183 record
    latitude = nmeaRecord.Latitude;
    longitude = nmeaRecord.Longitude;
    speed = nmeaRecord.GroundSpeed;
    tempTime = nmeaRecord.UTCDateTime;
    status = nmeaRecord.Status;

    if isequal(status,0) && ~isnan(latitude) && ~isnan(longitude) && ~isnan(speed)
        % save data to output file
        if(~isequal(fileName,'-1'))
            if isempty(outputFileInitialized)
                writetable(table(latitude,longitude,speed,posixtime(tempTime),'VariableNames',{'latitude','longitude','speed','time'}),fileName,"WriteMode",'overwritesheet',"AutoFitWidth",false);
                outputFileInitialized = 1;
            else
                writetable(table(latitude,longitude,speed,posixtime(tempTime),'VariableNames',{'latitude','longitude','speed','time'}),fileName,"WriteMode","append","AutoFitWidth",false);
            end
        end
        
        % insert GPS data to data structure
        if isequal(insertData,1)
            time = posixtime(tempTime);
            data = [data; latitude longitude speed time];
            
        % update data structure
        else
            time = posixtime(tempTime);

            tempData = [data(2,1) data(2,2) data(2,3) data(2,4); 
                data(3,1) data(3,2) data(3,3) data(3,4); 
                latitude longitude speed time];
            data = tempData;
        end
    end
end