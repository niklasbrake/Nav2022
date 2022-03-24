basePath = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(basePath));


load('Nav15parsNB_DIII_20211027.mat');
defaultParams = Params;

% Simulate WT
[Q,OpenPositions,defaultP] = nav15_NB_wDIII(defaultParams);
WT = simulateprotocols(Q,OpenPositions);

% Simulate DI-CN
P = defaultP;
% P.alpha_k = P.alpha_k*5;
% P.beta_k = P.beta_k/2;
P.gamma_k = P.gamma_k*100;
P.gamma_ik = P.gamma_ik*100;
P.delta_ik = P.delta_ik/10;
P.delta_k = P.delta_k/10;
P.delta_4k = P.delta_4k/10;
paramsDI = struct2array(P);
[Q,OpenPositions] = nav15_NB_wDIII(paramsDI);
DI = simulateprotocols(Q,OpenPositions);

% Simulate DII-CN
P = defaultP;
P.alpha_k = P.alpha_k*5;
P.beta_k = P.beta_k/2;
paramsDII = struct2array(P);
[Q,OpenPositions] = nav15_NB_wDIII(paramsDII);
DII = simulateprotocols(Q,OpenPositions);

% Simulate DIII-CN
P = defaultP;
P.alpha_3k = P.alpha_3k*5;
P.beta_3k = P.beta_3k/5;
paramsDIII = struct2array(P);
[Q,OpenPositions] = nav15_NB_wDIII(paramsDIII);
DIII = simulateprotocols(Q,OpenPositions);

% Simulate DIV-CN
P = defaultP;
P.alpha_4k = P.alpha_4k*5;
P.beta_4k = P.beta_4k/5;
paramsDIV = struct2array(P);
[Q,OpenPositions] = nav15_NB_wDIII(paramsDIV);
DIV = simulateprotocols(Q,OpenPositions);


clrs = getColours;
fig = figureNB;
fig.Position = [0,0,9.4,4.7];

% Plot DI-CN
subplot(2,4,1);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DI.activation.V,DI.activation.G,'.','LineWidth',1,'color',clrs(2,:),'MarkerSize',6);
    FT = fitboltzman(DI.activation.V,DI.activation.G,struct('v50',-50,'k',-10));
    plot(DI.activation.V,FT(DI.activation.V),'LineWidth',1,'color',clrs(2,:));
subplot(2,4,5);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DI.inactivation.V,DI.inactivation.I,'.','LineWidth',1,'color',clrs(2,:),'MarkerSize',6);
    FT = fitboltzman(DI.inactivation.V,DI.inactivation.I,struct('v50',-100,'k',10));
    plot(DI.inactivation.V,FT(DI.inactivation.V),'LineWidth',1,'color',clrs(2,:));

% Plot DII-CN
subplot(2,4,2);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DII.activation.V,DII.activation.G,'.','LineWidth',1,'color',clrs(3,:),'MarkerSize',6);
    FT = fitboltzman(DII.activation.V,DII.activation.G,struct('v50',-50,'k',-10));
    plot(DII.activation.V,FT(DII.activation.V),'LineWidth',1,'color',clrs(3,:));
subplot(2,4,6);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DII.inactivation.V,DII.inactivation.I,'.','LineWidth',1,'color',clrs(3,:),'MarkerSize',6);
    FT = fitboltzman(DII.inactivation.V,DII.inactivation.I,struct('v50',-100,'k',10));
    plot(DII.inactivation.V,FT(DII.inactivation.V),'LineWidth',1,'color',clrs(3,:));

% Plot DIII-CN
subplot(2,4,3);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIII.activation.V,DIII.activation.G,'.','LineWidth',1,'color',clrs(4,:),'MarkerSize',6);
    FT = fitboltzman(DIII.activation.V,DIII.activation.G,struct('v50',-50,'k',-10));
    plot(DIII.activation.V,FT(DIII.activation.V),'LineWidth',1,'color',clrs(4,:));
subplot(2,4,7);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIII.inactivation.V,DIII.inactivation.I,'.','LineWidth',1,'color',clrs(4,:),'MarkerSize',6);
    FT = fitboltzman(DIII.inactivation.V,DIII.inactivation.I,struct('v50',-100,'k',10));
    plot(DIII.inactivation.V,FT(DIII.inactivation.V),'LineWidth',1,'color',clrs(4,:));

% Plot DIV-CN
subplot(2,4,4);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIV.activation.V,DIV.activation.G,'.','LineWidth',1,'color',clrs(5,:),'MarkerSize',6);
    FT = fitboltzman(DIV.activation.V,DIV.activation.G,struct('v50',-50,'k',-10));
    plot(DIV.activation.V,FT(DIV.activation.V),'LineWidth',1,'color',clrs(5,:));
subplot(2,4,8);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIV.inactivation.V,DIV.inactivation.I,'.','LineWidth',1,'color',clrs(5,:),'MarkerSize',6);
    FT = fitboltzman(DIV.inactivation.V,DIV.inactivation.I,struct('v50',-100,'k',10));
    plot(DIV.inactivation.V,FT(DIV.inactivation.V),'LineWidth',1,'color',clrs(5,:));


str = {'DI-CN','DII-CN','DIII-CN','DIV-CN'};
for i = 1:4
    subplot(2,4,i);
    xlim([-100,50]);
    ylim([0,1]);
    xlabel('Voltage (mV)');
    tlt = title(str{i},'FontSize',7,'FontWeight','bold','color',clrs(1+i,:)); 
    tlt.Position = [mean(get(gca,'xlim')),1.06];
    gcaformat;
end
for i = 5:8
    subplot(2,4,i);
    xlim([-150,-40]);
    ylim([0,1]);
    xlabel('Voltage (mV)');
    gcaformat;
end
