%Manufactured solution source term for Heat equation MMS example
%Written by Ben Grier

function [Q] = Source_Term(x,y)
    Q=4*sin(x^2+y^2)+(4*x^2+4*y^2)*cos(x^2+y^2);
    %Q=2*sin(x+y);
end