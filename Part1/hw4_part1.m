clear all; close all; clc;
%%
rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);

Max_points = 40;
curve_points = 0;
Mode = 'low'
if strcmp(Mode , 'low') == 1
    curve_points = 6;
else
    curve_points = 101;
end

%% Mouse input
xlabel ('Select at most 100 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(Max_points-1);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);

promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);

%% Calculate Bazier Curve (Your efforts here)
%outlineVertexList = ctrlPointList; %Enrich outlineVertexList
outlineVertexList = []
out_idx = 1;
Low_Lod = 0 : 0.2 : 1
High_Lod = 0 : 0.01 : 1
M = [-1 3 -3 1 ; 3 -6 3 0 ; -3 3 0 0; 1 0 0 0]
for i = 1 : 3 :  Max_points-4
    Gx = [ctrlPointX(i) ctrlPointX(i+1) ctrlPointX(i+2) ctrlPointX(i+3)]';
    Gy = [ctrlPointY(i) ctrlPointY(i+1) ctrlPointY(i+2) ctrlPointY(i+3)]';
        for j = 1 : curve_points
        if strcmp(Mode , 'low') == 1
           cur_t = Low_Lod(j);
        else
            cut_t = High_Lod(j);
        end
         T = [cur_t^3 cur_t^2 cur_t 1];
         Px(j) = T*M*Gx;
         Py(j) = T*M*Gy;
        end
    outlineVertexList = [outlineVertexList ; Px' Py'];
end
mp = Max_points;
Gx = [ctrlPointX(mp-3) ctrlPointX(mp-2) ctrlPointX(mp-1) ctrlPointX(1)]';
Gy = [ctrlPointY(mp-3) ctrlPointY(mp-2) ctrlPointY(mp-1) ctrlPointY(1)]';
for j = 1 : curve_points
    if strcmp(Mode , 'low') == 1
        cur_t = Low_Lod(j);
    else
        cut_t = High_Lod(j);
    end
     T = [cur_t^3 cur_t^2 cur_t 1];
     Px(j) = T*M*Gx;
     Py(j) = T*M*Gy;
end
outlineVertexList = [outlineVertexList ; Px' Py'];


size(ctrlPointList)


%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)

figure; result = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result, 'result.png');
