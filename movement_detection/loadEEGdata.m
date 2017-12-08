function eegraw = loadEEGdata(rootdir)
%% step 1 - convert .bdf to EEG format
bdffnms = findFilesBVQX(rootdir,'*.bdf');
ff = findFilesBVQX(rootdir,'EEGRAW_*.mat');
if ~isempty(ff)
    load(ff{1});
    eegraw = eegraw;
    skipthis = 1;
else
    skipthis = 0;
end
if ~skipthis
    for b = 1:length(bdffnms)
        addpath(genpath('/Users/roee/Starr_Lab_Folder/Data_Analysis/First_Pass_Data_Analysis/code/toolboxes/eeglab14_1_0b'));
        start = tic;
        [pn,fn,ext] = fileparts(bdffnms{b});
        EEG = pop_biosig(bdffnms{b});
        labs = {EEG.chanlocs.labels};
        idxchan = find(cellfun(@(x) any(strfind(x,'EXG')),labs)==1) ;
        eegraw = [];
        for c = 1:length(idxchan)
            eegraw.(labs{idxchan(c)}) = EEG.data(idxchan(c),:);
        end
        idxchan = find(cellfun(@(x) any(strfind(x,'Erg')),labs)==1) ;
        for c = 1:length(idxchan)
            eegraw.(labs{idxchan(c)}) = EEG.data(idxchan(c),:);
        end
        eegraw.srate = EEG.srate;
        save(fullfile(pn,['EEGRAW_' fn '.mat']),'eegraw');
        fprintf('saved file %d out of %d in %f\n',b,length(bdffnms),toc(start));
        restoredefaultpath;
    end
end
rmpath(genpath('/Users/roee/Starr_Lab_Folder/Data_Analysis/First_Pass_Data_Analysis/code/toolboxes/eeglab14_1_0b'));
end
