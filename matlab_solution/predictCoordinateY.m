%% predict Y coordinate

function predictedY = predictCoordinateY(data, index, angle, time, speed)
    predictedY = data(index,2) + speed * time * sin(angle);
end