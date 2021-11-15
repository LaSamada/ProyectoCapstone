% Macro modelo producción feromona

out = sim('model.slx');

t  = out.time;

% Fermentador:
Xa = out.reac1(:,1); Xg = out.reac1(:,3);
Xz = out.reac1(:,2); Xe = out.reac1(:,4);
x  = out.reac1(:,5); S  = out.reac1(:,6);
Ac = out.reac1(:,7);

figure(1)
subplot(2,1,1);
plot(t,Xa,'-r','linewidth',1.5); grid on; hold on;
plot(t,Xg,'-b','linewidth',1.5)
plot(t,Xz,'-g','linewidth',1.5); hold off
xlim([0 25])
subplot(2,1,2);
plot(t,Xe,'-c','linewidth',1.5); grid on;
xlim([0 25])

figure(2);
plot(t,x,'-r','linewidth',1.5); grid on; hold on;
plot(t,S,'-b','linewidth',1.5)
plot(t,Ac,'-g','linewidth',1.5); hold off
xlim([0 25])

% Reactor enzimático:

S  = out.reac2(:,1);
P  = out.reac2(:,2);

figure(3);
subplot(2,1,1);
plot(t,S,'-c','linewidth',1.5); grid on;
xlabel('t [hr]')
ylabel('Prenol [mol/L]')
xlim([25 121])
subplot(2,1,2);
plot(t,P,'-b','linewidth',1.5); grid on;
xlabel('t [hr]')
ylabel('Crisantemol [mol/L]')
xlim([25 121])

% Reactor químico

AHM  = out.reac3(:,1);
EtAc = out.reac3(:,2);
AAM  = out.reac3(:,3);
Etan = out.reac3(:,4);
Cris = out.reac3(:,5);
Fero = out.reac3(:,6);
Ac   = out.reac3(:,7);

