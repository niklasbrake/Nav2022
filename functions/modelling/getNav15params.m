function Params = getNav15params(scheme)
    if(nargin==0)
        error('Please input valid scheme number.');
    end
    if(scheme == 1)
        load('SchemeIParameters_Nav15e_20210507_1233.mat');
    elseif(scheme == 2)
        load('SchemeIIParameters_Nav15e_20220330_1147.mat');
    else
        error('Please input valid scheme number.');
    end
