%% predict X coordinate

function predictedX = predictCoordinateX(data, index, angle, time, speed)
    predictedX = data(index,1) + speed * time * cos(angle);
end