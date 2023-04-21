%% compute radius of curvature and recommended speed

function predictedData = computeCurvatureRadiusAndSpeed(predictedData,safeLimitOfLateralAcceleration)
    AlateralMax = safeLimitOfLateralAcceleration;

    [pathdistance,R,~] = curvature([predictedData(:,1) predictedData(:,2)]);
    predictedData = [predictedData pathdistance R];
    predictedData = [predictedData sqrt(predictedData(:, 5) * AlateralMax)];
end