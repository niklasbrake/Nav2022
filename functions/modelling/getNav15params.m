function Params = getNav15params(scheme)
    if(nargin==0)
        error('Please input valid scheme number.');
    end
    if(scheme == 1)
        load('Nav15ParsNB_20210507_1233.mat');
    elseif(scheme == 2)
        load('Nav15parsNB_DIII_20220330.mat');
    else
        error('Please input valid scheme number.');
    end
