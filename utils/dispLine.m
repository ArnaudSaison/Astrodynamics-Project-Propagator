function [] = dispLine(line_elem, length)
%DIPLLINE displays a line
%   

if nargin < 2
    length = 70;
end

if nargin == 0
    line_elem = '-';
end


line(1:length) = line_elem;
disp(line)

end

