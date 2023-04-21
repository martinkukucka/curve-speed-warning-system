%% check if radius of curvature is valid and actual speed is higher than recommended

function predictedData = checkCurvatureRadiusAndSpeed(predictedData,lowerRadius,upperRadius)
    Rmin = lowerRadius;
    Rmax = upperRadius;
    
    for k=1:size(predictedData,1)
        
        % radius of curvature is invalid, not in range of <Rmin, Rmax>
        if predictedData(k,5) < Rmin || predictedData(k,5) > Rmax
            predictedData(k,7) = 0;
        else
            
            % actual speed is higher than recommended
            if predictedData(k,3) > predictedData(k,6)
                predictedData(k,7) = 1;
                
            % actual speed is lower than recommended
            else
                predictedData(k,7) = 0;
            end
        end
    end
end