function [] = xticksCustomDate()
%XTICKSDATE plots custom xticks for datetimes with minor grid
%   

% retrieving tick values and dividing in 12 intervals for hours
grid on;
grid minor;
ivar_ticks = xticks;
xax = get(gca,'XAxis');
xticks_intervals = hours(ivar_ticks(2)-ivar_ticks(1));
if ~round(xticks_intervals), warning('xticks were not seperated by integer amount of hours'); end
xax.MinorTickValues = ivar_ticks(1):diff(ivar_ticks(1:2))/xticks_intervals:ivar_ticks(end);

end

