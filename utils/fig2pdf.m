function fig2pdf(fig_name, name, height, AR, folder)
%fig2pdf Prints a figure to PDF following given specifications
%   fig_name:   reference to the figure object
%   mame:       text that will become the name of file (without extension)
%   height:     factor that multiplies the default 10 cm height
%   AR:         aspect ratio of the figure, changes the width while 
%               maintaining height
%   folder:     (optional) name of the folder in which the figure is saved 
%               (must contain folder identifier '/')
%               (current folder by default)
%               
%   Examples:
%       fig2pdf(fig.myFigure, 'myFigure', 1, 1.5, '.figures/')
%
%       fig2pdf(fig.myFigure, 'myFigure', 1, 1.5)
%
%   Impotant note: the values contained within this function are based on
%   experience, but will consistently output figures with the exact same
%   dimensions.
%
%   -----------------------------------------------------------------------
%   /!\ WARNING /!\
%   -----------------------------------------------------------------------
%   MATLAB WILL ERASE ANY PREVIOUS DOCUMENT THAT HAS THE SAME NAME AND
%   EXTENSION WITHOUT ASKING
%   -----------------------------------------------------------------------
%

% optional argument for folder
if nargin == 4
    folder = '';
end

% in the folder does not exist
if ~exist(folder, 'dir')
    mkdir(folder);
    warning('Missing folder was created to save the Figure.', 'verbose');
end

% settings
print_figures.H = height * 10;
print_figures.W = height * 10 * AR;
margin = 0;
full_name = [folder, name, '.pdf'];

% dimensions of the Figure
set(fig_name, 'PaperPosition', [margin/2 margin/2 print_figures.W print_figures.H])
set(fig_name, 'PaperSize', [print_figures.W+margin print_figures.H+margin])

% printing the figure
print(fig_name, full_name, '-dpdf', '-r300' );

end
