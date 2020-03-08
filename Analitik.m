clear
clc
mu=4*pi*1e-7;
Area=2*pi*12.5e-3*(74/360)*20e-3;
air_gap_min=5*1e-4*2;
air_gap_max=25*1e-4*2;
degree=0:1:360;
turn_number=250;
current=3;

for position=0:1:180
    if (position<=74)
        effective_air_gap(position+1)=((74-position)*air_gap_min+(position)*air_gap_max)/74;
    elseif (74<position & position<106)
        effective_air_gap(position+1)=air_gap_max;
    elseif (position>=106)
        effective_air_gap(position+1)=((180-position)*air_gap_max+(position-(180-74))*air_gap_min)/74;
    end
end
effective_air_gap=[effective_air_gap effective_air_gap(1,2:181)]; %due to symmetry  

Reluctance=effective_air_gap./(mu*Area);
        
Inductance=turn_number^2./Reluctance;

%plot(Inductance)

for i=1:360
    torque(i)=(Inductance(i+1)-Inductance(i))/(pi/180)*0.5*current^2;
end
torque(361)=torque(1);
plot(torque)

figure
subplot(3,1,1)
plot(Reluctance,'LineWidth',2);
xlabel('Rotor angle (degrees)','FontSize',12,'FontWeight','bold');
ylabel('Reluctance (Amperes/Weber)','FontSize',12,'FontWeight','bold');
set(gca,'FontSize',12,'FontWeight','bold')
grid on
xlim([0 360])
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])

% figure
subplot(3,1,2)
plot(Inductance,'LineWidth',2);
xlabel('Rotor angle (degrees)','FontSize',12,'FontWeight','bold');
ylabel('Inductance (Henry)','FontSize',12,'FontWeight','bold');
set(gca,'FontSize',12,'FontWeight','bold')
grid on
xlim([0 360])
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])

% figure
subplot(3,1,3)
plot(torque,'LineWidth',2);
xlabel('Rotor angle (degrees)','FontSize',12,'FontWeight','bold');
ylabel('Torque (Nm)','FontSize',12,'FontWeight','bold');
set(gca,'FontSize',12,'FontWeight','bold')
grid on
xlim([0 360])
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])

    