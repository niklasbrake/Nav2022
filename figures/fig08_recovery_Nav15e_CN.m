function fig = main
    clrs = getColours;
    fig = figureNB(8.5,12);
    figh = fig.Position(4);

    ex(1) = load(fullfile('E:\Research_Projects\003_Nav15\Experiments\Niklas','Nav1.5e','20211111c5','recovery1ms.mat'));
    ex(2) = load(fullfile('C:\Users\brake\Documents\GitHub\Nav-2020-private\figures\dependencies\data','Nav1.5e-D1','20180307c1','recovery1ms.mat'));
    ex(3) = load(fullfile('C:\Users\brake\Documents\GitHub\Nav-2020-private\figures\dependencies\data','Nav1.5e-D2','20180316c2','recovery1ms.mat'));
    ex(4) = load(fullfile('C:\Users\brake\Documents\GitHub\Nav-2020-private\figures\dependencies\data','Nav1.5e-D3','20180712c1','recovery1ms.mat'));
    ex(5) = load(fullfile('C:\Users\brake\Documents\GitHub\Nav-2020-private\figures\dependencies\data','Nav1.5e-D4','20190309c1','recovery1ms.mat'));


    labelpanel(0,0.95,'A')
    labelpanel(0.48,0.95,'B')
    labelpanel(0.48,0.55,'C')
    labelpanel(0.48,0.241,'D')

    ax = axes('Position',[0.01 0.9 0.42 0.08]);
    line([-16,-11],[-100,-100],'color','k');
        line([-11,-11],[-100,-10],'color','k');
    line([-11,-4],[-10,-10],'color','k');
        text(-3,-6,'\cdot\cdot\cdot','FontSize',8,'HorizontalAlignment','center','VerticalAlignment','middle');
    line([-2,0],[-10,-10],'color','k');
        line([0,0],[-100,-10],'color','k');
    line([0,6],[-100,-100],'color','k');
        line([6,6],[-10,-100],'color','k');
    line([6,10],[-10,-10],'color','k');
    text(-11,-9,' -10 mV','FontSize',6, ...
            'HorizontalAlignment','left','VerticalAlignment','bottom');
    text(-11,-15,'  80 ms','FontSize',6, ...
            'HorizontalAlignment','left','VerticalAlignment','top');
    ylim([-110,0]);
    xlim([-13,9]);
    axis off;
    AP = ax.Position;
    XL = ax.XLim;
    YL = ax.YLim;
    a2fX = @(x) AP(1) + (x-XL(1))/range(XL)*AP(3);
    a2fY = @(x) AP(2) + (x-YL(1))/range(YL)*AP(4);
    A = annotation('doublearrow',a2fX([0,6]),a2fY([-15,-15]));
    A.Head1Length = 3; A.Head1Width = 3;
    A.Head2Length = 3; A.Head2Width = 3;
    text(3,-8,'1-25 ms','FontSize',6, ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
    text(3,-101,'-130 mV','FontSize',6, ...
            'HorizontalAlignment','center','VerticalAlignment','top');

    ys = 0.71;
    
    str = {'Nav1.5e','DI-CN','DII-CN','DIII-CN','DIV-CN'};
    for i = 1:5
        ax(i) = axes('Position',[0.01 ys-0.17*(i-1) 0.42 0.15]);
        plotRecoveryData(ex(i),ax(i),clrs(i,:));
        text(-8,-0.5,str{i},'color',clrs(i,:),'FontSize',7);
        if(i==5)
            line(-8+[0,2.5],-[0.8,0.8],'color','k','LineWidth',1);
            text(-8+2.5/2,-0.83,'5 ms','FontSize',6, ...
            'VerticalAlignment','top','HorizontalAlignment','center');
        end
    end

    load('E:\Research_Projects\003_Nav15\Experiments\Niklas\Nav1.5e\recovery_analyzed.mat');    WT = T;
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D1\recovery_analyzed.mat');   D1 = T;
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D2\recovery_analyzed.mat');   D2 = T;
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D3\recovery_analyzed.mat');   D3 = T;
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D4\recovery_analyzed.mat');   D4 = T;

    t = 1:25;
    I_WT = cat(2,WT.I_recovery{:});
    I_D1 = cat(2,D1.I_recovery{:});
    I_D2 = cat(2,D2.I_recovery{:});
    I_D3 = cat(2,D3.I_recovery{:});
    I_D4 = cat(2,D4.I_recovery{:});

    FT_WT = FitBiExponential(cat(1,WT.t_recovery{:})',I_WT);
    FT_D1 = FitBiExponential(cat(1,D1.t_recovery{:})',I_D1);
    FT_D2 = FitBiExponential(cat(1,D2.t_recovery{:})',I_D2);
    FT_D3 = FitBiExponential(cat(1,D3.t_recovery{:})',I_D3);
    FT_D4 = FitBiExponential(cat(1,D4.t_recovery{:})',I_D4);
    

    axes('Position',[0.69,0.9,0.15,0.08]);
        plot(t(:)+0.3*randn(size(I_WT)),I_WT,'.','color',clrs(1,:),'MarkerSize',2); hold on;
        % plot(t(:),FT_WT(t(:)),'color',clrs(1,:),'LineWidth',1)
        gcaformat; ylim([0,1.1]); yticks([0,1]); xlim([0,25]);
    axes('Position',[0.58,0.77,0.15,0.08]);
        plot(t(:)+0.3*randn(size(I_D1)),I_D1,'.','color',clrs(2,:),'MarkerSize',2); hold on;
        % plot(t(:),FT_WT(t(:)),'color',clrs(1,:),'LineStyle','--')
        % plot(t(:),FT_D1(t(:)),'color',clrs(2,:),'LineWidth',1)
        gcaformat; ylim([0,1.1]); yticks([0,1]); xlim([0,25]);
         set(get(gca,'xaxis'),'visible','off'); 
         ylabel('Fraction recovered (I_{post}/I_{pre})')
    axes('Position',[0.8,0.77,0.15,0.08]);
        plot(t(:)+0.3*randn(size(I_D2)),I_D2,'.','color',clrs(3,:),'MarkerSize',2); hold on;
        % plot(t(:),FT_WT(t(:)),'color',clrs(1,:),'LineStyle','--')
        % plot(t(:),FT_D2(t(:)),'color',clrs(3,:),'LineWidth',1)
        gcaformat; ylim([0,1.1]); yticks([0,1]); xlim([0,25]);
         set(get(gca,'xaxis'),'visible','off'); 
    axes('Position',[0.58,0.66,0.15,0.08]);
        plot(t(:)+0.3*randn(size(I_D3)),I_D3,'.','color',clrs(4,:),'MarkerSize',2); hold on;
        % plot(t(:),FT_WT(t(:)),'color',clrs(1,:),'LineStyle','--')
        % plot(t(:),FT_D3(t(:)),'color',clrs(4,:),'LineWidth',1)
        gcaformat; ylim([0,1.1]); yticks([0,1]); xlim([0,25]);
         % set(get(gca,'xaxis'),'visible','off'); 
    axes('Position',[0.8,0.66,0.15,0.08]);
        plot(t(:)+0.3*randn(size(I_D4)),I_D4,'.','color',clrs(5,:),'MarkerSize',2); hold on;
        % plot(t(:),FT_WT(t(:)),'color',clrs(1,:),'LineStyle','--')
        % plot(t(:),FT_D4(t(:)),'color',clrs(5,:),'LineWidth',1)
        gcaformat; ylim([0,1.1]); yticks([0,1]); xlim([0,25]);
        xl = xlabel('Inter-pulse interval (ms)');
        xl.Position = [-6.6,-0.55,-1];


    ax = axes('Position',[0.58 0.355 0.35 0.22]);
        BP = boxplotNB(0,WT.recovery_rate,clrs(1,:),5); delete(BP.mean);
        BP = boxplotNB(1,D1.recovery_rate,clrs(2,:),5); delete(BP.mean);
        BP = boxplotNB(2,D2.recovery_rate,clrs(3,:),5); delete(BP.mean);
        BP = boxplotNB(3,D3.recovery_rate,clrs(4,:),5); delete(BP.mean);
        BP = boxplotNB(4,D4.recovery_rate,clrs(5,:),5); delete(BP.mean);
        xlim([-1,5]);
        gcaformat;
        ylabel('Recovery rate (1/ms)')
        xticks([0:4]);
        xticklabels({'Nav1.5e','DI-CN','DII-CN','DIII-CN','DIV-CN'});
        xax = get(gca,'xaxis');
        xax.TickLabelRotation=-30;


    load('E:\Research_Projects\003_Nav15\Experiments\Niklas\Nav1.5e\inactivation_analyzed.mat');    WT = combinetables(WT,T); WT.SSI130 = getSSI130(WT);
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D1\inactivation_analyzed.mat');   D1 = combinetables(D1,T); D1.SSI130 = getSSI130(D1);
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D2\inactivation_analyzed.mat');   D2 = combinetables(D2,T); D2.SSI130 = getSSI130(D2);
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D3\inactivation_analyzed.mat');   D3 = combinetables(D3,T); D3.SSI130 = getSSI130(D3);
    load('E:\Research_Projects\003_Nav15\Experiments\Data\Nav1.5e-D4\inactivation_analyzed.mat');   D4 = combinetables(D4,T); D4.SSI130 = getSSI130(D4);

    ax = axes('Position',[0.58 0.046 0.35 0.22]);
    plot(WT.recovery_rate,WT.SSI130,'.','MarkerSize',15,'color',clrs(1,:)); hold on;
    plot(D1.recovery_rate,D1.SSI130,'.','MarkerSize',15,'color',clrs(2,:)); hold on;
    plot(D2.recovery_rate,D2.SSI130,'.','MarkerSize',15,'color',clrs(3,:)); hold on;
    plot(D3.recovery_rate,D3.SSI130,'.','MarkerSize',15,'color',clrs(4,:)); hold on;
    plot(D4.recovery_rate,D4.SSI130,'.','MarkerSize',15,'color',clrs(5,:)); hold on;
    gcaformat;
    set(gca,'XAxisLocation','origin')
    ylim([-0.1,0.6]);
    xlim([0.05,0.45]);
    ylabel('SSI @ -130 mV');
    xl = xlabel('Recovery rate @ -130 mV (1/ms)');
    xl.Position = [0.5,-0.22,-1];

end


function plotRecoveryData(data,ax,clr)
    axes(ax);
    X = data.Current(:,data.Epochs(5)-400:data.Epochs(5)+5000)';
    pre = mean(data.Current(:,data.Epochs(4)-2500:data.Epochs(4)+1200));
    [pre,post] = removeCapactiveTransient(data.Current,data.Epochs);
    % pre(1:30) = nan;
    % for i = 2:size(X,2)
        % X(500:501+(i-1)*100+35,i) = nan;
    % end
    mX = max(abs(pre));
    plot((-1e3:1200)/200-11,pre/mX,'color',clr,'LineWidth',0.5); hold on;
    for i = 12:-1:1
        h=plot((-400:5000)/200,post(:,i)/mX,'color',clr,'LineWidth',0.5);
        h.Color(4) = max(max(abs(post(:,i)))/mX,0.1);
    end
    xlim([-13,9]);
    ylim([-1.1,0.1]);
    axis off;
end

function T = combinetables(T1,T2)
    rn1 = T1.Properties.RowNames;
    rn2 = T2.Properties.RowNames;
    [~,I1,I2] = intersect(rn1,rn2);
    T = [T1(I1,:) T2(I2,:)];
end

function SSI130 = getSSI130(T)
    SSI130 = zeros(size(T,1),1);
    for i = 1:size(T,1)
        I = T.Ipost_SSI{i};
        V = T.V_SSI{i};
        FT = fitSSIcurve(V(V>-150),I(V>-150));
        SSI130(i) = interp1(V,I*FT.Gmx,-130);
    end
end

function [Ipre,Ipost] = removeCapactiveTransient(Current,Epochs)
    IBL = median(median(Current(:,Epochs(4)-1e3:Epochs(4))));
    inter = zeros(3501,size(Current,1));

    for i = 1:size(Current,1)
        inter(:,i) = Current(i,Epochs(5)-1e3:Epochs(6)+100*24);
        inter(1001+100*i+1:end,i) = nan;
    end
    inter = nanmean(inter,2)';
    inter = inter-IBL;
    inter(1100:end) = smooth(inter(1100:end),100);

    I0 = median(inter(1:1e3));


    C1 = zeros(2201,size(Current,1));
    C2 = zeros(5401,size(Current,1));
    for j = 1:size(Current,1)
        Y = Current(j,Epochs(4)-1e3:Epochs(4)+1200);
        response = Y-IBL;
        response(1001:end) = response(1001:end)-I0;
        C1(:,j) = response;

        response = Current(j,Epochs(5)-1e3:Epochs(5)+5e3)-IBL;
        response(1:1e3+100*j+1) = response(1:1e3+100*j+1)-inter(1:1e3+100*j+1);
        response(1e3+100*j+1:end) = response(1e3+100*j+1:end)-I0;
        C2(:,j) = response(601:end);
    end


    BL = zeros(1500,1);
    for j =1:size(Current,1)
        C2_aligned(:,j) = C2(400+j*100+1:400+j*100+1500,j);
    end

    x = log(1:25);
    B = [x(:),ones(25,1)];
    y = C2_aligned(100,:);
    coeffs = regress(y(:),B);
    t0 = exp(-coeffs(2)/coeffs(1));

    for i = 1:1500
        coeffs = regress(C2_aligned(i,:)',B);
        BL(i) = coeffs(1)*log(t0)+coeffs(2);
    end

    I = C2;
    for i = 1:size(Current,1)
        x0 = 400+i*100;
        I(x0+1:x0+1500,i) = I(x0+1:x0+1500,i)-BL(1:1500);
    end

    Ipost = I;
    Ipre = C1;
    Ipre(1e3+1:end,:) = Ipre(1e3+1:end,:)-BL(1:1201);
    Ipre = mean(Ipre,2);
end