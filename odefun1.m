function dydt = odefun1(x,y)
    dydt = (x^2+y-7+2*y*(y^2+x-4))/(2*x*(x^2+y-7)+y^2+x-4);