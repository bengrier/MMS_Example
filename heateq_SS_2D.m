%Code based off of Heat Diffusion in 2D by Dr. Mohamed Tawfik and Amr Mousa Mohamed
%Edited for Example by Ben Grier

clear all; close all;

 %% 1-Inputs section

Lx= 1;                             % plate width (m)
Ly= 1;                             % plate length (m)
Nx=40;                             % nodes in x direction
Ny=Nx;                             % nodes in y direction

T_initial= 0 ;                   % Initial temperature in all nodes ( the whole plate )
T_east   = 150 ;                   % temperature on the upper side ( at y=0  "Dirichlet Conditions" )
T_west   = 300 ;                   % temperature on the lower side ( at y=Ly "Dirichlet Conditions" )
T_north  = 50 ;                   % temperature on the left  side ( at x=0  "Dirichlet Conditions" )
T_south  = 100 ;                   % temperature on the right side ( at x=Lx "Dirichlet Conditions" ) 

tolerence_ss=1e-8;                % tolerence for steady state section (0.1 deg Celesius)

%% 2- Constants Section
 
k=1;                                                                       % iteration counter
err_SS_max(k)=1;                                                           % initial error
dx=Lx/Nx;                                                                  % delta x
dy=Ly/Ny;                                                                  % delta y
T_max=max([T_east T_west T_north T_south T_initial]);                      % Max T to set axes limits in plotting
T_min=min([T_east T_west T_north T_south T_initial]);                      % Min T to set axes limits in plotting

% ------------------- Initial Conditions for steady state section -------------------
Tss=zeros(Nx+2,Ny+2);        Tss2=zeros(Nx+2,Ny+2);
Tss(:,1)=T_south;            Tss2(:,1)=T_south;
Tss(:,Ny+2)=T_north;         Tss2(:,Ny+2)=T_north;             
Tss(Nx+2,:)=T_east;          Tss2(Nx+2,:)=T_east;              
Tss(1,:)=T_west;             Tss2(1,:)=T_west;


%% 3- Steady-State section


   while err_SS_max(k)>=tolerence_ss 
    
    for i=2:Nx+1                                                  
        for j=2:Ny+1
            Tss2(i,j)=0.25*(Tss(i+1,j)+Tss(i,j+1)+Tss(i-1,j)+Tss(i,j-1));
        end
    end
    k=k+1;                                                        % update k
    err_SS_max(k)=abs(max(max(Tss2-Tss)));                        % calculate error
    Tss=Tss2;                                                     % update T
   end
    
   figure()
   semilogy(err_SS_max,'r');
   
%% 6- Plotting section

x=zeros(1,Nx+2);y=zeros(1,Ny+2);            %Generate the plate
for i = 1:Nx+2                 
x(i) =(i-1)*dx; 
end
for i = 1:Ny+2                 
y(i) =(i-1)*dy; 
end

% %%%            -------------- Constant plot ----------------
figure();
%contourf(x,y,Tss,20)
surf(x,y,Tss,'EdgeColor','none');
view(90,90);
title('SS Solution')
cb=colorbar;
caxis([T_min T_max]);
xlim([0 Lx+dx]); xlabel('Length');
ylim([0 Ly+dy]); ylabel('Width');

