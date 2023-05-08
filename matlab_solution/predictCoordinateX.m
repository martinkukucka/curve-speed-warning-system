%% predict X coordinate

function predictedX = predictCoordinateX(data, angle, time, speed)
    predictedX = data(3,1) + speed * time * cos(angle);
end