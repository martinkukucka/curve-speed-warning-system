%% compute radius of curvature and recommended speed

function allData = computeCurvatureRadiusAndSpeed(allData,safeLimitOfLateralAcceleration)
    AlateralMax = safeLimitOfLateralAcceleration;

    [pathdistance,R,~] = curvature([allData(:,1) allData(:,2)]);
    allData = [allData pathdistance R];
    allData = [allData sqrt(allData(:, 5) * AlateralMax)];
end