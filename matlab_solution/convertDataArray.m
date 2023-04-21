%% convert latitude, longitude to cartesian coordinate system

function data = convertDataArray(data)
    % convert point locations given by lat, lon from geographic coordinates to local Cartesian coordinate system
    [xCoordinate, yCoordinate] = latlon2local(data(:,1), data(:,2), 0, [data(3,1), data(3,2), 0]);
    data = [xCoordinate yCoordinate data(:,3) data(:,4)];
end