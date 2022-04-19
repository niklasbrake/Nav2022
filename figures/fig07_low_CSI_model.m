function fig = main

    basePath = fileparts(fileparts(mfilename('fullpath')));
    addpath(genpath(basePath));

    fig = figureNB(11.5,6.8);

    labelpanel(0.06,0.95,'A');
        R = fig.Position(4)/fig.Position(3);
        xr = 5.25-0.7;
        yr = 3.2-0.5;
        h = 0.5;
        ax(8) = axes('Position',[0.07,0.5,xr/yr*h*R,h]); 
        annotation('textbox', [0.09,0.95,0.2,0.05],'String','Low CSI model', 'LineStyle','none', 'FontSize',7,'Margin',0,'Color','k');
    drawlowCSImodel;

    labelpanel(0.6,0.95,'B');
        ax(11) = axes('Position',[0.66,0.61,0.23,0.165*2]);
    labelpanel(0.06,0.42,'C');
        ax(9) = axes('Position',[0.1,0.13,0.2,0.14*2]); 
        ax(10) = axes('Position',[0.32,0.13,0.2,0.14*2]); 
    labelpanel(0.52,0.42,'D');
        ax(13) = axes('Position',[0.55,0.13,0.2,0.14*2]); 
    labelpanel(0.75,0.42,'E');
        ax(14) = axes('Position',[0.78,0.13,0.2,0.14*2]); 
    lowCSImodel(ax(9:14));

function lowCSImodel(ax)
    clrs = getColours;
    pars15 = getNav15params(1);
    pars15_DIVCN = getDIVCNparams(pars15,@schemeI);
    pars15_lowCSI = lowCSIparams(pars15,@schemeI);
    pars15_lowCSI_DIVCN = lowCSIparams(pars15_DIVCN,@schemeI);

    V = linspace(-150,60,100);
    for i = 1:length(V)
        [t_inact_WT(:,i),t_open_WT(:,i),t_DIV_WT(:,i),t_DI_III_WT(:,i)] = computemodelCSI(pars15,@schemeI,V(i));
        [t_inact_lowCSI(:,i),t_open_lowCSI(:,i),t_DIV_lowCSI(:,i),t_DI_III_lowCSI(:,i)] = computemodelCSI(pars15_lowCSI,@schemeI,V(i));
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
        A=annotation('textbox',[0.11,0.43,0.19,0.02],'string','Nav1.5e model','FontSize',7,'FontWeight','normal','VerticalAlignment','bottom','HorizontalAlignment','left','Margin',0,'LineStyle','none');
        ylabel(['Median Latency (' char(956) 's)']);
        yticks([0.01,1,100]);
        yticklabels([0.01,1,100])
        text(-145,0.06,'DI-III movement','FontSize',6,'Color','k')
        text(-145,0.02,'DIV movement','FontSize',6,'Color','r')

    axes(ax(2));
        plot(V,1e3*nanmedian(t_DI_III_lowCSI),'color','k','LineWidth',1)
        hold on;
        plot(V,1e3*nanmedian(t_DIV_lowCSI),'color','r','LineWidth',1)
        set(gca,'yscale','log');
        gcaformat;
        xlabel('Voltage (mV)');
        yticks([0.01,1,100]);
        yticklabels([])
        xlim([-150,60]);
        A=annotation('textbox',[0.33,0.43,0.19,0.02],'string','Low CSI model','FontSize',7,'FontWeight','normal','VerticalAlignment','bottom','HorizontalAlignment','left','Margin',0,'LineStyle','none');

    axes(ax(5));
        plotComparison(pars15_lowCSI,@schemeI,'k','square'); 
        plotComparison(pars15_lowCSI,@schemeI_D2CN,clrs(3,:),'v'); 
        local_format;
        A=annotation('textbox',[0.56,0.43,0.19,0.02],'string','DII-CN','FontSize',7,'FontWeight','normal','color',clrs(3,:),'VerticalAlignment','bottom','HorizontalAlignment','left','Margin',0,'LineStyle','none');

    axes(ax(6));
        plotComparison(pars15_lowCSI,@schemeI,'k','square'); 
        plotComparison(pars15_lowCSI_DIVCN,@schemeI,clrs(5,:),'v'); 
        local_format
        A=annotation('textbox',[0.79,0.43,0.19,0.02],'string','DIV-CN','FontSize',7,'FontWeight','normal','color',clrs(5,:),'VerticalAlignment','bottom','HorizontalAlignment','left','Margin',0,'LineStyle','none');

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
