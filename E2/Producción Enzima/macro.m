% Integración sistema Producción proteina recombinante.

Xa0 = 0;
Xz0 = 0;
Xg0 = 0;
Xe0 = 0;
x0  = 0.5;
S0  = 20;
Ac0 = 0;

Y0 = [Xa0 Xz0 Xg0 Xe0 x0 S0 Ac0];

[t,y] = ode23s(@fun_react , [0 15], Y0);