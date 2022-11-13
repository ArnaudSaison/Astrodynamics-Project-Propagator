function [TLE] = getLatestTLE(ID)
% GETLATESTTLE uses the Celestrack API to get the latest TLE
%
% ID can be either the name (str) or the NORAD catalog number (int)
%

% search for ID
if isnumeric(ID)
    ID_API = ['CATNR', '=', num2str(ID)];
else
    ID_API = ['NAME', '=', ID];
end

% building the url
url = ['https://celestrak.org/NORAD/elements/gp.php?', ...
       ID_API, '&', ...
       'FORMAT', '=', 'TLE']; % output can be XML, TLE, CSV, ...
options = weboptions('RequestMethod','get','ContentType','text');

% request to API
try 
    TLE_txt = webread(url,options);
    TLE_split = splitlines(TLE_txt);

    TLE.L0 = [TLE_split{1}];
    TLE.L1 = [TLE_split{2}];
    TLE.L2 = [TLE_split{3}];
catch 
    error(['An error occured while retrieving the TLE. API message: "', TLE.L0, '"']);
end

end

