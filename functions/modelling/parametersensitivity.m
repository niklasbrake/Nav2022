function output = parametersensitivity
    basePath = fileparts(fileparts(fileparts(mfilename('fullpath'))));
    addpath(genpath(basePath));

    defaultParams = getNav15params;
    [Q,OpenPositions,defaultP] = nav15_NB(defaultParams);

    A = linspace(-2,1,10);%52);
    B = linspace(-2,2,9);%51);
    for j = 1:length(B)
        for i = 1:length(A)
            P = defaultP;
            P.alpha_k = P.alpha_k*10^(A(i));
            P.gamma_k = P.gamma_k*10^(B(j));
            [Q,OpenPositions] = nav15_NB(struct2array(P));
            simulation = simulateprotocols(Q,OpenPositions);
            FT = fitboltzman(simulation.activation.V,simulation.activation.G);
            v50(i,j) = FT.v50;
            I = simulation.activation.estimate(:,simulation.activation.V==0);
            [~,t2p(i,j)] = max(abs(I));

            [~,~,temp] = simulatesingles(Q,OpenPositions);
            t0(i,j) = nanmedian(temp);
        end
    end
    output.parameter1.name = 'alpha_k';
    output.parameter1.valueDefault = P.alpha_k;
    output.parameter1.foldChange = A;
    output.parameter2.name = 'gamma_k';
    output.parameter2.valueDefault = P.gamma_k;
    output.parameter2.foldChange = B;
    output.v50 = v50;
    output.t0 = t0*1e3;
    output.t2p = t2p*1e-2;
end
function [t,x,t0] = simulatesingles(Q,OpenPositions)

    T_max = 80e-3; % 80 ms
    M = 1e3; % Number of channels

    V = -35;

    N = length(Q(0));
    dX_base = Q(-130*1e-3); % Get transition matrix for V = -130 mV
    temp = expsolver(dX_base,[1:100]*1e-3,[1 zeros(1,N-1)])'; % Integrate for 100 ms
    Xinit = max(1e-9,temp(end,:)'); % Take final "steady-state" conformation of system
    x0 = interp1(cumsum(Xinit)/sum(Xinit),1:length(Xinit),rand(1,M),'next','extrap');

    dX = Q(V*1e-3);

    dX = dX.*(1-eye(size(dX)));
    x = x0;
    t = zeros(1,M);
    i = 1;
    while(min(t(end,:))<T_max)
        PX = dX(:,x(i,:));
        S = sum(PX);
        t(i+1,:) = t(i,:)-log(rand(1,M))./S;
        x(i+1,:) = sum((cumsum(PX)./S < rand(1,M)))+1;
        i = i+1;
    end
    for j = 1:M
        idcs = find(sum(x(:,j)==OpenPositions(:)',2));
        if(isempty(idcs))
            t0(j) = nan;
        else
            t0(j) = t(min(idcs),j);
            if(t0(j)>80e-3)
                t0(j) = nan;
            end
        end
    end
end