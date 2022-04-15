function erev = getErev(V,post)

    E = [35:5:80];
    D0  = zeros(length(E),1);

    fig = figure;
    for i = 1:length(E)
        G = post./(V-E(i));
        G = G./max(G(V<35));
        cla
        plot(V,G); hold on;
        ylim([0,1.5])
        FT = fitSSIcurve(V,1-G);
        plot(V,1-FT(V))
        D0(i) = sum((1-G(V<35)'-FT(V(V(:)<35))).^2);
        title([int2str(i) ' | ' num2str(D0(i))])
        drawnow;
        pause(1)
    end

    [~,I] = min(D0);
    erev0 = E(I);
    D  = zeros(11,1);

    figure(fig);
    for i = 1:11
        erev = erev0+6-i;
        G = post./(V-erev);
        G = G./max(G(V<35));
        cla
        plot(V,G); hold on;
        ylim([0,1.5])
        FT = fitSSIcurve(V(V<erev-10),1-G(V<erev-10));
        plot(V,1-FT(V))
        D(i) = sum((1-G(V<erev-10)'-FT(V(V(:)<erev-10))).^2);
        title([int2str(i) ' | ' num2str(D(i))])
        drawnow;
        pause(1)
    end
    [~,I] = min(D);
    erev = erev0+6-I;