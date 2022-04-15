function fig  = main

basePath = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(basePath));
clrs = getColours;

Params = getNav15params(2);
[Q,OpenPositions,defaultP] = nav15_NB_wDIII(Params);
WT = simulateprotocols(Q,OpenPositions);
DI = simualteDI_CN(defaultP);
DII = simualteDII_CN(defaultP);
DIII = simualteDIII_CN(defaultP);
DIV = simualteDIV_CN(defaultP);

fig = figureNB(8.5,9);

R = fig.Position(4)/fig.Position(3);
xr = 4.4-0.65;
yr = 3.2-0.5;
w = 0.75;
ax(8) = axes('Position',[0.125,0.5,w,w*yr/R/xr]); 
buildmodeldiagram_DIII;

w2 = 0.15;
h2 = 0.125;
y1 = 0.1;
y2 = 0.33;
x = linspace(0.075,1-0.075-w2,4);

% Plot DI-CN
ax(1) = axes('Position',[x(1),y2,w2,h2]);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DI.activation.V,DI.activation.G,'.','LineWidth',1,'color',clrs(2,:),'MarkerSize',6);
    FT = fitboltzman(DI.activation.V,DI.activation.G,struct('v50',-50,'k',-10));
    plot(DI.activation.V,FT(DI.activation.V),'LineWidth',1,'color',clrs(2,:));
ax(2) = axes('Position',[x(1),y1,w2,h2]);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DI.inactivation.V,DI.inactivation.I,'.','LineWidth',1,'color',clrs(2,:),'MarkerSize',6);
    FT = fitboltzman(DI.inactivation.V,DI.inactivation.I,struct('v50',-100,'k',10));
    plot(DI.inactivation.V,FT(DI.inactivation.V),'LineWidth',1,'color',clrs(2,:));

% Plot DII-CN
ax(3) = axes('Position',[x(2),y2,w2,h2]);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DII.activation.V,DII.activation.G,'.','LineWidth',1,'color',clrs(3,:),'MarkerSize',6);
    FT = fitboltzman(DII.activation.V,DII.activation.G,struct('v50',-50,'k',-10));
    plot(DII.activation.V,FT(DII.activation.V),'LineWidth',1,'color',clrs(3,:));
ax(4) = axes('Position',[x(2),y1,w2,h2]);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DII.inactivation.V,DII.inactivation.I,'.','LineWidth',1,'color',clrs(3,:),'MarkerSize',6);
    FT = fitboltzman(DII.inactivation.V,DII.inactivation.I,struct('v50',-100,'k',10));
    plot(DII.inactivation.V,FT(DII.inactivation.V),'LineWidth',1,'color',clrs(3,:));

% Plot DIII-CN
ax(5) = axes('Position',[x(3),y2,w2,h2]);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIII.activation.V,DIII.activation.G,'.','LineWidth',1,'color',clrs(4,:),'MarkerSize',6);
    FT = fitboltzman(DIII.activation.V,DIII.activation.G,struct('v50',-50,'k',-10));
    plot(DIII.activation.V,FT(DIII.activation.V),'LineWidth',1,'color',clrs(4,:));
ax(6) = axes('Position',[x(3),y1,w2,h2]);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIII.inactivation.V,DIII.inactivation.I,'.','LineWidth',1,'color',clrs(4,:),'MarkerSize',6);
    FT = fitboltzman(DIII.inactivation.V,DIII.inactivation.I,struct('v50',-100,'k',10));
    plot(DIII.inactivation.V,FT(DIII.inactivation.V),'LineWidth',1,'color',clrs(4,:));

% Plot DIV-CN
ax(7) = axes('Position',[x(4),y2,w2,h2]);
    plot(WT.activation.V,WT.activation.G,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIV.activation.V,DIV.activation.G,'.','LineWidth',1,'color',clrs(5,:),'MarkerSize',6);
    FT = fitboltzman(DIV.activation.V,DIV.activation.G,struct('v50',-50,'k',-10));
    plot(DIV.activation.V,FT(DIV.activation.V),'LineWidth',1,'color',clrs(5,:));
ax(8) = axes('Position',[x(4),y1,w2,h2]);
    plot(WT.inactivation.V,WT.inactivation.I,'LineWidth',1,'color',clrs(1,:));
    hold on;
    plot(DIV.inactivation.V,DIV.inactivation.I,'.','LineWidth',1,'color',clrs(5,:),'MarkerSize',6);
    FT = fitboltzman(DIV.inactivation.V,DIV.inactivation.I,struct('v50',-100,'k',10));
    plot(DIV.inactivation.V,FT(DIV.inactivation.V),'LineWidth',1,'color',clrs(5,:));


labelpanel(0.035,0.94,'A');

str = {'DI-CN','DII-CN','DIII-CN','DIV-CN'};
str2 = {'B','C','D','E'};
for i = 1:4
    axes(ax(2*(i-1)+1));
    xlim([-100,35]);
    ylim([0,1]);
    xlabel('Voltage (mV)');
    tlt = title(str{i},'FontSize',7,'FontWeight','bold','color',clrs(1+i,:)); 
    tlt.Position = [mean(get(gca,'xlim')),1.08];
    gcaformat;
    labelpanel(ax(2*(i-1)+1).Position(1)-0.04,0.445,str2{i});
end
for i = 2:2:8
    axes(ax(i));
    xlim([-150,-40]);
    ylim([0,1]);
    xlabel('Voltage (mV)');
    gcaformat;
end

end
function DI = simualteDI_CN(P)
    P.gamma_q = 0.01;
    P.delta_q = -0.01;
    P.gamma_k = P.gamma_k*10;
    P.gamma_ik = P.gamma_ik*10;
    P.delta_ik = P.delta_ik*10;
    P.delta_k = P.delta_k*10;
    P.delta_4k = P.delta_4k*10;
    paramsDI = struct2array(P);
    [Q,OpenPositions,P_DI] = nav15_NB_wDIII(paramsDI);
    DI = simulateprotocols(Q,OpenPositions);
end

function DII = simualteDII_CN(P)
    P.alpha_q = 0.01;
    P.beta_q = -0.01;
    P.alpha_k = P.alpha_k/10;
    P.beta_k = P.beta_k*10;
    paramsDII = struct2array(P);
    [Q,OpenPositions,P_DII] = nav15_NB_wDIII(paramsDII);
    DII = simulateprotocols(Q,OpenPositions);
end

function DIII = simualteDIII_CN(P)
    P.alpha_3q = 0.01;
    P.beta_3q = -0.01;
    P.alpha_3k = P.alpha_3k/5;
    P.beta_3k = P.beta_3k*5;
    paramsDIII = struct2array(P);
    [Q,OpenPositions,P_DIII] = nav15_NB_wDIII(paramsDIII);
    DIII = simulateprotocols(Q,OpenPositions);
end

function DIV = simualteDIV_CN(P)
    P.alpha_4q = 0.01;
    P.beta_4q = -0.01;
    P.alpha_4oq = 0.01;
    P.beta_4oq = -0.01;
    P.alpha_4k = P.alpha_4k*20;
    P.beta_4k = P.beta_4k/20;
    P.alpha_4ok = P.alpha_4ok/50;
    % P.beta_4ok = P.beta_4ok*5;
    paramsDIV = struct2array(P);
    [Q,OpenPositions,P_DIV] = nav15_NB_wDIII(paramsDIV);
    DIV = simulateprotocols(Q,OpenPositions);
end
