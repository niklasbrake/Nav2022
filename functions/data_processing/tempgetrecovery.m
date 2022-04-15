% function [gam,a,b] = tempgetrecovery(folder,fig);
% 	load(fullfile(folder,'recovery1ms.mat'));
	if(Voltage(1)==0)
		Voltage = Voltage-60;
	end

	Epochs = double(Epochs);

	for i = 1:size(Current,1)
		PN(:,i) = Current(i,Epochs(8)+100*(i-1)-1e3:Epochs(8)+100*(i-1)+5e3);
	end
	PN = PN-median(PN(1:1e3,:));
	PN = mean(PN,2)';

	ty = [zeros(1,1000),ones(1,5001)];
    FT = fitlm(ty,PN);
    PNy = PN-ty*FT.Coefficients{2,1};
    PNy = PNy(1e3:3e3);


    for i = 1:size(Current,1)
		PN2(:,i) = Current(i,Epochs(5)-1e3:Epochs(6)+100*24);
		PN2(1e3+100*i+1:end,i) = nan;
	end
	PN2 = nanmean(PN2,2)';


	C1 = zeros(5e3+1,size(Current,1));
	C2 = zeros(5e3+1,size(Current,1));
	Cfit1 = nan(5e3+1,size(Current,1));
	Cfit2 = nan(5e3+1,size(Current,1));
	for j = 1:size(Current,1)

	    Y = Current(j,Epochs(4)-1e3:Epochs(4)+5e3);
	    temp = Y-median(Y(1:1e3));
	    % idcs = setdiff(1:6e3,1e3:2e3);
	    % FT = fitlm(ty(idcs),temp(idcs));
	    % response = temp-ty*FT.Coefficients{2,1};
	    response = temp(1e3+1:end);

	    % FT = fitlm(PNy(1:50),response(1:50));
	    % A = FT.Coefficients{2,1};
	    % pnY0 = response(1:2001)-A*PNy;
	    % response(1:2001) = pnY0;

	    C1(:,j) = response;

	    inter = PN2(1:1e3+100*j+1);
	    temp = Current(j,Epochs(5)-1e3:Epochs(6)+100*(j-1)+5e3);
	    temp = temp-nanmedian(temp(1:1e3));
	    inter = inter-nanmedian(inter(1:1e3));
	    temp(1:1e3+100*j+1) = temp(1:1e3+100*j+1)-inter;
	    response = temp(100*(j-1)+1001+Epochs(6)-Epochs(5):end);

	   	% FT = fitlm(PNy(1:50),response(1:50));
	    % A = FT.Coefficients{2,1};
	    % pnY0 = response(1:2001)-A*PNy;
	    % response(1:2001) = pnY0;

	    C2(:,j) = response;

	    Cfit1(35:end,j) = fitHH(C1(35:end,j),-1);
	    Cfit2(35:end,j) = fitHH(C2(35:end,j),-1);

		[~,I] = min(Cfit1(:,j));
		pre(j) = Cfit1(I,j);

		[~,I] = min(Cfit2(:,j));
		post(j) = Cfit2(I,j);

		lag(j) = 100*(j-1)+1;
	end

	a = 1:size(Current,1);
	b = post./pre;

	fun = fittype('a+exp(b*(x0-x))');
	figure;
	plot(C2,'k'); hold on;
	h=plot(1:size(C2,1),nan*(1:size(C2,1)),'r');

	i = 100;
	y = -C2(i,:)'; M=max(y);
	idcs = find(isfinite(y(1:10)));
	FT = fit(a(idcs)',1-y(idcs)/max(y),fun);
	t0 = FT.x0-log(1-FT.a)/FT.b;

	BL = zeros(size(C2,1),1);
	B = [log(a(:)),ones(length(a),1)];
	for i = 1:1500
		y = -C2(i,:)'; M=max(y);
		idcs = find(isfinite(y(1:10)));
		FT = fit(a(idcs)',1-y(idcs)/max(y),fun);
		h.YData(i) = M*(FT(t0)-1);
		drawnow;
	end



	FT = FitBiExponential(a,b);
	gam = (FT.gamma1*FT.A+FT.gamma2*(1-FT.A));

	if(nargin==2 && ~isempty(fig));
		figure(fig);
		clf
		subplot(1,2,1);
		C2_plot = C2./min(Cfit1);
		for j = 1:size(C2,2)
			plot((1:1e3)+lag(j),C2_plot(1:1e3,j)); hold on;
			scatter(lag(j)+I,b(j),'filled');
		end
		xlim([0,3000])
		ylim([0,1]);
		xticks([0:500:3000]);
		xticklabels([0:5:30]);
		xlabel('Time (ms)');
		ylabel('I_{post}/I_{pre}')
		[~,file] = fileparts(folder);
		title(file)

		subplot(1,2,2);
			plot(a,b,'.k','MarkerSize',20); hold on;
			plot(FT);
			title(['gam_w = ' num2str(gam,3) '/ms']);
			ylabel('post/pre');
			xlabel('Inter-pulse interval (ms)');
	end
% end
function pnY = PNsubtract(PNx,Y)    
    FT = fitlm(PNy(1:50),rawResponse(1:50));
    A = FT.Coefficients{2,1};
    pnY0 = rawResponse-A*PNy;
    pnY = temp(1001:end); pnY(1:2001) = pnY0;
end
function [I,tau1,tau2,n] = fitHH(C1,sgn)

    t = 1:length(C1);
    fun = fittype(@(gam1,gam2,A,x0,n,m,d,x) 0*d+(x>x0).*(A*(1 - exp(-(x-x0)*gam1)).^n.*exp(-(x-x0)*gam2).^m));

    [m,I] = max(abs(C1));
    StartPoint = [0.3,0.2,C1(I),20,2,1,0];
    Lower = [1/500,1/500,0,0,0.2,0.2,-m];
    Upper = [1,1,m*10,100,4,4,m];

    if(nargin==2)
        FT = fit(t(:),sgn*C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
        I = sgn*FT(t);
    else     
        if(C1(I)<0)
            FT = fit(t(:),-C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = -FT(t);
        else
            FT = fit(t(:),C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = FT(t);
        end
    end
    tau1 = FT.gam1.^(-1)/100;
    tau2 = FT.gam2.^(-1)/100;
    n = FT.n;
end