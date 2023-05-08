%% check if radius of curvature is valid and actual speed is higher than recommended

function allData = checkCurvatureRadiusAndSpeed(allData,lowerRadius,upperRadius)
    for k=1:size(allData,1)
        
        % radius of curvature is invalid, not in range of <Rmin, Rmax>
        if allData(k,5) < lowerRadius || allData(k,5) > upperRadius
            allData(k,7) = 0;
        else
            
            % actual speed is higher than recommended
            if allData(k,3) > allData(k,6)
                allData(k,7) = 1;
                
            % actual speed is lower than recommended
            else
                allData(k,7) = 0;
            end
        end
    end
end