% Macro modelo producción feromona

out = sim('model.slx');

t  = out.time;

% Fermentador:
Xa = out.reac1(:,1); Xg = out.reac1(:,3);
Xz = out.reac1(:,2); Xe = out.reac1(:,4);
x  = out.reac1(:,5); S  = out.reac1(:,6);
Ac = out.reac1(:,7);

figure(1);
yyaxis left
plot(t,x,'-r','linewidth',1.5); grid on; hold on;
plot(t,Ac,'-g','linewidth',1.5); hold off

xlim([0 17])
ylabel('Biomasa & Ac. Acético [g/L]')
xlabel('t [hr]')
yyaxis right
plot(t,S,'-b','linewidth',1.5)
ylabel('Glucosa [g/L]')
title('Dinámica Fermentador')
legend('Biomasa', 'Ácido acético','Glucosa Extracelular')
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';

figure(2)
subplot(2,1,1);
plot(t,Xa,'-r','linewidth',1.5); grid on; hold on;
plot(t,Xz,'-g','linewidth',1.5); hold off
legend('C. comp. celulares activos',...
    'Material celular y DNA cromosomal','location','northwest')
title('Componentes celulares Biomasa')
xlabel('t [hr]')
ylabel('Concentración [g/g(x)]')
xlim([0 17])
subplot(2,1,2);
plot(t,Xe,'-c','linewidth',1.5); grid on; hold on;
plot(t,Xg,'-b','linewidth',1.5); hold off;
ylabel('Concentración [g/g(x))]')
xlabel('t [hr]')
legend('Enzima','Plásmidos Recombinantes','location','northwest')
xlim([0 17])

% Reactor enzimático:

S  = out.reac2(:,1);
P  = out.reac2(:,2);

figure(3);
subplot(2,1,1);
plot(t-25,S,'-c','linewidth',1.5); grid on;
title('Reactor Enzimático')
xlabel('t [hr]')
ylabel('Prenol [mol/L]')
legend('Prenol')
xlim([25-25 121-25])
subplot(2,1,2);
plot(t-25,P,'-b','linewidth',1.5); grid on;
xlabel('t [hr]')
ylabel('Crisantemol [mol/L]')
legend('Crisantemol')
xlim([25-25 121-25])

% Reactor químico

AHM  = out.reac3(:,1);
EtAc = out.reac3(:,2);
AAM  = out.reac3(:,3);
Etan = out.reac3(:,4);
Cris = out.reac3(:,5);
Fero = out.reac3(:,6);
Ac   = out.reac3(:,7);

figure(4);
subplot(2,1,1);
plot(t,AHM,'-r','linewidth',1.5); grid on; hold on;
plot(t,EtAc,'-b','linewidth',1.5)
plot(t,AAM,'-g','linewidth',1.5)
plot(t,Etan,'-m','linewidth',1.5)
% plot(t,Cris,'-b','linewidth',1.5)
plot(t,Ac,'-k','linewidth',1.5); hold off
legend('AHM','EtAc','AAM','Etan','Ac')
xlabel('t [min]')
ylabel('Unidades [mol/L]')
title('Reactor Enzimático 2')
xlim([0 121])

subplot(2,1,2);
yyaxis left
plot(t,Fero,'-c','linewidth',1.5);
grid on;
ylabel('Feromona [mol/L]')
xlabel('t [min]')
%ylim([0 5e-7])
yyaxis right
plot(t,Cris,'-r','linewidth',1.5);
%ylim([0 4e-5])
ylabel('Crisantemol [mol/L]')
xlabel('t [min]')
xlim([0 121])
legend('Feromona','Crisantemol')
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';


