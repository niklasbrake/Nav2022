function fig = main
    fig = figureNB(11.5,7.2);
    labelpanel(0,0.95,'A');
        ax(1) = axes('Position',[0.03,0.66,0.17,0.15*2]); 
        ax(2) = axes('Position',[0.03,0.367,0.17,0.15*2]);
        ax(3) = axes('Position',[0.03,0.025,0.17,0.15*2]);
    explainCSI(ax(1:3));

    labelpanel(0.25,0.95,'B');
        ax(4) = axes('Position',[0.31,0.62,0.27,0.18*2]); 
    labelpanel(0.63,0.95,'C');
        ax(5) = axes('Position',[0.71,0.62,0.27,0.18*2]); 
    labelpanel(0.25,0.5,'D');
        ax(6) = axes('Position',[0.31,0.12,0.27,0.18*2]); 
    labelpanel(0.63,0.5,'E');
        ax(7) = axes('Position',[0.71,0.12,0.27,0.18*2]); 
    plotCSIcomparison(ax(4:7));

function plotCSIcomparison(ax)
    a16 = load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.6\biophysical_characterization.mat','T'); a16 = a16.T;
    a14 = load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.4\biophysical_characterization.mat','T'); a14 = a14.T;
    a15 = load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e\biophysical_characterization.mat','T'); a15 = a15.T;

    SSI_15 = cat(2,a15.SSI{:}); SSI_15 = 1-SSI_15./min(SSI_15);
    GV_15 = cat(2,a15.G_GV{:});
    OSI_15 = cat(2,a15.OSI{:});
    V_GV_15 = cat(2,a15.V_GV{:});
    GV_15 = GV_15(V_GV_15<35);
    V_GV_15(V_GV_15>=35) = [];
    V_SSI_15 = cat(2,a15.V_SSI{:});

    SSI_14 = cat(2,a14.SSI{:}); SSI_14 = 1-SSI_14./min(SSI_14);
    GV_14 = cat(2,a14.G_GV{:});
    OSI_14 = cat(2,a14.OSI{:});
    V_GV_14 = cat(2,a14.V_GV{:});
    GV_14 = GV_14(V_GV_14<35);
    V_GV_14(V_GV_14>=35) = [];
    V_SSI_14 = cat(2,a14.V_SSI{:});


    SSI_16 = cat(2,a16.SSI{:}); SSI_16 = 1-SSI_16./min(SSI_16);
    GV_16 = cat(2,a16.G_GV{:});
    OSI_16 = cat(2,a16.OSI{:});
    V_GV_16 = cat(2,a16.V_GV{:});
    GV_16 = GV_16(V_GV_16<35);
    V_GV_16(V_GV_16>=35) = [];
    V_SSI_16 = cat(2,a16.V_SSI{:});

    FT_SSI_15 = fitboltzman(V_SSI_15(:),SSI_15(:),struct('v50',-50,'k',10));
    FT_SSI_14 = fitboltzman(V_SSI_14(:),SSI_14(:),struct('v50',-50,'k',10));
    FT_SSI_16 = fitboltzman(V_SSI_16(:),SSI_16(:),struct('v50',-50,'k',10));

    FT_OSI_15 = fitboltzman(V_SSI_15(:),OSI_15(:));
    FT_OSI_14 = fitboltzman(V_SSI_14(:),OSI_14(:));
    FT_OSI_16 = fitboltzman(V_SSI_16(:),OSI_16(:));

    FT_GV_15 = fitboltzman(V_GV_15(:),GV_15(:));
    FT_GV_14 = fitboltzman(V_GV_14(:),GV_14(:));
    FT_GV_16 = fitboltzman(V_GV_16(:),GV_16(:));

    CSI_15 = 1-SSI_15-OSI_15;
    CSI_14 = 1-SSI_14-OSI_14;
    CSI_16 = 1-SSI_16-OSI_16;
    FT_CSI_15 = fitCSIcurve(V_SSI_15(:),CSI_15(:));
    FT_CSI_14 = fitCSIcurve(V_SSI_14(:),CSI_14(:));
    FT_CSI_16 = fitCSIcurve(V_SSI_16(:),CSI_16(:));

    t = linspace(-120,60,1e3);

    axes(ax(1))
        plot(V_SSI_15,OSI_15,'.k','MarkerSize',2); hold on;
        plot(t,FT_OSI_15(t),'k','LineWidth',1);
        plot(V_SSI_14,OSI_14,'.r','MarkerSize',2);
        plot(t,FT_OSI_14(t),'r','LineWidth',1);
        plot(V_SSI_16,OSI_16,'.b','MarkerSize',2);
        plot(t,FT_OSI_16(t),'b','LineWidth',1);
        gcaformat; ylim([0,1.15]);
        xlim([-90,10]);
        xlabel('Voltage (mV)')
        text(-80,1,'Nav1.5e','FontSize',7)
        text(-80,0.9,'Nav1.4','FontSize',7,'Color','r')
        text(-80,0.8,'Nav1.6','FontSize',7,'Color','b')
    axes(ax(2))
        plot(V_SSI_15,SSI_15,'.k','MarkerSize',2); hold on;
        plot(t,FT_SSI_15(t),'k','LineWidth',1);
        plot(V_SSI_14,SSI_14,'.r','MarkerSize',2);
        plot(t,FT_SSI_14(t),'r','LineWidth',1);
        plot(V_SSI_16,SSI_16,'.b','MarkerSize',2);
        plot(t,FT_SSI_16(t),'b','LineWidth',1);
        gcaformat; ylim([0,1.15]);
        xlim([-120,0]);
        xlabel('Voltage (mV)')
    axes(ax(3))
        plot(V_SSI_15,CSI_15,'.k','MarkerSize',2); hold on;
        plot(t,FT_CSI_15(t),'k','LineWidth',1);
        plot(V_SSI_14,CSI_14,'.r','MarkerSize',2);
        plot(t,FT_CSI_14(t),'r','LineWidth',1);
        plot(V_SSI_16,CSI_16,'.b','MarkerSize',2);
        plot(t,FT_CSI_16(t),'b','LineWidth',1);
        gcaformat; ylim([0,1.15]);
        xlim([-120,0]);
        xlabel('Voltage (mV)')
    axes(ax(4))
        b = boxplotNB(1,sum(CSI_15*5),'k',2);
        b.mean.SizeData = 5; b.area.FaceAlpha = 0.25;
        b = boxplotNB(2,sum(CSI_14*5),'r',2);
        b.mean.SizeData = 5; b.area.FaceAlpha = 0.25;
        b = boxplotNB(3,sum(CSI_16*5),'b',2);
        b.mean.SizeData = 5; b.area.FaceAlpha = 0.25;
        gcaformat
        xlim([0.5,3.5])
        xticks([1:3]);
        xticklabels({[char(945) '1.5e'],[char(945) '1.4'],[char(945) '1.6']})
        ylabel('Total CSI (mV)')
        xlabel('Nav channel isoform')
        xax = get(gca,'xaxis');
        % xax.TickLabelRotation = -30

