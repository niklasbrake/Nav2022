function [Q,OpenPositions,P] = nav15_NB_wDIII(Params) 
% nav15_NB_wDIII Defined with the DrawModel GUI and programmatically generated 
% through constructModelCode. 
% 	 [Q,OpenPositions,P] = nav15_NB_wDIII(Params) Generate transition matrix Q parameterized by
%	 input Params (length=30). 
% 	 Parameter order: alpha_3k, alpha_3q, alpha_4k, alpha_4ok, alpha_4oq
% 	 	 alpha_4q, alpha_k, alpha_q, beta_3k
% 	 	 beta_3q, beta_4k, beta_4ok, beta_4oq
% 	 	 beta_4q, beta_k, beta_q, delta_4k, delta_ik
% 	 	 delta_k, delta_q, gamma_ik, gamma_k
% 	 	 gamma_q, ii_k, ii_ok, r_k, x_alpha, x_beta
% 	 	 y_alpha, y_beta.
% 
% See also constructModelCode, DrawModel. 
alpha_3k = Params(1);
alpha_3q = Params(2);
alpha_4k = Params(3);
alpha_4ok = Params(4);
alpha_4oq = Params(5);
alpha_4q = Params(6);
alpha_k = Params(7);
alpha_q = Params(8);
beta_3k = Params(9);
beta_3q = Params(10);
beta_4k = Params(11);
beta_4ok = Params(12);
beta_4oq = Params(13);
beta_4q = Params(14);
beta_k = Params(15);
beta_q = Params(16);
delta_4k = Params(17);
delta_ik = Params(18);
delta_k = Params(19);
delta_q = Params(20);
gamma_ik = Params(21);
gamma_k = Params(22);
gamma_q = Params(23);
ii_k = Params(24);
ii_ok = Params(25);
r_k = Params(26);
x_alpha = Params(27);
x_beta = Params(28);
y_alpha = Params(29);
y_beta = Params(30);
preQ = repmat({@(V) 0},[11 11]);
preQ{1,1} = @(V) -alpha_k*x_alpha*y_alpha*exp(37.435377*V*alpha_q)-r_k;
preQ{2,1} = @(V) alpha_k*x_alpha*y_alpha*exp(37.435377*V*alpha_q);
preQ{5,1} = @(V) r_k;
preQ{1,2} = @(V) beta_k*x_beta*y_beta*exp(-37.435377*V*beta_q);
preQ{2,2} = @(V) -beta_k*x_beta*y_beta*exp(-37.435377*V*beta_q)-gamma_ik*exp(37.435377*V*gamma_q)-r_k*y_beta;
preQ{3,2} = @(V) gamma_ik*exp(37.435377*V*gamma_q);
preQ{6,2} = @(V) r_k*y_beta;
preQ{2,3} = @(V) delta_ik*exp(-37.435377*V*delta_q);
preQ{3,3} = @(V) -delta_ik*exp(-37.435377*V*delta_q)-(r_k*y_beta*(beta_4k*x_beta^2*exp(-37.435377*V*beta_4q)*gamma_k*exp(37.435377*V*gamma_q)*alpha_4ok*exp(37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^2*exp(37.435377*V*alpha_4q)))*ii_ok*delta_ik*exp(-37.435377*V*delta_q)/ (gamma_ik*exp(37.435377*V*gamma_q)*delta_4k*exp(-37.435377*V*delta_q)*ii_k*y_alpha));
preQ{7,3} = @(V) (r_k*y_beta*(beta_4k*x_beta^2*exp(-37.435377*V*beta_4q)*gamma_k*exp(37.435377*V*gamma_q)*alpha_4ok*exp(37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^2*exp(37.435377*V*alpha_4q)))*ii_ok*delta_ik*exp(-37.435377*V*delta_q)/ (gamma_ik*exp(37.435377*V*gamma_q)*delta_4k*exp(-37.435377*V*delta_q)*ii_k*y_alpha));
preQ{4,4} = @(V) -alpha_3k*x_alpha*exp(37.435377*V*alpha_3q)-beta_4k*exp(-37.435377*V*beta_4q);
preQ{5,4} = @(V) alpha_3k*x_alpha*exp(37.435377*V*alpha_3q);
preQ{8,4} = @(V) beta_4k*exp(-37.435377*V*beta_4q);
preQ{1,5} = @(V) ii_k;
preQ{4,5} = @(V) beta_3k*x_beta*exp(-37.435377*V*beta_3q);
preQ{5,5} = @(V) -ii_k-beta_3k*x_beta*exp(-37.435377*V*beta_3q)-alpha_k*x_alpha*exp(37.435377*V*alpha_q)-beta_4k*x_beta*exp(-37.435377*V*beta_4q);
preQ{6,5} = @(V) alpha_k*x_alpha*exp(37.435377*V*alpha_q);
preQ{9,5} = @(V) beta_4k*x_beta*exp(-37.435377*V*beta_4q);
preQ{2,6} = @(V) ii_k*y_alpha;
preQ{5,6} = @(V) beta_k*x_beta*exp(-37.435377*V*beta_q);
preQ{6,6} = @(V) -ii_k*y_alpha-beta_k*x_beta*exp(-37.435377*V*beta_q)-(beta_4k*x_beta^2*exp(-37.435377*V*beta_4q)*gamma_k*exp(37.435377*V*gamma_q)*alpha_4ok*exp(37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^2*exp(37.435377*V*alpha_4q)))-beta_4k*x_beta^2*exp(-37.435377*V*beta_4q);
preQ{7,6} = @(V) (beta_4k*x_beta^2*exp(-37.435377*V*beta_4q)*gamma_k*exp(37.435377*V*gamma_q)*alpha_4ok*exp(37.435377*V*alpha_4oq)*delta_4k*exp(-37.435377*V*delta_q)/ (beta_4ok*exp(-37.435377*V*beta_4oq)*delta_k*exp(-37.435377*V*delta_q)*alpha_4k*x_alpha^2*exp(37.435377*V*alpha_4q)));
preQ{10,6} = @(V) beta_4k*x_beta^2*exp(-37.435377*V*beta_4q);
preQ{3,7} = @(V) ii_ok;
preQ{6,7} = @(V) delta_4k*exp(-37.435377*V*delta_q);
preQ{7,7} = @(V) -ii_ok-delta_4k*exp(-37.435377*V*delta_q)-beta_4ok*exp(-37.435377*V*beta_4oq);
preQ{11,7} = @(V) beta_4ok*exp(-37.435377*V*beta_4oq);
preQ{4,8} = @(V) alpha_4k*exp(37.435377*V*alpha_4q);
preQ{8,8} = @(V) -alpha_4k*exp(37.435377*V*alpha_4q)-alpha_3k*exp(37.435377*V*alpha_3q);
preQ{9,8} = @(V) alpha_3k*exp(37.435377*V*alpha_3q);
preQ{5,9} = @(V) alpha_4k*x_alpha*exp(37.435377*V*alpha_4q);
preQ{8,9} = @(V) beta_3k*exp(-37.435377*V*beta_3q);
preQ{9,9} = @(V) -alpha_4k*x_alpha*exp(37.435377*V*alpha_4q)-beta_3k*exp(-37.435377*V*beta_3q)-alpha_k*exp(37.435377*V*alpha_q);
preQ{10,9} = @(V) alpha_k*exp(37.435377*V*alpha_q);
preQ{6,10} = @(V) alpha_4k*x_alpha^2*exp(37.435377*V*alpha_4q);
preQ{9,10} = @(V) beta_k*exp(-37.435377*V*beta_q);
preQ{10,10} = @(V) -alpha_4k*x_alpha^2*exp(37.435377*V*alpha_4q)-beta_k*exp(-37.435377*V*beta_q)-gamma_k*exp(37.435377*V*gamma_q);
preQ{11,10} = @(V) gamma_k*exp(37.435377*V*gamma_q);
preQ{7,11} = @(V) alpha_4ok*exp(37.435377*V*alpha_4oq);
preQ{10,11} = @(V) delta_k*exp(-37.435377*V*delta_q);
preQ{11,11} = @(V) -alpha_4ok*exp(37.435377*V*alpha_4oq)-delta_k*exp(-37.435377*V*delta_q);
Q = @(v) cellfun(@(f)f(v),preQ);
OpenPositions = [7,11]; 
P.alpha_3k = Params(1);
P.alpha_3q = Params(2);
P.alpha_4k = Params(3);
P.alpha_4ok = Params(4);
P.alpha_4oq = Params(5);
P.alpha_4q = Params(6);
P.alpha_k = Params(7);
P.alpha_q = Params(8);
P.beta_3k = Params(9);
P.beta_3q = Params(10);
P.beta_4k = Params(11);
P.beta_4ok = Params(12);
P.beta_4oq = Params(13);
P.beta_4q = Params(14);
P.beta_k = Params(15);
P.beta_q = Params(16);
P.delta_4k = Params(17);
P.delta_ik = Params(18);
P.delta_k = Params(19);
P.delta_q = Params(20);
P.gamma_ik = Params(21);
P.gamma_k = Params(22);
P.gamma_q = Params(23);
P.ii_k = Params(24);
P.ii_ok = Params(25);
P.r_k = Params(26);
P.x_alpha = Params(27);
P.x_beta = Params(28);
P.y_alpha = Params(29);
P.y_beta = Params(30);
