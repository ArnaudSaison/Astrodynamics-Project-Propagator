function [TLE] = getLatestTLE(name)
% GETLATESTTLE uses the Celestrack API to get the latest TLE
%

url = ['https://celestrak.org/NORAD/elements/gp.php?', ...
       'NAME', '=', name, '&', ...
       'FORMAT', '=', 'TLE'];
options = weboptions('RequestMethod','get','ContentType','text');

try 
    TLE_txt = webread(url,options);
    TLE_split = splitlines(TLE_txt);

    TLE.L0 = [TLE_split{1}];
    TLE.L1 = [TLE_split{2}];
    TLE.L2 = [TLE_split{3}];
catch 
    disp('An error occured while retrieving the TLE');
end

end

