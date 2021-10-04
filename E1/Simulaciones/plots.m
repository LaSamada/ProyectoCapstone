% Gráficos extraidos del análisis de sensibilidad en ASPEN PLUS

data1 = readtable('TEMP-GLU.xlsx');
data1 = table2array(data1);

data2 = readtable('ACID-GLU.xlsx');
data2 = table2array(data2);

data3 = readtable('A-T-GLU.xlsx');
data3 = table2array(data3);

% Análisis Temperatura vs Glucosa y Furfural
figure(1);
colororder({'k','k'})
plot(data1(:,1),data1(:,2),'-r','linewidth',1.5); hold on;
plot(data1(:,1),data1(:,3),'-b','linewidth',1.5); hold off;
ylabel('Glucosa, Furfural [kg/h]')
grid on;
xlabel('Temperatura [°C]')
legend('Glucosa','Furfural','location','best')

figure(2);
colororder({'k','k'})
yyaxis left
plot(data2(:,1),data2(:,2),'-r','linewidth',1.5); hold on;
ylabel('Glucosa [kg/h]')

yyaxis right
plot(data2(:,1),data2(:,3),'-b','linewidth',1.5); hold off;
ylabel('Furfural [kg/h]')
grid on;
xlabel('Flujo de Ácido [kg/h]')
legend('Glucosa','Furfural','location','best')

figure(3);
x = linspace(50,200,50);
y = linspace(0.5,100,50);

[X,Y] = meshgrid(x,y);
Z     = reshape(data3(:,3),50,50);
Z2    = reshape(data3(:,4),50,50);

surf(X,Y,Z,'EdgeColor','none')
colorbar
colormap cool
xlabel('Temperatura [°C]')
ylabel('Flujo H_2SO_4 [kg/h]')
zlabel('Glucosa [kg/h]')

figure(4);
surf(X,Y,Z2,'EdgeColor','none')
colorbar
colormap autumn
xlabel('Temperatura [°C]')
ylabel('Flujo H_2SO_4 [kg/h]')
zlabel('Furfural [kg/h')
