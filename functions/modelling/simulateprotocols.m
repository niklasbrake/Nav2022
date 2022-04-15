function output = simulateprotocols(Q,OpenPositions,v_base);

    if(nargin<3)
        v_base = -100;
    end

    %%% Numerically integrate system with voltage protocols %%%
    % Part 0. Initialize constants
        T_max = 500; % 500 frames with frame time of 0.1 microseconds, thus 5 miliseconds.
        N = length(Q(0));
    % Part 0. Initial baseline at -100 mV 
        dX_base = Q(v_base*1e-3); % Get transition matrix for V = -100 mV
        temp = expsolver(dX_base,[1:100]*1e-3,[1 zeros(1,N-1)])'; % Integrate for 100 ms
        Xinit = temp(end,:)'; % Take final "steady-state" conformation of system
    % Part 1. Initilize constants for inactivaiton protocol
        V_I = [-160:5:-5]; % Get voltage steps used in the inactivation experiments from template
        VSteps = length(V_I); % Total number of voltage steps
        dX_Pulse = Q(-10*1e-3); % Test pulse is -10 mV
    % Part 1. Inactivation Protocol
        X1 = zeros(T_max,N,VSteps); % Allocate memory
        preX1 = zeros(100,N,VSteps); % Allocate memory
        for idx = 1:VSteps % For each voltage step
            V_temp = 1e-3*V_I(idx); % Scale voltage from mV to V
            dX = Q(V_temp); % Get transition matrix for this voltage
            preX1(:,:,idx) = expsolver(dX,[1:100]*1e-3,Xinit)'; % Integrate pre-pulse, lasting 100 ms
            X00 = preX1(end,:,idx)'; % Take "steady-state" conformation of system
            X1(:,:,idx) = expsolver(dX_Pulse,[1:T_max]*1e-5,X00)'; % Integrate test-pulse, for 500 ms.
        end
    % Part 2. Initilize constants for activaiton protocol
        V_A = [-130:5:60]; % Get voltage steps used in the activation experiments from template
        VSteps = length(V_A); % Total number of voltage steps
    % Part 2. Activation Protocol
        X2 = zeros(T_max,N,VSteps); % Allocates memory
        for idx = 1:VSteps % For each voltage step
            V_temp = 1e-3*V_A(idx); % Scale voltage from mV to V
            dX = Q(V_temp); % Get transition matrix
            X2(:,:,idx) = expsolver(dX,[1:T_max]*1e-5,Xinit)'; % Integrate voltage step for 500 ms
        end
    % Part 3. Recovery Initialization
        TSteps = [1:150];
        idx_temp = 21; %Index for V = -10 mV
        X00 = X2(end,:,idx_temp);
    % Part 3. Recovery Protocol
        X3 = zeros(T_max,N,length(TSteps));
        temp1 = expsolver(dX_Pulse,[1:80]*1e-3,X00')';
        for idx = 1:length(TSteps)  
            Xi3(:,:,idx) = expsolver(dX_base,linspace(0,TSteps(idx),100)*1e-3,temp1(end,:))';
            X3(:,:,idx) = expsolver(dX_Pulse,[1:T_max]*1e-5,Xi3(end,:,idx))';
        end

    %%% Handelling of numerical simulations %%%
    % Part 0. Sometimes matrix exp. converts to complex numbers with 0 imaginary part.
        X1 = real(X1); 
        X2 = real(X2);
        X3 = real(X3);
    % Part 1. Max Current calculations
        inActEst = squeeze(sum(X1(1:T_max,OpenPositions,:),2)).*(-10-60); % Take the computed conductance x densitiy in "open states") and scale w.r.t reversal potential
        actEst = squeeze(sum(X2(1:T_max,OpenPositions,:),2)).*(V_A-60); % Repeat for activation protocol
        recovEst = squeeze(sum(X3(1:T_max,OpenPositions,:),2)); % Repeat for recovery protol (don't scale because we're looking at fraction recovery and always pulse to same voltage anyways)
        GMax = max(abs(actEst(:))); % Scale by peak conductance to get in range [0,1]
        actEst = actEst/GMax;
        GMax = max(abs(inActEst(:)));
        inActEst = inActEst/GMax;
        GMax = max(recovEst(:));
        recovEst = recovEst/GMax;
    % Part 2. Find peak magnitude of each current
        A = min(actEst',[],2); % Find max of each current
        B = max(actEst',[],2); % Find min of each current
        [a,b] = max([abs(A) B],[],2); % Take whichever has the larger amplitude
        X = [A B]; % This is the an n x 2 matrix of (x,y) coordinates for peak amplitude
        modelActivationGV = X(sub2ind([length(B) 2],[1:length(B)]',b)); % Get the IV curve
        I_A = modelActivationGV/max(abs(modelActivationGV)); % Scale it by the max
    % Part 2. Repeat for inactivation
        A = min(inActEst',[],2);
        B = max(inActEst',[],2);
        [a,b] = max([abs(A) B],[],2);
        X = [A B];
        modelInactivationGV = X(sub2ind([length(B) 2],[1:length(B)]',b));
        I_I = modelInactivationGV/max(abs(modelInactivationGV));
    % Part 2. Repeat for recovery
        I_R = max(recovEst)/max(max(recovEst));


        output.activation.V = V_A(:);
        output.activation.I = I_A(:);
        output.activation.G = I_A(:)./(V_A(:)-60);
        output.activation.G = output.activation.G./max(output.activation.G);
        output.activation.estimate = actEst;

        output.inactivation.V = V_I(:);
        output.inactivation.I = -I_I(:);
        output.inactivation.estimate = inActEst;

        output.recovery.t = TSteps(:);
        output.recovery.I = I_R(:);
        output.recovery.estimate = recovEst;
        output.recovery.pre = actEst(:,25)/(V_A(25)-60);