function main(minusC1)

% fig = figureNB; 
% fig.Position(3:4) = 1.75*[3.8,2.7];
% axes('Position',[0,0,1,1]);

% plotCNdiagram;
plotWTdiagram;

end

function plotWTdiagram
	clrs = getColours;
	X1 = text(1,1,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(1,1,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(1,1,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(1,1,'  ^{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(1,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X2 = text(1,2,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(1,2,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(1,2,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(1,2,'  ^{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(1,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X3 = text(2,1,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(2,1,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(2,1,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(2,1,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(2,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X4 = text(2,2,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(2,2,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(2,2,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(2,2,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(2,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));


	X5 = text(2,3,'I_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(2,3,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(2,3,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(2,3,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(2,3,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X6 = text(3,1,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(3,1,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(3,1,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(3,1,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(3,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X7 = text(3,2,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(3,2,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(3,2,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(3,2,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(3,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X8 = text(3,3,'I_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(3,3,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(3,3,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(3,3,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(3,3,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X9 = text(4,1,'O_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(4,1,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(4,1,'  _{  1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(4,1,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(4,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X10 = text(4,2,'O_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(4,2,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(4,2,'  _{  1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(4,2,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(4,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X11 = text(4,3,'I_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(4,3,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(4,3,'  _{  1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(4,3,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(4,3,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));


	set(get(gca,'XAxis'),'Visible','off')
	set(get(gca,'YAxis'),'Visible','off')
	xlim([0.65,4.4]);
	ylim([0.5 3.2]);
	set(gca,'DataAspectRatio',[1,1,1]);

	hold on;

	horizontalLines(X1,X3,'\alpha_3','\beta_3');
	horizontalLines(X3,X6,'\alpha_2','\beta_2');
	horizontalLines(X6,X9,'\gamma','\delta');

	horizontalLines(X2,X4,'\alpha_3x_\alpha','\beta_3x_\beta');
	horizontalLines(X4,X7,'\alpha_2x_\alpha','\beta_2x_\beta');
	horizontalLines(X7,X10,'\gamma_4','\delta_4');

	horizontalLines(X5,X8,'\alpha_2x_\alphay_\alpha','\beta_2x_\betay_\beta');
	horizontalLines(X8,X11,'\gamma_i','\delta_i');


	verticalLines(X2,X1,'\beta_4','\alpha_4');
	verticalLines(X4,X3,'\beta_4y_\alpha','\alpha_4x_\alpha');
	verticalLines(X7,X6,'\beta_4y_\alpha^2','\alpha_4x_\alpha^2');
	verticalLines(X10,X9,'\beta_{4O}','\alpha_{4O}');


	verticalLines(X5,X4,'r','i');
	verticalLines(X8,X7,'ry_\beta','iy_\alpha');
	verticalLines(X11,X10,'r_O','i_O');
end
function plotCNdiagram
	clrs = getColours;
	X1 = text(1,1,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(1,1,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(1,1,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(1,1,'  ^{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(1,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X2 = text(1,2,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(1,2,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(1,2,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(1,2,'  ^{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(1,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X3 = text(2,1,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(2,1,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(2,1,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(2,1,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(2,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X4 = text(2,2,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(2,2,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(2,2,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(2,2,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(2,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));


	X5 = text(2,3,'I_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(2,3,'  _{0  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(2,3,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(2,3,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(2,3,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X6 = text(3,1,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(3,1,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(3,1,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(3,1,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(3,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X7 = text(3,2,'C_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(3,2,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(3,2,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(3,2,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(3,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X8 = text(3,3,'I_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(3,3,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(3,3,'  _{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(3,3,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(3,3,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X9 = text(4,1,'O_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(4,1,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(4,1,'  _{  1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(4,1,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(4,1,'  ^{  0}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X10 = text(4,2,'O_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(4,2,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(4,2,'  _{  1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(4,2,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(4,2,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));

	X11 = text(4,3,'I_{ }   ','FontSize',10,'HorizontalAlignment','center','VerticalAlignment','top','FontName','Times','FontWeight','bold');
		text(4,3,'  _{2  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(3,:));
		text(4,3,'  _{  1}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(2,:));
		text(4,3,'  ^{3  }','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(4,:));
		text(4,3,'  ^{  4}','FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top','color',clrs(5,:));


	set(get(gca,'XAxis'),'Visible','off')
	set(get(gca,'YAxis'),'Visible','off')
	xlim([0.7,4.25]);
	ylim([0.5 3.2]);

	hold on;

	horizontalLine(X6,X3,clrs(3,:));
	horizontalLine(X7,X4,clrs(3,:));
	horizontalLine(X8,X5,clrs(3,:));
	
	horizontalLine(X9,X6,clrs(2,:));
	horizontalLine(X10,X7,clrs(2,:));
	horizontalLine(X11,X8,clrs(2,:));

	horizontalLine(X3,X1,clrs(4,:));
	horizontalLine(X4,X2,clrs(4,:));

	verticalLine(X2,X1,clrs(5,:));
	verticalLine(X4,X3,clrs(5,:));
	verticalLine(X7,X6,clrs(5,:));
	verticalLine(X10,X9,clrs(5,:));


	verticalLines(X5,X4,'r','i');
	verticalLines(X8,X7,'ry_\beta','iy_\alpha');
	verticalLines(X11,X10,'r_O','i_O');
end

function horizontalLines(X1,X2,string1,string2)

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
	% ws=0.1;
	offset = 0.04;

	annotation('arrow',figCox([x1+offset,x2-offset]),figCoy([y1+0.025 y1+0.025]),'HeadWidth',3,'HeadLength',3,'HeadStyle','vback2');
	annotation('arrow',figCox([x2-offset,x1+offset]),figCoy([y1-0.025 y1-0.025]),'HeadWidth',3,'HeadLength',3,'HeadStyle','vback2');


	% quiver(x1+ws+offset,y1+0.025,x2-x1-1.5*ws,0,'LineWidth',0.75,'Color','k','MaxHeadSize',0.5);
	% quiver(x2-ws-offset,y1-0.025,x1-x2+1.5*ws,0,'LineWidth',0.75,'Color','k','MaxHeadSize',0.5);
	text((x2+x1)/2,y1+0.035,string1,'FontSize',7,'HorizontalAlignment','center','VerticalAlignment','bottom');
	text((x2+x1)/2,y1-0.025,string2,'FontSize',7,'HorizontalAlignment','center','VerticalAlignment','top');
end

function verticalLines(X1,X2,string1,string2)

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

	% quiver(x1+0.025,y1-ws-offset,0,y2-y1+1.5*ws,'LineWidth',0.75,'Color','k','MaxHeadSize',0.5);
	% quiver(x1-0.025,y2+ws+offset,0,y1-y2-1.5*ws,'LineWidth',0.75,'Color','k','MaxHeadSize',0.5);
	text(x1+0.075,(y2+y1)/2,string1,'FontSize',7,'HorizontalAlignment','left','VerticalAlignment','middle');
	text(x1-0.075,(y2+y1)/2,string2,'FontSize',7,'HorizontalAlignment','right','VerticalAlignment','middle');
end

function verticalLine(X1,X2,clr)
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


	% A = annotation('arrow',figCox([x1+0.025,x2+0.025]),figCoy([y1-offset y2+offset]),'HeadWidth',6,'HeadLength',6,'HeadStyle','vback2');
	A = annotation('arrow',figCox([x1,x1]),figCoy([y2 y1]+2*offset),'HeadWidth',10,'HeadLength',10,'HeadStyle','vback2');
	A.Color = clr;
	A.LineWidth = 3;
end
function horizontalLine(X1,X2,clr)
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
	offset = 0.04;


	% A = annotation('arrow',figCox([x1+0.025,x2+0.025]),figCoy([y1-offset y2+offset]),'HeadWidth',6,'HeadLength',6,'HeadStyle','vback2');
	A = annotation('arrow',figCox([x2+4*offset,x1-5*offset]),figCoy([y1+y2 y1+y2]/2+offset),'HeadWidth',10,'HeadLength',10,'HeadStyle','vback2');
	A.Color = clr;
	A.LineWidth = 3;
end