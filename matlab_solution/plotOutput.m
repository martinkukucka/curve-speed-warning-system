%% plot output prediction trajectory with / without warning

function plotOutput(allData, predictedData, timeRate)
    % find maximum value among X,Y data points to specify size of plot figure
    xMin = min(allData(:,1)) - 5;
    xMax = max(allData(:,1)) + 5;
    
    x1 = abs(xMin);
    x2 = abs(xMax);
    
    xResult = x1;
    if(x1 < x2)
        xResult = x2;
    end
    
    yMin = min(allData(:,2)) - 5;
    yMax = max(allData(:,2)) + 5;
    
    y1 =  abs(yMin);
    y2 =  abs(yMax);
    
    yResult = y1;
    if(y1 < y2)
        yResult = y2;
    end
    
    result = 5;
    tempResult = yResult;
    if (yResult < xResult)
        tempResult = xResult;
    end
    if (result < tempResult)
        result = tempResult;
    end
    
    % plot output
    plot(allData(:,1), allData(:,2), 'b-o', 'DisplayName','referenced coordinates')
    xlim([-result result])
    ylim([yMin result])
    hold on
    plot(predictedData(:,1), predictedData(:,2), 'g-o', 'DisplayName','predicted coordinates')
    plot(predictedData(1,1), predictedData(1,2), 'k-o', 'DisplayName','actual position')
    
    % set frequency in which are points plotted in figure
    title(sprintf('point frequency is %.1f second/s',timeRate));
    
    % show figure legend
    legend('referenced coordinates','predicted coordinates','actual position')
    
    % set background color depending on warning state (warning - red background / no warning - white background)
    if ismember(1, allData(:,7))
        set(gca, 'Color',[1 0 0])
    else
        set(gca, 'Color',[1 1 1])
    end

    hold off
end