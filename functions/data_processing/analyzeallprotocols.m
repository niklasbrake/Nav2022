function analyzeallprotocols(folder,fig)
    warning('off','stats:LinearModel:RankDefDesignMat')

    if(nargin<2)
        fig = [];
    end

    % analyze_activation(folder,fig);
    analyze_inactivation(folder,fig);
    % analyze_recovery(folder,fig);
    generate_table(folder);

function analyze_activation(folder,fig)
    F = dir(folder);
    idcs = find([F(:).isdir]);
    idcs = idcs(3:end);
    F = F(idcs);
    goodIdcs = [];
    for i = 1:length(F)
        if(~exist(fullfile(folder,F(i).name,'activation.mat')))
            continue;
        end
        goodIdcs(end+1) = i;
        [V(:,i),G(:,i),I(:,:,i),params(:,i),erev(i),lag(:,i)] = tempgetactivation(fullfile(folder,F(i).name),fig);
        drawnow;
    end
    V = V(:,goodIdcs);
    params = params(:,goodIdcs);
    I = I(:,:,goodIdcs);
    G = G(:,goodIdcs);
    lag = lag(:,goodIdcs);
    erev = erev(goodIdcs);
    cell_id = {F(goodIdcs).name};

    S = struct('v50_activation',params(3,:)','slope_activation',params(2,:),'Erev',erev);
    for j = 1:size(params,2)
        S.V_activation(j) = {V(:,j)};
        S.G_activation(j) = {G(:,j)};
        S.peak_latency(j) = {lag(:,j)};
        S.current_GV(j) = {I(:,:,j)};
    end

    fn = fieldnames(S);
    for i = 1:length(fn)
        temp = S.(fn{i});
        S.(fn{i}) = temp(:);
    end
    T = struct2table(S);
    T.Properties.RowNames = cell_id;

    save(fullfile(folder,'activation_analyzed.mat'),'T');
end

function analyze_inactivation(folder,fig)
    F = dir(folder);
    idcs = find([F(:).isdir]);
    idcs = idcs(3:end);
    F = F(idcs);
    goodIdcs = [];
    for i = 1:length(F)
        if(~exist(fullfile(folder,F(i).name,'inactivation.mat')))
            continue;
        end
        goodIdcs(end+1) = i;
        [V(:,i),post(:,i),I(:,:,i),params(:,i),cap(i),rSeries(i),tau1(:,i),tau2(:,i),n(:,i),CSI(i),OSI(:,i)] = tempgetinactivation(fullfile(folder,F(i).name),fig);
        drawnow;
    end
    tau1 = tau1(:,goodIdcs);
    tau2 = tau2(:,goodIdcs);
    V = V(:,goodIdcs);
    OSI = OSI(:,goodIdcs);
    n = n(:,goodIdcs);
    params = params(:,goodIdcs);
    I = I(:,:,goodIdcs);
    post = post(:,goodIdcs);
    Imax = squeeze(min(min(I)));
    cell_id = {F(goodIdcs).name};
    cap = cap(goodIdcs);
    rSeries = rSeries(goodIdcs);
    CSI = CSI(goodIdcs);

    S = struct('v50_SSI',params(3,:)','slope_SSI',params(2,:),'cap',cap,'rSeries',rSeries,'Imax',Imax,'CSI',CSI);
    for j = 1:size(params,2)
        S.V_SSI(j) = {V(:,j)};
        S.Ipost_SSI(j) = {post(:,j)};
        S.tau1_SSI(j) = {tau1(:,j)};
        S.tau2_SSI(j) = {tau2(:,j)};
        S.n_SSI(j) = {n(:,j)};
        S.current_SSI(j) = {I(:,:,j)};
        S.OSI(j) = {OSI(:,j)};
    end

    fn = fieldnames(S);
    for i = 1:length(fn)
        temp = S.(fn{i});
        S.(fn{i}) = temp(:);
    end
    T = struct2table(S);
    T.Properties.RowNames = cell_id;

    save(fullfile(folder,'inactivation_analyzed.mat'),'T');
end

function analyze_recovery(folder,fig)
    F = dir(folder);
    idcs = find([F(:).isdir]);
    idcs = idcs(3:end);
    F = F(idcs);
    goodIdcs = [];
    gam = []; I = [];
    for i = 1:length(F)
        if(~exist(fullfile(folder,F(i).name,'recovery1ms.mat')))
            continue;
        end
        % try
            [gam(i),t,I(:,i)] = tempgetrecovery(fullfile(folder,F(i).name),fig);
            goodIdcs(end+1) = i;
        % catch
        %     warning(['Error in file ' fullfile(F(i).name,'Recovery1ms.mat')]);
        % end
        drawnow;
    end
    gam = gam(goodIdcs);
    I = I(:,goodIdcs);
    cell_id = {F(goodIdcs).name};

    S = struct('recovery_rate',gam);
    for j = 1:length(gam)
        S.t_recovery(j) = {t};
        S.I_recovery(j) = {I(:,j)};
    end

    fn = fieldnames(S);
    for i = 1:length(fn)
        temp = S.(fn{i});
        S.(fn{i}) = temp(:);
    end
    T = struct2table(S);
    T.Properties.RowNames = cell_id;

    save(fullfile(folder,'recovery_analyzed.mat'),'T');
end

function generate_table(folder)
    act = load(fullfile(folder,'activation_analyzed.mat'));
    inact = load(fullfile(folder,'inactivation_analyzed.mat'));
    recov = load(fullfile(folder,'recovery_analyzed.mat'));

    vnI = inact.T.Properties.VariableNames;
    rnI = inact.T.Properties.RowNames;

    vnA = act.T.Properties.VariableNames;
    rnA = act.T.Properties.RowNames;

    vnR = recov.T.Properties.VariableNames;
    rnR = recov.T.Properties.RowNames;

    cell_ids = union(union(rnI,rnA,'stable'),rnR,'stable');
    M = length(cell_ids);
    [~,IA] = intersect(cell_ids,rnA);
    [~,II] = intersect(cell_ids,rnI);
    [~,IR] = intersect(cell_ids,rnR);

    S = struct();
    S.alpha = repmat({'Nav1.6'},[M,1]);
    S.beta1 = false(M,1);


    S.v50_GV = nan(M,1); S.v50_GV(IA) = act.T.v50_activation;
    S.slope = nan(M,1); S.slope(IA) = act.T.slope_activation;
    S.v50_SSI = nan(M,1); S.v50_SSI(II) = inact.T.v50_SSI;
    S.slope_SSI = nan(M,1); S.slope_SSI(II) = inact.T.slope_SSI;
    S.recovery_rate = nan(M,1); S.recovery_rate(IR) = recov.T.recovery_rate;
    S.CSI = nan(M,1); S.CSI(II) = inact.T.CSI;
    S.Imax = nan(M,1); S.Imax(II) = inact.T.Imax;
    S.Erev = nan(M,1); S.Erev(IA) = act.T.Erev;
    S.rSeries = nan(M,1); S.rSeries(II) = inact.T.rSeries;
    S.cap = nan(M,1); S.cap(II) = inact.T.cap;
    S.V_SSI = cell(M,1); S.V_SSI(II)= inact.T.V_SSI;
    S.SSI = cell(M,1); S.SSI(II)= inact.T.Ipost_SSI;
    S.OSI = cell(M,1); S.OSI(II)= inact.T.OSI;
    S.V_GV = cell(M,1); S.V_GV(IA)= act.T.V_activation;
    S.G_GV = cell(M,1); S.G_GV(IA)= act.T.G_activation;

    T = struct2table(S);
    T.Properties.RowNames = cell_ids;
    save(fullfile(folder,'biophysical_characterization.mat'),'T');
end


end