function lowCSImodel(ax)
    clrs = getColours;
    pars15 = getNav15params(1);
    pars15_DIVCN = getDIVCNparams(pars15,@nav15_NB);
    pars15_lowCSI = lowCSIparams(pars15,@nav15_NB);
    pars15_lowCSI_DIVCN = lowCSIparams(pars15_DIVCN,@nav15_NB);

    V = linspace(-150,60,100);
    for i = 1:length(V)
        % [t_inact_WT(:,i),t_open_WT(:,i)] = computemodelCSI(pars15,@nav15_NB,V(i));
        % [t_inact_lowCSI(:,i),t_open_lowCSI(:,i)] = computemodelCSI(pars15_lowCSI,@nav15_NB,V(i));
        % [t_inact_lowCSI_DII(:,i),t_open_lowCSI_DII(:,i)] = computemodelCSI(pars15_lowCSI,@nav15minusC1_NB,V(i));
        % [t_inact_lowCSI_DIV(:,i),t_open_lowCSI_DIV(:,i)] = computemodelCSI(pars15_lowCSI_DIVCN,@nav15_NB,V(i));
        [t_inact_WT(:,i),t_open_WT(:,i),t_DIV_WT(:,i),t_DI_III_WT(:,i)] = computemodelCSI(pars15,@nav15_NB,V(i));
        [t_inact_lowCSI(:,i),t_open_lowCSI(:,i),t_DIV_lowCSI(:,i),t_DI_III_lowCSI(:,i)] = computemodelCSI(pars15_lowCSI,@nav15_NB,V(i));
    end

    axes(ax(3));
        plot(V,mean(t_inact_WT<t_open_WT,1),'-','color',[0.6,0.6,0.6],'LineWidth',1); hold on;
        plot(V,mean(t_inact_lowCSI<t_open_lowCSI,1),'-','color','k','LineWidth',1);
        local_format;
        set(get(gca,'yaxis'),'visible','on');
        yticks([0,1]);
        ylabel('Prob. CSI');
        text(-120,1,'Nav1.5e model','FontSize',6,'Color',[0.6,0.6,0.6])
        A = annotation('textbox','position',[0.75 0.33 0.1306 0.0185],'string','Low CSI model', ...
            'Margin',0,'LineStyle','none','Color','k','FontSize',6, ...
            'BackgroundColor','w','VerticalAlignment','middle','HorizontalAlignment','left');
    
    axes(ax(1));
        plot(V,1e3*nanmedian(t_DI_III_WT),'color','k','LineWidth',1)
        hold on;
        plot(V,1e3*nanmedian(t_DIV_WT),'color','r','LineWidth',1)
        set(gca,'yscale','log');
        gcaformat;
        xlabel('Voltage (mV)');
        xlim([-150,60]); ylim([1e-2,1e2])
        A=annotation('textbox',[0.11,0.21,0.19,0.02],'string','Nav1.5e model','FontSize',7,'FontWeight','normal','VerticalAlignment','middle','HorizontalAlignment','left','Margin',0,'LineStyle','none');
        ylabel(['Median Latency (' char(956) 's)']);
        yticks([0.01,1,100]);
        yticklabels([0.01,1,100])
        text(-145,0.06,'DI-III movement','FontSize',6,'Color','k')
        text(-145,0.02,'DIV movement','FontSize',6,'Color','r')

    axes(ax(2));
        % plot(V,median(1e3*t_inact_lowCSI,1),'-','color','k','LineWidth',1); hold on;
        % plot(V,median(1e3*t_open_lowCSI,1),'--','color','k','LineWidth',1);
        % local_format
        % ylim([0.01,100]); set(gca,'yscale','log'); set(get(gca,'yaxis'),'visible','on');
        % yax = get(gca,'yaxis'); yax.MinorTickValues = [0.1,10];
        % yl = ylabel('Latency (ms)');
        % yl.Position(1) = -225;
        % L = legend('Inactivation','Pore opening');
        % L.Box = 'off';
        % L.ItemTokenSize = [7.5,5];
        % L.Position = [0.32,0.059,0.165,0.05];
        plot(V,1e3*nanmedian(t_DI_III_lowCSI),'color','k','LineWidth',1)
        hold on;
        plot(V,1e3*nanmedian(t_DIV_lowCSI),'color','r','LineWidth',1)
        set(gca,'yscale','log');
        gcaformat;
        xlabel('Voltage (mV)');
        yticks([0.01,1,100]);
        yticklabels([])
        xlim([-150,60]);
        A=annotation('textbox',[0.33,0.21,0.19,0.02],'string','Low CSI model','FontSize',7,'FontWeight','normal','VerticalAlignment','middle','HorizontalAlignment','left','Margin',0,'LineStyle','none');

    axes(ax(5));
        plotComparison(pars15_lowCSI,@nav15_NB,'k','square'); 
        plotComparison(pars15_lowCSI,@nav15minusC1_NB,clrs(3,:),'v'); 
        local_format;
        A=annotation('textbox',[0.56,0.21,0.19,0.02],'string','DII-CN','FontSize',7,'FontWeight','normal','color',clrs(3,:),'VerticalAlignment','middle','HorizontalAlignment','left','Margin',0,'LineStyle','none');

    axes(ax(6));
        plotComparison(pars15_lowCSI,@nav15_NB,'k','square'); 
        plotComparison(pars15_lowCSI_DIVCN,@nav15_NB,clrs(5,:),'v'); 
        local_format
        A=annotation('textbox',[0.79,0.21,0.19,0.02],'string','DIV-CN','FontSize',7,'FontWeight','normal','color',clrs(5,:),'VerticalAlignment','middle','HorizontalAlignment','left','Margin',0,'LineStyle','none');

    % axes(ax(5));
    %     plot(V,median(1e3*t_inact_lowCSI_DII,1),'-','color',clrs(3,:),'LineWidth',1); hold on;
    %     plot(V,median(1e3*t_open_lowCSI_DII,1),'--','color',clrs(3,:),'LineWidth',1);
    %     local_format
    %     ylim([0.01,100]); set(gca,'yscale','log'); set(get(gca,'yaxis'),'visible','on');
    %     yax = get(gca,'yaxis'); yax.MinorTickValues = [0.1,10]; yticklabels({});


    % axes(ax(6));
    %     plot(V,median(1e3*t_inact_lowCSI_DIV,1),'-','color',clrs(5,:),'LineWidth',1); hold on;
    %     plot(V,median(1e3*t_open_lowCSI_DIV,1),'--','color',clrs(5,:),'LineWidth',1);
    %     local_format
    %     ylim([0.01,100]); set(gca,'yscale','log'); set(get(gca,'yaxis'),'visible','on');
    %     yax = get(gca,'yaxis'); yax.MinorTickValues = [0.1,10]; yticklabels({});


    function plotComparison(params,modelfunction,clr,markerType)
        [Q,OpenPositions] = modelfunction(params);
        output = simulateprotocols(Q,OpenPositions);
        plot(output.activation.V,output.activation.G,'Marker',markerType,'Color',clr,'MarkerSize',5,'LineWidth',1.5); drawnow; hold on;
        h = plot(output.activation.V,output.activation.G,'Marker',markerType,'Color',clr,'MarkerSize',5,'LineWidth',1.5); drawnow; 
        hold on;
        set(h.NodeChildren(1),'LineWidth',0.75);
        h1 = plot(output.inactivation.V,output.inactivation.I,'Marker',markerType','Color',clr,'MarkerSize',5,'LineWidth',1.5); drawnow; 
        set(h1.NodeChildren(1),'LineWidth',0.75);

    function paramsCSI = lowCSIparams(defaultParams,modelfunction)
        [~,~,P] = modelfunction(defaultParams);
        paramsCSI = defaultParams;
        idx = find(strcmp(fieldnames(P),'alpha_4k'));
        paramsCSI(idx) = paramsCSI(idx)/20;
        idx = find(strcmp(fieldnames(P),'beta_4k'));
        paramsCSI(idx) = 20*paramsCSI(idx);
        idx = find(strcmp(fieldnames(P),'alpha_4ok'));
        paramsCSI(idx) = paramsCSI(idx)*20;
        idx = find(strcmp(fieldnames(P),'beta_4ok'));
        paramsCSI(idx) = 0.05*paramsCSI(idx);


    function paramsDIVCN = getDIVCNparams(defaultParams,modelfunction)
        [~,~,P] = modelfunction(defaultParams);
        paramsDIVCN = defaultParams;
        idx = find(strcmp(fieldnames(P),'alpha_4k'));
        paramsDIVCN(idx) = 20*paramsDIVCN(idx);
        idx = find(strcmp(fieldnames(P),'alpha_4ok'));
        paramsDIVCN(idx) = 20*paramsDIVCN(idx);
        idx = find(strcmp(fieldnames(P),'beta_4ok'));
        paramsDIVCN(idx) = 0.05*paramsDIVCN(idx);
        idx = find(strcmp(fieldnames(P),'beta_4k'));
        paramsDIVCN(idx) = 0.05*paramsDIVCN(idx);

    function local_format
        gcaformat;
        xlim([-150,60]); ylim([0,1]); ylabel('');
        set(get(gca,'yaxis'),'visible','off');
        ch = get(gca,'Children');
        for i = 1:length(ch)
            ch(i).MarkerSize=3;
            ch(i).LineWidth=0.75;
        end
        set(gca,'xtick',[-120:60:60]);
        xlabel('Voltage (mV)');

function explainCSI(ax)
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e\ASM_20170428_cell4\inactivation.mat');
    PN1 = Current(:,Epochs(7)-1e3:Epochs(7)+5e3);
    PN1 = (PN1-median(PN1(:,1:1e3),2));
    PN2 = Current(:,Epochs(3)-1e3:Epochs(3)+5e3);
    PN2 = -(PN2-median(PN2(:,1:1e3),2));
    PN = mean(0.5*(PN1*0+2*PN2));

    C1 = zeros(2e3+1,size(Current,1));
    Cfit1 = zeros(2e3+1,size(Current,1));
    for j = 1:size(Current,1)
        response = Current(j,Epochs(4)-1e3:Epochs(4)+5e3);
        C1(:,j) = PNsubtract(PN,response);
        Cfit1(:,j) = fitHH(C1(35:end,j),-1);
    end

    t = 0:2e3; t = t(:);
    axes(ax(1));
        idx = 17;
        y = C1(:,idx);
        y(y>10) = nan;
        plot(downsample(t,20),downsample(y,20),'.k','MarkerSize',1); hold on;
        plot(t,Cfit1(:,idx),'r'); hold on;
        scatter(0,35,10,'k','filled','v')
        text(0,40,'-80 mV','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',6);
        [~,idx0] = max(abs(Cfit1(:,idx)));
        fill([t;flip(t)],[Cfit1(1:idx0,idx);C1(idx0+1:end,idx);0*t],'k','FaceAlpha',0.2,'LineWidth',0.25);
        ylim([-125,60]); 
        xlim([-100,2e3]);
        line([1e3,1e3],[-25,-75],'LineWidth',1,'color','k')
        text(1.1e3,-50,'50 pA','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',6);
        axis off;
    axes(ax(2));
        idx = 23;
        y = C1(:,idx);
        y(y>10) = nan;
        plot(downsample(t,20),downsample(y,20),'.k','MarkerSize',1); hold on;
        scatter(0,25,10,'k','filled','v')
        text(0,30,'-50 mV','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',6);
        plot(t,Cfit1(:,idx),'r'); hold on;
        [~,idx0] = max(abs(Cfit1(:,idx)));
        fill([t;flip(t)],[Cfit1(1:idx0,idx);C1(idx0+1:end,idx);0*t],'k','FaceAlpha',0.2,'LineWidth',0.25);
        ylim([-150,35]); 
        xlim([-100,2e3]);
        line([1e3,1e3],[-50,-100],'LineWidth',1,'color','k')
        text(1.1e3,-75,'50 pA','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',6);
        axis off;
    axes(ax(3));
        idx = 29;
        plot(t,C1(:,idx),'.k','MarkerSize',1); hold on;
        scatter(0,900,10,'k','filled','v')
        text(0,1.1e3,'-20 mV','HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',6);
        [~,idx0] = max(abs(Cfit1(:,idx)));
        fill([t;flip(t)],[Cfit1(1:idx0,idx);C1(idx0+1:end,idx);0*t],'k','FaceAlpha',0.2,'LineWidth',0.25);
        ylim([-6500,900]); 
        xlim([-100,2e3]);
        axis off;
        line([1e3,1e3],[-2e3,-4e3],'LineWidth',1,'color','k')
        text(1.1e3,-3e3,'2 nA','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',6);
        line([1e3,1.5e3],[-4e3,-4e3],'LineWidth',1,'color','k')
        text(1.25e3,-4.1e3,'5 ms','HorizontalAlignment','center','VerticalAlignment','top','FontSize',6);

    function pnY = PNsubtract(PNx,Y)
        ty = [zeros(1,1000),ones(1,5001)];
        FT = fitlm(ty,PNx);
        PNy = detrend(PNx-ty*FT.Coefficients{2,1});
        PNy = PNy(1e3:3e3);

        temp = Y-median(Y(1:1e3));
        idcs = setdiff(1:6e3,1e3:2e3);
        FT = fitlm(ty(idcs),temp(idcs));
        temp = temp-ty*FT.Coefficients{2,1};
        
        rawResponse = temp(1e3:3e3);
        FT = fitlm(PNy(1:50),rawResponse(1:50));
        A = FT.Coefficients{2,1};
        pnY = rawResponse-A*PNy;

    function [I,tau1,tau2,n] = fitHH(C1,sgn)
        t = -33:length(C1); t= t(:);
        fun = fittype(@(gam1,gam2,A,x0,n,m,d,x) 0*d+(x>x0).*(A*(1 - exp(-(x-x0)*gam1)).^n.*exp(-(x-x0)*gam2).^m));

        [m,I] = max(abs(C1));
        StartPoint = [0.3,0.2,C1(I),20,2,1,0];
        Lower = [1/500,1/500,0,0,0.2,0.2,-m];
        Upper = [1,1,m*10,100,4,4,m];

        if(nargin==2)
            FT = fit(t(35:end),sgn*C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = sgn*FT(t);
        else     
            if(C1(I)<0)
                FT = fit(t(35:end),-C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
                I = -FT(t);
            else
                FT = fit(t(35:end),C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
                I = FT(t);
            end
        end
        tau1 = FT.gam1.^(-1)/100;
        tau2 = FT.gam2.^(-1)/100;
        n = FT.n;

function drawlowCSImodel

    temp = lines(3);
    clrs(2,:) = temp(3,:);

    X1 = text(1,3,'I_{4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X2 = text(2,3,'I_{14}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X3 = text(3,3,'I_{24}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X4 = text(4,3,'I_{34}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X5 = text(5,3,'I_{}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X6 = text(1,2,'C_{4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X7 = text(2,2,'C_{14}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X8 = text(3,2,'C_{24}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X9 = text(4,2,'C_{34}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X10 = text(5,2,'O_{4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X11 = text(1,1,'C_{0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X12 = text(2,1,'C_{1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X13 = text(3,1,'C_{2}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X14 = text(4,1,'C_{3}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    X15 = text(5,1,'O_{}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
    set(get(gca,'XAxis'),'Visible','off')
    set(get(gca,'YAxis'),'Visible','off')
    xlim([0.7,5.25]);
    ylim([0.5 3.2]);

    hold on;

    horizontalLines(X1,X2);
    horizontalLines(X2,X3);
    horizontalLines(X3,X4);
    horizontalLines(X4,X5);

    horizontalLines(X6,X7);
    horizontalLines(X7,X8);
    horizontalLines(X8,X9);
    horizontalLines(X9,X10);

    horizontalLines(X11,X12);
    horizontalLines(X12,X13);
    horizontalLines(X13,X14);
    horizontalLines(X14,X15);

    verticalLines(X1,X6);
    verticalLines(X2,X7);
    verticalLines(X3,X8);
    verticalLines(X4,X9);
    verticalLines(X5,X10);

    verticalLine(X6,X11,false);
    verticalLine(X7,X12,false);
    verticalLine(X8,X13,false);
    verticalLine(X9,X14,false);
    verticalLine(X10,X15,true);

    pos = get(gca,'Position');
    pos = get(gca,'Position');
    xl = get(gca,'xlim');
    yl = get(gca,'ylim');
    figCox = @(x) pos(1)+pos(3)*(x-xl(1))/range(xl);
    figCoy = @(y) pos(2)+pos(4)*(y-yl(1))/range(yl);

    function horizontalLines(X1,X2)
        pos = get(gca,'Position');
        pos = get(gca,'Position');
        xl = get(gca,'xlim');
        yl = get(gca,'ylim');
        figCox = @(x) pos(1)+pos(3)*(x-xl(1))/range(xl);
        figCoy = @(y) pos(2)+pos(4)*(y-yl(1))/range(yl);
        y1 = X1.Extent(2)+X1.Extent(4)/2+0.05;
        y2 = X2.Extent(2)+X2.Extent(4)/2;
        x1 = X1.Extent(1)+X1.Extent(3);
        x2 = X2.Extent(1);
        offset = 0.04;
        annotation('arrow',figCox([x1+offset,x2-offset]),figCoy([y1+0.025 y1+0.025]),'HeadWidth',3,'HeadLength',3,'HeadStyle','vback2');
        annotation('arrow',figCox([x2-offset,x1+offset]),figCoy([y1-0.025 y1-0.025]),'HeadWidth',3,'HeadLength',3,'HeadStyle','vback2');


    function verticalLines(X1,X2)
        pos = get(gca,'Position');
        pos = get(gca,'Position');
        xl = get(gca,'xlim');
        yl = get(gca,'ylim');
        figCox = @(x) pos(1)+pos(3)*(x-xl(1))/range(xl);
        figCoy = @(y) pos(2)+pos(4)*(y-yl(1))/range(yl);
        y1 = X1.Extent(2);
        y2 = X2.Extent(2)+X2.Extent(4);
        x1 = X1.Position(1);
        x2 = X2.Position(1);
        ws=0.1;
        offset = 0.01;
        annotation('arrow',figCox([x1+0.025,x2+0.025]),figCoy([y1-offset y2+offset]),'HeadWidth',3,'HeadLength',3,'HeadStyle','vback2');
        annotation('arrow',figCox([x1-0.025,x1-0.025]),figCoy([y2+offset y1-offset]),'HeadWidth',3,'HeadLength',3,'HeadStyle','vback2');


    function verticalLine(X1,X2,forward)
        clrs = lines(6);
        clrs(1,:) = [0,0,0];
        clrs(2,:) = clrs(6,:);
        pos = get(gca,'Position');
        pos = get(gca,'Position');
        xl = get(gca,'xlim');
        yl = get(gca,'ylim');
        figCox = @(x) pos(1)+pos(3)*(x-xl(1))/range(xl);
        figCoy = @(y) pos(2)+pos(4)*(y-yl(1))/range(yl);
        y1 = X1.Extent(2);
        y2 = X2.Extent(2)+X2.Extent(4);
        x1 = X1.Position(1);
        x2 = X2.Position(1);
        ws=0.1;
        offset = 0.01;
        if(forward)
            A = annotation('arrow',figCox([x1,x1]),figCoy([y2+offset y1-offset]),'HeadWidth',10,'HeadLength',10,'HeadStyle','vback2');
        else
            A = annotation('arrow',figCox([x1,x1]),figCoy([y1+offset,y2-offset]),'HeadWidth',10,'HeadLength',10,'HeadStyle','vback2');
        end
        A.Color = 'k';
        A.LineWidth = 2;
