%Code based off of Heat Diffusion in 2D by Dr. Mohamed Tawfik and Amr Mousa Mohamed
%Edited for Example by Ben Grier

clear all; close all;

 %% 1-Inputs section

Lx= 1;                             % plate width (m)
Ly= 1;                             % plate length (m)
Nx=20;                             % nodes in x direction
Ny=Nx;                             % nodes in y direction

tolerence_ss=1e-8;                % tolerence for steady state section (0.1 deg Celesius)

%% 2-Setup 
 
k=1;                                                                       % iteration counter
err_SS_max(k)=1;                                                           % initial error
dx=Lx/Nx;                                                                  % delta x
dy=Ly/Ny;                                                                  % delta y

%% 3-Boundary Conditions
x=zeros(1,Nx+2);y=zeros(1,Ny+2);            %Generate the plate
for i = 1:Nx+2                 
x(i) =(i-1)*dx; 
end
for i = 1:Ny+2                 
y(i) =(i-1)*dy; 
end

for(i=1:length(y))
    Tss(1,i)=manufactured_solution(x(1),y(i));
    Tss(Nx+2,i)=manufactured_solution(x(Nx+2),y(i));
    Tss2(1,i)=manufactured_solution(x(1),y(i));
    Tss2(Nx+2,i)=manufactured_solution(x(Nx+2),y(i));
end
for(i=1:length(x))
    Tss(i,1)=manufactured_solution(x(i),y(1));
    Tss(i,Ny+2)=manufactured_solution(x(i),y(Ny+2));
    Tss2(i,1)=manufactured_solution(x(i),y(1));
    Tss2(i,Ny+2)=manufactured_solution(x(i),y(Ny+2));
end

%% 4-Steady-State section

   while err_SS_max(k)>=tolerence_ss
    for i=2:Nx+1                                                   
        for j=2:Ny+1
            %Tss2(i,j)=0.25*(Tss(i+1,j)+Tss(i,j+1)+Tss(i-1,j)+Tss(i,j-1));
            Tss2(i,j)=0.25*(Tss(i+1,j)+Tss(i,j+1)+Tss(i-1,j)+Tss(i,j-1))+dx^2*Source_Term(x(i),y(j))/4;
            %Tss2(i,j)=0.249*(Tss(i+1,j)+Tss(i,j+1)+Tss(i-1,j)+Tss(i,j-1))+dx^2*Source_Term(x(i),y(j))/4;
        end
    end
    k=k+1;                                                        % update k
    err_SS_max(k)=abs(max(max(Tss2-Tss)));                        % calculate error
    Tss=Tss2; % update T
   end
    
   figure()
   semilogy(err_SS_max,'r');
   

%% 5- Plotting section

% %Uncomment to test exact solution
% for(i=2:Nx+1)
%     for(j=2:Ny+1);
%         Tss(i,j)=manufactured_solution(x(i),y(j));
%     end
% end

T_min=min(min(Tss));
T_max=max(max(Tss));

% %%%            -------------- Constant plot ----------------
figure();
%contourf(x,y,Tss,20);
surf(x,y,Tss,'EdgeColor','none');
view(90,90);
title('SS Solution')
cb=colorbar;
caxis([T_min T_max]);
xlim([0 Lx+dx]); xlabel('Length');
ylim([0 Ly+dy]); ylabel('Width');

% Saves file for reading into L2
eval(['Tss',num2str(Nx),'=Tss;']);
eval(['save(''Tss',num2str(Nx),'.mat'',''Tss',num2str(Nx),''');']);



