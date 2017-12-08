function MAIN()
%% Function to detect movement from EMG input collected with biosemi 
% input - .bdf file 
% ouput - indices of movement start and end 
% reqs - eeglab toolbox 
dirname = uigetdir('choose directory with bdf file');
eegraw = loadEEGdata(dirname);

