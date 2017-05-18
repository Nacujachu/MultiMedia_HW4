clear all; close all; clc;
[faces , verts , vertColors, topVertIndex , botVertIndex] = DrawCy();

trisurf(faces,verts(:,1),verts(:,2),verts(:,3),'FaceVertexCData', vertColors,'FaceColor','interp', 'EdgeAlpha', 0);
