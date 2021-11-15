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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1; 
sys = simsizes(sizes);
str = []; 
ts = [0 0];

S0 = 3e-3;
P0 = 0;

Y0 = [S0 P0];

function sys=mdlDerivatives(~,y,u)

Etot = u(1);

S = y(1);
P = y(2);

Km = 196e-6;
k2 = 3.3*1e-3*60;

v = k2*Etot*S/(Km + S);

dS = -2*v;
dP = v;

sys = [dS dP]';


function sys=mdlOutputs(~,y,u)

sys = [y(1) y(2)];
sys(sys < 0) = 0;