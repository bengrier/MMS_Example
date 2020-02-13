%Calculate L2 norms for Heat equation MMS example
%Written by Ben Grier
%Currently works for a set of grid sizes 10x10,20x20,40x40, and 80x80

function [] = L2_norm()

files=4;
for(k=1:files)
    load(['Tss',num2str(10*2^(k-1)),'.mat']); %Load files saved by heateq_SS_2D_MMS.m
    eval(['Tss=Tss',num2str(10*2^(k-1)),';']);
    grid_size(k)=10*2^(k-1);
    
    %Regenerate Plate grid based on size of Tss
    Nx=length(Tss)-2;
    Ny=Nx;
    x=zeros(1,Nx+2);y=zeros(1,Ny+2);            
    for i = 1:Nx+2                 
    x(i) =(i-1)/Nx; 
    end
    for i = 1:Ny+2                 
    y(i) =(i-1)/Ny; 
    end
    
    %Calculate L2 based on uniform grid
    L2sum=0;
    for(i=2:Nx+1)
        for(j=2:Ny+1)
            L2sum=L2sum+(Tss(i,j)-manufactured_solution(x(i),y(j)))^2;
        end
    end
    L2(k)=sqrt(1/(Nx*Ny)*L2sum);
end

for(k=2:files)
    p(k-1)=log(L2(k-1)/L2(k))/log(2);
end

fprintf('\n\nGrid\tSize\tL2\t\tp\n');
fprintf('Grid 1\t%dx%d\t%f\t--\n',grid_size(1),grid_size(1),L2(1));
for(k=2:files)
    fprintf('Grid %d\t%dx%d\t%f\t%.3f\n',k,grid_size(k),grid_size(k),L2(k),p(k-1));
end

end
