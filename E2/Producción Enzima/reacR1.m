function [sys,x0,str,ts] = reacR1(t,x,u,flag)

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
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1; 
sys = simsizes(sizes);
str = []; 
ts  = [0 0];

Y0    = zeros(1,7);
Y0(1) = 0.1; % AHM 
Y0(2) = 0.08;
Y0(5) = 6.2e-4;
Y0(7) = 1.51/60.05;

function sys=mdlDerivatives(t,y,u)

% AHM + EtAc -> AAM + Etan | k1
% AAM + Cris -> Fero       | k2
% Ac  + Etan -> EtAc       | k3

AHM  = y(1);
EtAc = y(2);
AAM  = y(3);
Etan = y(4);
Cris = y(5);
Fero = y(6);
Ac   = y(7);

% if t == 0
%    AHM  = 0.1; % AHM 
%    EtAc = 0.08;
%    Cris = 3.913e-5;
%    Ac   = 1.51/60.05;
% end

k1 = 0.5;
k2 = 0.1;
k3 = 0.05;

dAHM  = -k1*AHM*EtAc;
dEtAc = -k1*AHM*EtAc + k3*Ac*Etan;
dAAM  = k1*AHM*EtAc  - k2*AAM;
dEtan = k1*AHM*EtAc  - k3*Ac*Etan;
dCris = -k2*Cris;
dFero = k2*AAM*Cris;
dAc   = -k3*Ac*Etan;

sys = [dAHM dEtAc dAAM dEtan dCris dFero dAc];


function sys=mdlOutputs(~,y,u)

sys = y;
sys(sys < 0) = 0;