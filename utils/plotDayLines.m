function plotDayLines(t_end, ax)
% PLOTDAYLINES plots lines at timestamps correspoding to days > 0
%
% t_end = length of propagation
% ax = axes on which to plot lines (optional)
%

% optional axes argument
if nargin == 1
    ax = gca;
end

% number of lines = number of whole days
nb_lines = floor(t_end /24/3600);

% if > 0 days
if nb_lines > 0

    % plot each line
    for n = 1:nb_lines
        xline(ax, n *24*3600, '-.', ...
              dayLabelMaker(n), ...
              'LabelHorizontalAlignment', 'left', ...
              'LabelVerticalAlignment', 'bottom');
        hold on;
    end
end

end


function day_label = dayLabelMaker(n)
    if n < 2
        day_label = [num2str(n), ' day'];
    else
        day_label = [num2str(n), ' days'];
    end
end