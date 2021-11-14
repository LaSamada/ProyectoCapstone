function [sys,x0,str,ts] = reactor_proteina(t,x,u,flag)

switch flag
   case 0
   [sys,x0,str,ts] = mdlInitializeSizes;
   case 1 
   sys = mdlDerivatives(t,x,u);
   case 3
   sys = mdlOutputs(t,x,u);
   case {2,4,9}
   sys=[];
   otherwise
   error(['Unhandled flag = ',num2str(flag)]);
        
end

function [sys,Y0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 7;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 7;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
str = []; 
ts = [0 0];

Xa0 = 1e-4;
Xz0 = 1e-4;
Xg0 = 1e-4;
Xe0 = 1e-4;
x0  = 1;
S0  = 18;
Ac0 = 0;

Y0 = [Xa0 Xz0 Xg0 Xe0 x0 S0 Ac0];

function sys=mdlDerivatives(~,y,u)

C1 = u(1);

Xa = y(1); Xg = y(3);
Xz = y(2); Xe = y(4);
x  = y(5); S  = y(6);
Ac = y(7);

ya  = 0.3386;  %(g/g) 
yz  = 0.950;   %(g/g)
kxa = 14.96;   %(1/h)
kxg = 0.1295;  %(1/h)
kxe = 32.5025; %(1/h)
kxz = 4.5492;  %(1/h)
Ka  = 0.0729;
Kz  = 0.0253;
Ke  = 0.8540;
K1  = 0.2001;
eta = 0.25;
phi = 0.0304;


Ra = kxa*Xa*(S/(S + Ka));
Rz = kxz*Xa*(S/(S + Kz));
Rg = kxg*Xa*Xg*(S/(S + Kz));
Re = kxe*Xa*(S/(S + Kz))*(Xg/(Xg + Ke))*(C1/(C1 + K1));


mu = ya*Ra - (1 - yz)*(Rz + Rg + Re)


dXa = ya*Ra - Rz - Rg - Re - mu*Xa
dXz = yz*Rz - mu*Xz;
dXg = yz*Rg - mu*Xg;
dXe = yz*Rg - mu*Xg;
dx  = (1-phi)*mu*x;
dS  = -Ra*x;
dAc = Ra*eta;



sys = [dXa dXz dXg dXe dx dS dAc]';


function sys=mdlOutputs(~,y,u)

sys = y;
sys(sys < 0) = 0;



