% WGS 84 LLH convert to ECEF
function ecef = llh2ecef(llh)
    a = 6378137.0;              % WGS84 ellipsoid semi-axis
    f = 1/298.257223563;        % e
    lat = llh(1); lon = llh(2); h = llh(3);
    e2 = 2*f - f^2;           
    N = a / sqrt(1 - e2*sin(lat)^2);
    x = (N + h) * cos(lat) * cos(lon);
    y = (N + h) * cos(lat) * sin(lon);
    z = (N*(1 - e2) + h) * sin(lat);
    ecef = [x, y, z];
end