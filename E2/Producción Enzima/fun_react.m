function yp = fun_react(t,y)

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

	C1  = 0.1;


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

	yp = [dXa dXz dXg dXe dx dS dAc]';
end