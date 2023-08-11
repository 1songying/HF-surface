function dydt = odefun(x,y)
    dydt = (x^2+y-4+2*y*(y^2+x-7))/(2*x*(x^2+y-4)+y^2+x-7);