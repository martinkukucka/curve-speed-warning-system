%% write simulation results to file, Inf values are replaced by -1

function writeResults(simulationResultsFile, allData, tempTime, warningValue)
    persistent resultsFileInitialized;
    time = datetime(tempTime,'ConvertFrom','posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss');

    actualSpeed = allData(3,3);
    isInf = isinf(actualSpeed);
    actualSpeed(isInf) = -1;

    actualSafeSpeed = allData(3,6);
    isInf = isinf(actualSafeSpeed);
    actualSafeSpeed(isInf) = -1;

    futureSafeSpeed = allData(4,6);
    isInf = isinf(futureSafeSpeed);
    futureSafeSpeed(isInf) = -1; 

    actualCurvatureRadius = allData(3,5);
    isInf = isinf(actualCurvatureRadius);
    actualCurvatureRadius(isInf) = -1;

    futureCurvatureRadius = allData(4,5);
    isInf = isinf(futureCurvatureRadius);
    futureCurvatureRadius(isInf) = -1;

    if ismember(1, allData(:,7))
        warningState = warningValue;
    else
        warningState = 0;
    end

    if isempty(resultsFileInitialized)
        writetable(table(time,warningState,actualSpeed,actualSafeSpeed,futureSafeSpeed,actualCurvatureRadius,futureCurvatureRadius,'VariableNames',{'time','warning','actual_speed','actual_recommended_speed','future_recommended_speed','actual_curvature_radius','future_curvature_radius'}),simulationResultsFile,"WriteMode",'overwritesheet',"AutoFitWidth",false);
        resultsFileInitialized = 1;
    else
        writetable(table(time,warningState,actualSpeed,actualSafeSpeed,futureSafeSpeed,actualCurvatureRadius,futureCurvatureRadius,'VariableNames',{'time','warning','actual_speed','actual_recommended_speed','future_recommended_speed','actual_curvature_radius','future_curvature_radius'}),simulationResultsFile,"WriteMode","append","AutoFitWidth",false);
    end
end