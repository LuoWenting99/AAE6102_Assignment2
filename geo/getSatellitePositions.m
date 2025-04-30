function svXYZ = getSatellitePositions(navSolutions, ~, svList)
    % Extracting satellite position from navigation solution and capture data
    numEpochs = length(navSolutions.usrPosLLH(:,1));
    svXYZ = zeros(numEpochs, length(svList), 3);
    for epoch = 1:numEpochs
        for k = 1:length(svList)
            prn = svList(k);
            [svPos, ~, ~, ~] = svPosVel(prn, [], navSolutions.localTime(epoch), 1);
            svXYZ(epoch, k, :) = svPos;
        end
    end
end