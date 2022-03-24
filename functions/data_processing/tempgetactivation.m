function [V_return,newPost_return,C1_return,v50,erev,lag_return] = tempgetactivation(folder,fig);

	load(fullfile(folder,'activation.mat'));
	if(size(Current,1)<37)
		V_return = nan(37,1);
		newPost_return = nan(37,1);
		C1_return = nan(5001,37);
		erev = nan;
		v50 = nan;
	end		

	[cap,Rseries,difV] = getparams(folder);
	Voltage = Voltage+difV/2;

	Epochs = double(Epochs);

	PN1 = Current(:,Epochs(6)-1e3:Epochs(6)+5e3);
	PN1 = 0*(PN1-median(PN1(:,1:1e3),2));

	PN2 = Current(:,Epochs(3)-1e3:Epochs(3)+5e3);
	PN2 = -2*(PN2-median(PN2(:,1:1e3),2));

	PN = mean(0.5*(PN1+PN2));

	C1 = zeros(5e3+1,size(Current,1));
	Cfit = nan(5e3+1,size(Current,1));
	for j = 1:size(Current,1)
	    response = Current(j,Epochs(4)-1e3:Epochs(4)+5e3);
	    C1(:,j) = PNsubtract(PN,response);

	    [~,i0] =  max(abs(C1(60:end,j)));
		Cfit(:,j) = fitHH(C1(35:end,j),sign(C1(59+i0,j)));

		[~,I] = max(abs(Cfit(:,j)));
		post(j) = Cfit(I,j);

		V(j) = Voltage(j,Epochs(4)+I);
		lag(j) = I*1e-2;
	end

	FT0 = FitBoltzman(V(or(V<45,V>70)),post(or(V<45,V>70)),-15,10,60,50);
	erev = FT0.ERev;
	newPost = FT0.Gmx*post./(V-FT0.ERev);
	FT = FitBoltzmanCurve(V(V<35),newPost(V<35),1,-10,-15);
	v50 = coeffvalues(FT);


	% idcs = zeros(size(C1));
	% for i = 1:size(C1,2)
	%     [~,i0] = max(abs(Cfit(:,i)));
	%     sgn = Cfit(i0,i);
	%     imax = length(C1(:,i));
	%     i1 = i0;
	%     while(and(sgn*C1(i1,i)>0,i1<imax));
	%         i1 = i1+1;
	%     end
	%     if(i0<500)
	%         idcs(i0:i1,i) = 1;
	%     end
	%     IO = [Cfit(1:i0,i);C1(find(idcs(:,i)),i)];
	%     Ipre(i) = sum(IO);
	% end
	% Ipre = Ipre./max(abs(Ipre));
	% FTosi = FitBoltzman(V(V<40),Ipre(V<40),FT0.v50,FT0.k,FT0.ERev,FT0.Gmx);
	% Gpre = FTosi.Gmx*Ipre./(V-FTosi.ERev);
	% FTosi = FitBoltzmanCurve(V(V<35),Gpre(V<35),1,-10,-15);

	% save(fullfile(folder,'OSI.mat'),'Gpre','V');

	% m = min(37,size(C1,2));
	m = 37;
	V_return = V(1:m);
	newPost_return = newPost(1:m);
	C1_return = C1(:,1:m);
	lag_return = lag(1:m);




	if(nargin==2 && ~isempty(fig))
		figure(fig);
		clf
		subplot(1,2,1);
			plot(1e-2*(1:size(C1,1)),C1(:,1:32),'color',[0.6,0.6,0.6]); hold on;
			plot(1e-2*(1:size(C1,1)),Cfit(:,1:32),'k'); hold on;
			scatter(lag(1:32),post(1:32),'filled');
			xlim([0,5]);
			r = range(Cfit(:));
			ylim([min(Cfit(:))-0.2*r,max(Cfit(:))+0.2*r]);
			xlabel('Time (ms)');
			ylabel('Current (pA)');
			drawnow;
			[~,file] = fileparts(folder);
			title(file)
		subplot(1,2,2);
			plot(V,newPost,'.k'); hold on;
			plot(V,FT(V),'LineWidth',1,'color','k');
			title(['V_{1/2} = ' num2str(FT.v50,3) ' mV']);
			xlabel('Voltage (mV)');
			xlim([-100,35])
			ylim([-0.05,1.2])
	end
end
function pnY = PNsubtract(PNx,Y)
    ty = [zeros(1,1000),ones(1,5001)];
    FT = fitlm(ty,PNx);
    PNy = detrend(PNx-ty*FT.Coefficients{2,1});
    PNy = PNy(1e3:3e3);

    ty = [zeros(1,1000),ones(1,length(Y)-1e3)];
    temp = Y-median(Y(1:1e3));
    idcs = setdiff(1:6e3,1e3:2e3);
    FT = fitlm(ty(idcs),temp(idcs));
    temp = temp-ty*FT.Coefficients{2,1};
    
    rawResponse = temp(1e3:3e3);
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
        I = sgn*FT(-33:length(C1));
    else     
        if(C1(I)<0)
            FT = fit(t(:),-C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = -FT(-33:length(C1));
        else
            FT = fit(t(:),C1(:),fun,'StartPoint',StartPoint,'Lower',Lower,'Upper',Upper);
            I = FT(-33:length(C1));
        end
    end
    tau1 = FT.gam1.^(-1)/100;
    tau2 = FT.gam2.^(-1)/100;
    n = FT.n;
end

function [cap,Rseries,difV] = getparams(folder)
	difV = 0;
	[~,cellName] = fileparts(folder);
	if(~isempty(strfind(cellName,'ASM')))
		file = fullfile(folder,[cellName '.txt']);
		if(exist(file))
			% ADAMO FORMAT
			fid = fopen(file);
			txtLn = fgetl(fid);
			while(isempty(strfind(txtLn,'Cap')))
				txtLn = fgetl(fid);
			end
			temp = strsplit(txtLn,': ');
			cap = str2num(temp{2});

			fid = fopen(file);
			txtLn = fgetl(fid);
			while(isempty(strfind(txtLn,'RSeries')))
				txtLn = fgetl(fid);
			end
			temp = strsplit(txtLn,': ');
			Rseries = str2num(temp{2});
			fclose(fid);
		else
			cap = nan;
			Rseries = nan;
		end
	else
		[~,cellName] = fileparts(folder);
		file = fullfile(folder,['Params.txt']);
		if(exist(file))
			%% NIKLAS FORMAT
			fid = fopen(fullfile(folder,'params.txt'));
		    txt=textscan(fid,'%s');
		    if(length(txt{1})==2)
		    	params = cellfun(@(x)str2num(x),split(txt{1}{2},','));
		    	cap = params(1);
		    	Rseries = params(2);
		    	difV = params(3)*Rseries/1e3;
		    else
			    cap = str2num(txt{1}{6});
			    Rseries = str2num(txt{1}{3});
			    if(isempty(Rseries))
				    cap = str2num(txt{1}{4});
				    Rseries = str2num(txt{1}{6});
				    difV = str2num(txt{1}{8})*str2num(txt{1}{2})/1e3;
				end
			end
			fclose(fid);
		else
			cap = nan;
			Rseries = nan;
		end
	end
end