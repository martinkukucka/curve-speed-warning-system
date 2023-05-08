%% get speed of actual position for predicted points

function nextspeed = getNextSpeed(data)
    nextspeed = data(3,3);
    if nextspeed < 0
        nextspeed = 0;
    end
end