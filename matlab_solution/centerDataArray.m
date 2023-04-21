%% center the coordinates along the y axis

function data = centerDataArray(data)
    centeredPoint = [0 1];
    
    data = convertDataArray(data);

    angle = atan2(centeredPoint(1,2) - data(3,2), centeredPoint(1,1) - data(3,1)) - atan2(data(2,2) - data(3,2), data(2,1) - data(3,1));
    result = deg2rad(180) - angle;

    x2 = data(2,1) * cos(result) + data(2,2) * sin(result);
    y2 = data(2,1) * -sin(result) + data(2,2) *  cos(result);

    x1 = data(1,1) * cos(result) + data(1,2) * sin(result);
    y1 = data(1,1) * -sin(result) + data(1,2) *  cos(result);

    centeredData = [x1 y1; x2 y2; data(3,1) data(3,2)];
    data(:,1) = centeredData(:,1);
    data(:,2) = centeredData(:,2);
end