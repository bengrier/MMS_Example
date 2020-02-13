%Manufactured Solution for Heat equation MMS example
%Written by Ben Grier

function [T] = manufactured_solution(x,y)
    T=cos(x^2+y^2);
    %T=sin(x+y);
end