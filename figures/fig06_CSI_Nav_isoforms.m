function fig = main

    basePath = fileparts(fileparts(mfilename('fullpath')));
    addpath(genpath(basePath));

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
    a16 = load('Nav1.6\inactivation_analyzed.mat','T');
    a16 = a16.T;
    a14 = load('Nav1.4\inactivation_analyzed.mat','T');
    a14 = a14.T;
    a15 = load('Nav1.5e\inactivation_analyzed.mat','T');
    a15 = a15.T;

    SSI_15 = 1-cat(2,a15.Ipost_SSI{:}).*a15.Imax';
    OSI_15 = cat(2,a15.OSI{:});
    V_SSI_15 = cat(2,a15.V_SSI{:});

    SSI_14 = 1-cat(2,a14.Ipost_SSI{:}).*a14.Imax';
    OSI_14 = cat(2,a14.OSI{:});
    V_SSI_14 = cat(2,a14.V_SSI{:});


    SSI_16 = 1-cat(2,a16.Ipost_SSI{:}).*a16.Imax';
    OSI_16 = cat(2,a16.OSI{:});
    V_SSI_16 = cat(2,a16.V_SSI{:});

    FT_SSI_15 = fitboltzman(V_SSI_15(:),SSI_15(:),struct('v50',-50,'k',10));
    FT_SSI_14 = fitboltzman(V_SSI_14(:),SSI_14(:),struct('v50',-50,'k',10));
    FT_SSI_16 = fitboltzman(V_SSI_16(:),SSI_16(:),struct('v50',-50,'k',10));

    FT_OSI_15 = fitboltzman(V_SSI_15(:),OSI_15(:));
    FT_OSI_14 = fitboltzman(V_SSI_14(:),OSI_14(:));
    FT_OSI_16 = fitboltzman(V_SSI_16(:),OSI_16(:));


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

function explainCSI(ax)
    load('Nav1.5e\20170428c4\inactivation.mat');
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
