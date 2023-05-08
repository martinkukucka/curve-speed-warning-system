%% predict coordinates

function [predictedX,predictedY] = predictCoordinates(data, time)
    speed = getNextSpeed(data);
    nextAngle = computeCoordinateAngle(data);

    predictedX = predictCoordinateX(data, nextAngle, time, speed);
    predictedY = predictCoordinateY(data, nextAngle, time, speed);
end