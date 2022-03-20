%% loading point cloud
clear
close all

% read .ply
pc = pcread('./data/noisy_pointCloud_example_2.ply');
point = pc.Location';

% ground truth configuration of the superquadric
x_gt = [0.1108 0.2786 0.6506 1.4863 1.8478 2.1758 2.6031 0.3712 -0.0551 -0.0617 0.0120];
% where epsilon = [0.1108 0.2786], a = [0.6506 1.4863 1.8478], 
% euler = [2.1758 2.6031 0.3712],  translation = [-0.0551 -0.0617 0.0120]

%% Superquadric Recovery

% applying ns method
[x_ns] = numerical_fitting(point);
% applying radial-lsq method
[x_radial] = superquadricsFitting(point, 'Radial');
% applying EMS method
[x_ems] = EMS(point);

% print ground truth and recovered parameters
disp('---------------------------------------------------------------------')
disp('Groud Truth parameters are');
disp(x_gt)
disp('---------------------------------------------------------------------')
disp('NS Fitted parameters are')
disp(x_ns)
disp('Radial-LSQ Fitted parameters are')
disp(x_radial)
disp('EMS Fitted parameters are')
disp(x_ems)
disp('---------------------------------------------------------------------')

% plot input points and rendering recovered superquadric
figure(1)
showPoints(point, 'Color', 'r')
hold on
showSuperquadrics(x_ns, 'Color', [0 0 1], 'FaceAlpha', 0.7, 'Arclength', 0.05, 'Light', 1);
hold off
title('NS Recovered Superquadric')

figure(2)
showPoints(point, 'Color', 'r')
hold on
showSuperquadrics(x_radial, 'Color', [0 0 1], 'FaceAlpha', 0.7, 'Arclength', 0.05, 'Light', 1);
hold off
title('Radial-LSQ Recovered Superquadric')

figure(3)
showPoints(point, 'Color', 'r')
hold on
showSuperquadrics(x_ems, 'Color', [0 0 1], 'FaceAlpha', 0.7, 'Arclength', 0.05, 'Light', 1);
hold off
title('EMS Recovered Superquadric')