%% compute angle between coordinates

function nextAngle = computeCoordinateAngle(data)
    % compute angle of referenced coordinates
    prevAngle = atan2( (data(2,2) - data(1,2)) , (data(2,1) - data(1,1)));
    actAngle = atan2( (data(3,2) - data(2,2)) , (data(3,1) - data(2,1)));
    
    % compute angle for predicted coordinates based on angle of referenced coordinates
    nextAngle = actAngle + (actAngle - prevAngle);
end