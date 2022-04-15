function fig = main

load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e\activation_analyzed.mat');
A15e = T;
load('E:\Research_Projects\003_Nav15\Experiments\Data\mH1\activation_analyzed.mat');
A15 = T;

V = cat(2,A15e.V_activation{:});
G = cat(2,A15e.G_activation{:});
t = linspace(min(V(:)),max(V(:)),1e3)';
fig = figureNB(8.5,11.5);
h =[];
subplot(3,2,1);
    plot(V,G,'.k','MarkerSize',2); hold on;
    FT = fitSSIcurve(V(V<35),G(V<35),struct('v50',-20,'k',-10,'gmax',1));
    plot(t,FT(t),'k','linewidth',1)
    V = cat(2,A15.V_activation{:});
    G = cat(2,A15.G_activation{:});
    plot(V,G,'.r','MarkerSize',2); hold on;
    FT = fitSSIcurve(V(V<35),G(V<35),struct('v50',-20,'k',-10,'gmax',1));
    plot(t,FT(t),'r','linewidth',1)
    ylim([0,1.2])
    xlim([-100,35])
    gcaformat;
    ylabel('Conductance (G/G_{max})')
    title('Data');
    text(-90,1.05,'Nav1.5e','FontSize',7,'color','k')
    text(-90,0.9,'Nav1.5','FontSize',7,'color','r')

load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e\inactivation_analyzed.mat');
A15e = T;
load('E:\Research_Projects\003_Nav15\Experiments\Data\mH1\inactivation_analyzed.mat');
A15 = T;
idcs = find(isoutlier(A15.v50_SSI));
A15(idcs,:) = [];

V = cat(2,A15e.V_SSI{:});
G = cat(2,A15e.Ipost_SSI{:}); G= 1-G./min(G);
t = linspace(min(V(:)),max(V(:)),1e3)';
subplot(3,2,3);

    plot(V,G,'.k','MarkerSize',2); hold on;
    % errorbar(nanmean(V,2),nanmean(G,2),stderror(G'),'color','k','LineWidth',1); hold on;
    FT = fitSSIcurve(V(V<35),G(V<35),struct('v50',-80,'k',10,'gmax',1));
    
    plot(t,FT(t),'k','linewidth',1)
    V = cat(2,A15.V_SSI{:});
    G = cat(2,A15.Ipost_SSI{:}); G= 1-G./min(G);
    plot(V,G,'.r','MarkerSize',2); hold on;
    FT = fitSSIcurve(V(V<35),G(V<35),struct('v50',-80,'k',10,'gmax',1));
    plot(t,FT(t),'r','linewidth',1)
    ylim([0,1.2])
    xlim([-160,-10])
    gcaformat;
    ylabel('Inactivation (I/I_{max})')

load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e\recovery_analyzed.mat');
A15e = T;
load('E:\Research_Projects\003_Nav15\Experiments\Data\mH1\recovery_analyzed.mat');
A15 = T;

t = linspace(0.01,25,1e3);
subplot(3,2,5);
    V = cat(1,A15e.t_recovery{:})';
    G = cat(2,A15e.I_recovery{:});
    plot(V,G,'.k','MarkerSize',2); hold on;
    FT = FitBiExponential(V(:),G(:));
    plot(t,FT(t),'k','linewidth',1)
    V = cat(1,A15.t_recovery{:})';
    G = cat(2,A15.I_recovery{:});
    plot(V,G,'.r','MarkerSize',2); hold on;
    FT = FitBiExponential(V(:),G(:));
    plot(t,FT(t),'r','linewidth',1)
    xlim([0,25]);
    ylim([0,1.1]);
    gcaformat;
    ylabel('Recovery (I_2/I_1)')


load('C:\Users\brake\Documents\GitHub\Nav2020\figures\dependencies\data\fittingTemplate');
defaultParams = getNav15params(2);

[Q,OpenPositions,P] = nav15_NB_wDIII(defaultParams);
WT15e = simulateprotocols(Q,OpenPositions);

params15 = defaultParams;
params15(19:20) = 3*params15(19:20);

[Q,OpenPositions] = nav15_NB_wDIII(params15);
WT15 = simulateprotocols(Q,OpenPositions);

subplot(3,2,2);
    plot(WT15e.activation.V,WT15e.activation.G,'LineWidth',1,'color','k'); hold on;
    hold on;
    plot(WT15.activation.V,WT15.activation.G,'LineWidth',1,'color','r','LineStyle','--');
    xl = xlabel('Membrane Potential (mV)');
    xl.Position(1) = -120;
    ylim([0,1.2])
    xlim([-100,35])
    title('Model');
    gcaformat;
subplot(3,2,4);
    plot(WT15e.inactivation.V,WT15e.inactivation.I,'LineWidth',1,'color','k');
    hold on;
    plot(WT15.inactivation.V,WT15.inactivation.I,'LineWidth',1,'color','r','LineStyle','--');
    xl=xlabel('Prepulse Potential (mV)');
    xl.Position(1) = -185;
    ylim([0,1.2])
    xlim([-160,-10])
    gcaformat;
subplot(3,2,6);
    plot(WT15e.recovery.t,WT15e.recovery.I,'LineWidth',1,'color','k');
    hold on;
    plot(WT15.recovery.t,WT15.recovery.I,'LineWidth',1,'color','r','LineStyle','--');
    xl=xlabel('Inter-pulse Interval (ms)');
    xl.Position(1) = -5;
    xlim([0,25]);
    ylim([0,1.1]);
    gcaformat;

end