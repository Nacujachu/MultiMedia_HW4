clear all; close all; clc;

rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);

%% Mouse input
xlabel ('Select at most 100 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(100);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);

promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);

%% Calculate Bazier Curve (Your efforts here)
outlineVertexList = ctrlPointList; %Enrich outlineVertexList

%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)

figure; result = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
imwrite(result, 'result.png');
