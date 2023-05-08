%% predict Y coordinate

function predictedY = predictCoordinateY(data, angle, time, speed)
    predictedY = data(3,2) + speed * time * sin(angle);
end