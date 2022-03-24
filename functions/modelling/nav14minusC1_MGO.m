function [Q,OpenPositions,P] = nav14minusC1_MGO(Params) 
% nav14minusC1_MGO Defined with the DrawModel GUI and programmatically generated 
% through constructModelCode. 
% 	 [Q,OpenPositions,P] = nav14minusC1_MGO(Params) Generate transition matrix Q parameterized by
%	 input Params (length=32). 
% 	 Parameter order: alpha_4k, alpha_4ok, alpha_4oq, alpha_4q
% 	 	 alpha_k, alpha_q, beta_4k, beta_4ok
% 	 	 beta_4oq, beta_4q, beta_k, beta_q, delta_4k
% 	 	 delta_4q, delta_ik, delta_iq, delta_k
% 	 	 delta_q, gamma_k, gamma_q, ii_k, ii_ok
% 	 	 ii_oq, ii_q, r_k, r_ok, r_oq, r_q, x_alpha
% 	 	 x_beta, y_alpha, y_beta.
% 
% See also constructModelCode, DrawModel. 
alpha_4k = Params(1);
alpha_4ok = Params(2);
alpha_4oq = Params(3);
alpha_4q = Params(4);
alpha_k = Params(5);
alpha_q = Params(6);
beta_4k = Params(7);
beta_4ok = Params(8);
beta_4oq = Params(9);
beta_4q = Params(10);
beta_k = Params(11);
beta_q = Params(12);
delta_4k = Params(13);
delta_4q = Params(14);
delta_ik = Params(15);
delta_iq = Params(16);
delta_k = Params(17);
delta_q = Params(18);
gamma_k = Params(19);
gamma_q = Params(20);
ii_k = Params(21);
ii_ok = Params(22);
ii_oq = Params(23);
ii_q = Params(24);
r_k = Params(25);
r_ok = Params(26);
r_oq = Params(27);
r_q = Params(28);
x_alpha = Params(29);
x_beta = Params(30);
y_alpha = Params(31);
y_beta = Params(32);
preQ = repmat({@(V) 0},[12 12]);
preQ{1,1} = @(V) -alpha_k*x_alpha*y_alpha*exp(-37.435377*V*alpha_q)-r_k*y_beta*exp(-37.435377*V*r_q);
preQ{2,1} = @(V) alpha_k*x_alpha*y_alpha*exp(-37.435377*V*alpha_q);
preQ{5,1} = @(V) r_k*y_beta*exp(-37.435377*V*r_q);
preQ{1,2} = @(V) beta_k*x_beta*y_beta*exp(-37.435377*V*beta_q);
preQ{2,2} = @(V) -beta_k*x_beta*y_beta*exp(-37.435377*V*beta_q)-alpha_k*x_alpha*y_alpha*exp(-37.435377*V*alpha_q)-r_k*y_beta^2*exp(-37.435377*V*r_q);
preQ{3,2} = @(V) alpha_k*x_alpha*y_alpha*exp(-37.435377*V*alpha_q);
preQ{6,2} = @(V) r_k*y_beta^2*exp(-37.435377*V*r_q);
preQ{2,3} = @(V) beta_k*x_beta*y_beta*exp(-37.435377*V*beta_q);
preQ{3,3} = @(V) -beta_k*x_beta*y_beta*exp(-37.435377*V*beta_q)-(r_k*y_beta^3*exp(-37.435377*V*r_q)*(beta_4k*x_beta^3*exp(-37.435377*V*beta_4q)*gamma_k*exp(-37.435377*V*gamma_q)*alpha_4ok*exp(-37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_4q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^3*exp(-37.435377*V*alpha_4q)))*ii_ok*exp(-37.435377*V*ii_oq)*delta_ik*exp(-37.435377*V*delta_iq)/ (r_ok*exp(-37.435377*V*r_oq)*delta_4k*exp(-37.435377*V*delta_4q)*ii_k*y_alpha^3*exp(-37.435377*V*ii_q)))-r_k*y_beta^3*exp(-37.435377*V*r_q);
preQ{4,3} = @(V) (r_k*y_beta^3*exp(-37.435377*V*r_q)*(beta_4k*x_beta^3*exp(-37.435377*V*beta_4q)*gamma_k*exp(-37.435377*V*gamma_q)*alpha_4ok*exp(-37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_4q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^3*exp(-37.435377*V*alpha_4q)))*ii_ok*exp(-37.435377*V*ii_oq)*delta_ik*exp(-37.435377*V*delta_iq)/ (r_ok*exp(-37.435377*V*r_oq)*delta_4k*exp(-37.435377*V*delta_4q)*ii_k*y_alpha^3*exp(-37.435377*V*ii_q)));
preQ{7,3} = @(V) r_k*y_beta^3*exp(-37.435377*V*r_q);
preQ{3,4} = @(V) delta_ik*exp(-37.435377*V*delta_iq);
preQ{4,4} = @(V) -delta_ik*exp(-37.435377*V*delta_iq)-r_ok*exp(-37.435377*V*r_oq);
preQ{8,4} = @(V) r_ok*exp(-37.435377*V*r_oq);
preQ{1,5} = @(V) ii_k*y_alpha*exp(-37.435377*V*ii_q);
preQ{5,5} = @(V) -ii_k*y_alpha*exp(-37.435377*V*ii_q)-alpha_k*x_alpha*exp(-37.435377*V*alpha_q)-beta_4k*x_beta*exp(-37.435377*V*beta_4q);
preQ{6,5} = @(V) alpha_k*x_alpha*exp(-37.435377*V*alpha_q);
preQ{9,5} = @(V) beta_4k*x_beta*exp(-37.435377*V*beta_4q);
preQ{2,6} = @(V) ii_k*y_alpha^2*exp(-37.435377*V*ii_q);
preQ{5,6} = @(V) beta_k*x_beta*exp(-37.435377*V*beta_q);
preQ{6,6} = @(V) -ii_k*y_alpha^2*exp(-37.435377*V*ii_q)-beta_k*x_beta*exp(-37.435377*V*beta_q)-alpha_k*x_alpha*exp(-37.435377*V*alpha_q)-beta_4k*x_beta^2*exp(-37.435377*V*beta_4q);
preQ{7,6} = @(V) alpha_k*x_alpha*exp(-37.435377*V*alpha_q);
preQ{10,6} = @(V) beta_4k*x_beta^2*exp(-37.435377*V*beta_4q);
preQ{3,7} = @(V) ii_k*y_alpha^3*exp(-37.435377*V*ii_q);
preQ{6,7} = @(V) beta_k*x_beta*exp(-37.435377*V*beta_q);
preQ{7,7} = @(V) -ii_k*y_alpha^3*exp(-37.435377*V*ii_q)-beta_k*x_beta*exp(-37.435377*V*beta_q)-(beta_4k*x_beta^3*exp(-37.435377*V*beta_4q)*gamma_k*exp(-37.435377*V*gamma_q)*alpha_4ok*exp(-37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_4q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^3*exp(-37.435377*V*alpha_4q)))-beta_4k*x_beta^3*exp(-37.435377*V*beta_4q);
preQ{8,7} = @(V) (beta_4k*x_beta^3*exp(-37.435377*V*beta_4q)*gamma_k*exp(-37.435377*V*gamma_q)*alpha_4ok*exp(-37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_4q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^3*exp(-37.435377*V*alpha_4q)));
preQ{11,7} = @(V) beta_4k*x_beta^3*exp(-37.435377*V*beta_4q);
preQ{4,8} = @(V) ii_ok*exp(-37.435377*V*ii_oq);
preQ{7,8} = @(V) delta_4k*exp(-37.435377*V*delta_4q);
preQ{8,8} = @(V) -ii_ok*exp(-37.435377*V*ii_oq)-delta_4k*exp(-37.435377*V*delta_4q)-beta_4ok*exp(-37.435377*V*beta_4oq);
preQ{12,8} = @(V) beta_4ok*exp(-37.435377*V*beta_4oq);
preQ{5,9} = @(V) alpha_4k*x_alpha*exp(-37.435377*V*alpha_4q);
preQ{9,9} = @(V) -alpha_4k*x_alpha*exp(-37.435377*V*alpha_4q)-alpha_k*exp(-37.435377*V*alpha_q);
preQ{10,9} = @(V) alpha_k*exp(-37.435377*V*alpha_q);
preQ{6,10} = @(V) alpha_4k*x_alpha^2*exp(-37.435377*V*alpha_4q);
preQ{9,10} = @(V) beta_k*exp(-37.435377*V*beta_q);
preQ{10,10} = @(V) -alpha_4k*x_alpha^2*exp(-37.435377*V*alpha_4q)-beta_k*exp(-37.435377*V*beta_q)-alpha_k*exp(-37.435377*V*alpha_q);
preQ{11,10} = @(V) alpha_k*exp(-37.435377*V*alpha_q);
preQ{7,11} = @(V) alpha_4k*x_alpha^3*exp(-37.435377*V*alpha_4q);
preQ{10,11} = @(V) beta_k*exp(-37.435377*V*beta_q);
preQ{11,11} = @(V) -alpha_4k*x_alpha^3*exp(-37.435377*V*alpha_4q)-beta_k*exp(-37.435377*V*beta_q)-gamma_k*exp(-37.435377*V*gamma_q);
preQ{12,11} = @(V) gamma_k*exp(-37.435377*V*gamma_q);
preQ{8,12} = @(V) alpha_4ok*exp(-37.435377*V*alpha_4oq);
preQ{11,12} = @(V) delta_k*exp(-37.435377*V*delta_q);
preQ{12,12} = @(V) -alpha_4ok*exp(-37.435377*V*alpha_4oq)-delta_k*exp(-37.435377*V*delta_q);
Q = @(v) cellfun(@(f)f(-v),preQ);
OpenPositions = [8,12]; 
P.alpha_4k = Params(1);
P.alpha_4ok = Params(2);
P.alpha_4oq = Params(3);
P.alpha_4q = Params(4);
P.alpha_k = Params(5);
P.alpha_q = Params(6);
P.beta_4k = Params(7);
P.beta_4ok = Params(8);
P.beta_4oq = Params(9);
P.beta_4q = Params(10);
P.beta_k = Params(11);
P.beta_q = Params(12);
P.delta_4k = Params(13);
P.delta_4q = Params(14);
P.delta_ik = Params(15);
P.delta_iq = Params(16);
P.delta_k = Params(17);
P.delta_q = Params(18);
P.gamma_k = Params(19);
P.gamma_q = Params(20);
P.ii_k = Params(21);
P.ii_ok = Params(22);
P.ii_oq = Params(23);
P.ii_q = Params(24);
P.r_k = Params(25);
P.r_ok = Params(26);
P.r_oq = Params(27);
P.r_q = Params(28);
P.x_alpha = Params(29);
P.x_beta = Params(30);
P.y_alpha = Params(31);
P.y_beta = Params(32);