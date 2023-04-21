%% predict coordinates

function [predictedX,predictedY] = predictCoordinates(data, index, time)
    speed = getNextSpeed(data, index);
    nextAngle = computeCoordinateAngle(data, index);

    predictedX = predictCoordinateX(data, index, nextAngle, time, speed);
    predictedY = predictCoordinateY(data, index, nextAngle, time, speed);
end