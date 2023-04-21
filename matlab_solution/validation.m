%% input values validation

function validation(predictionTime, maximumLateralAcceleration, safeLimit, lowerRadius, upperRadius)
    if(predictionTime <= 0 || predictionTime > 30)
        error('Invalid value of prediction time. Valid value is from range 0(excluding) - 30')
    end
    
    if(maximumLateralAcceleration < 0)
        error('Negative value of maximum lateral acceleration is not supported')
    end
    
    if(safeLimit > 100 || safeLimit < 0)
        error('Invalid value of safe limit, set value in range 0 to 100')
    end
    
    if(lowerRadius < 0 || upperRadius < 0)
        error('Negative value of curvature radius limit is not supported')
    end

    if(lowerRadius > upperRadius)
        error('Lower limit of curvature radius must be smaller than upper limit')
    end
end