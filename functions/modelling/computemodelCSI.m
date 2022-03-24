function [CSI,DIV,t_inact,t_open] = computemodelCSI(params,modelfunction,V)

    [Q,OpenPositions,P] = modelfunction(params);
    [t,x] = simulatesingles(Q,OpenPositions,V);

    m = size(x,2);
    for j = 1:m
        temp = find(sum(x(:,j)==[OpenPositions(1)/2,OpenPositions],2));
        if(isempty(temp))
            t_open(j) = 80e-3;
        else
            t_open(j) = t(temp(1),j);
        end
        temp = find(sum(x(:,j)<=OpenPositions(1)/2,2));
        if(isempty(temp))
            t_inact(j) = 80e-3;
        else
            t_inact(j) = t(temp(1),j);
        end   
        temp = find(sum(x(:,j)<=OpenPositions(1),2));
        if(isempty(temp))
            t_DIV(j) = 80e-3;
        else
            t_DIV(j) = t(temp(1),j);
        end
        temp = find(sum(x(:,j)==OpenPositions-1,2));
        if(isempty(temp))
            t_DI(j) = 80e-3;
        else
            t_DI(j) = t(temp(1),j);
        end
    end
    CSI = sum(t_inact<t_open)/m;
    DIV = sum(t_DIV<t_DI)/m;
end
function [t,x,t0] = simulatesingles(Q,OpenPositions,V)

    T_max = 80e-3; % 80 ms
    M = 1e3; % Number of channels

    N = length(Q(0));
    dX_base = Q(-130*1e-3); % Get transition matrix for V = -130 mV
    temp = expsolver(dX_base,[1:100]*1e-3,[1 zeros(1,N-1)])'; % Integrate for 100 ms
    temp(end,:) = zeros(size(temp(end,:)));
    temp(end,OpenPositions(1)+1) = 1;
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