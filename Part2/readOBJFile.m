clear all
close all

KaKdKs_Chooser = 0;

%% show the obj file at 3D figure
al = fopen('al7KC.obj');

vertex_al = fscanf(al,'v %f %f %f %f %f %f\n',[6, Inf])';
faces_al = fscanf(al,'f %f %f %f\n',[3, Inf])';

fclose(al);

vertex = vertex_al(:,1:3);
faces = faces_al;
colors = vertex_al(:,4:6);

x_min = min(vertex_al(:,1));
x_max = max(vertex_al(:,1));
y_min = min(vertex_al(:,2));
z_min = min(vertex_al(:,3));
y_max = max(vertex_al(:,2));
z_max = max(vertex_al(:,3));

x_mid = (x_max+x_min)/2;
y_mid = (y_max+y_min)/2;
z_mid = (z_max+z_min)/2;

shift = repmat([-x_mid -y_mid -z_mid],3618,1);
vertex = vertex + shift;

%% Adding the HSV color cylinder onto the same world space as al7KC.obj, and then do some transformation
% (Hint) You can try to combine 2 objects' vertices, faces together

[C_faces_offset,tp] = size(vertex);
[Cfaces , Cverts , CvertColors, CtopVertIndex , CbotVertIndex] = DrawCy();
C_v_shift = repmat([0,2.5,-2.5],122,1);
C_f_shift = repmat([C_faces_offset C_faces_offset C_faces_offset] , 242,1);

Cfaces = Cfaces + C_f_shift;
Cverts = Cverts  + C_v_shift;

faces = [ faces ; Cfaces ];
vertex = [vertex ; Cverts];
colors = [colors ; CvertColors];

%% Lighting (You may need to modify the lighting here)
if KaKdKs_Chooser == 0
    trisurf(faces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
elseif KaKdKs_Chooser == 1
    trisurf(faces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',1.0,'DiffuseStrength',0.0,'SpecularStrength',0.0);   
elseif KaKdKs_Chooser == 2
    trisurf(faces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',0.1,'DiffuseStrength',1.0,'SpecularStrength',0.0);
elseif KaKdKs_Chooser == 3
    trisurf(faces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',0.1,'DiffuseStrength',0.1,'SpecularStrength',1.0);
else
    trisurf(faces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',0.1,'DiffuseStrength',0.8,'SpecularStrength',1.0);
end
Directional = 'infinite';
Position = 'local';
light('Position',[0.0,0.0,5.0], 'Style', Directional, 'Visible', 'on');
lighting phong;
