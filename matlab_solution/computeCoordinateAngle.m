%% compute angle between coordinates

function nextAngle = computeCoordinateAngle(data, index)
    % compute angle of referenced coordinates
    prevAngle = atan2( (data(index - 1,2) - data(index - 2,2)) , (data(index - 1,1) - data(index - 2,1)));
    actAngle = atan2( (data(index,2) - data(index - 1,2)) , (data(index,1) - data(index - 1,1)));
    
    % compute angle for predicted coordinates based on angle of referenced coordinates
    nextAngle = actAngle + (actAngle - prevAngle);
end