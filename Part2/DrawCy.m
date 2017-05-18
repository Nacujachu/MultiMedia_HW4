function [faces , verts , vertColors, topVertIndex , botVertIndex] = DrawCy()

%xx = 0:2*pi/60 : 2*pi;
%yy = linspace(0,2*pi , 61);
xx = linspace(0,2*pi , 61);
length(xx);
%TOP : 1 is 0,0 : followed by 60 points
%¶ê©P¤W: 2 3 ........ 61
%bot : 62 is 0,0 , followed by 60 points
%¶ê©P¤W: 63 .... 122
topVerts = [ 0 0 0.5];
botVerts = [ 0 0 -0.5];
topVertIndex=[1];
botVertIndex = [62];
vertColors = [];
vertColors =[vertColors;hsv2rgb([0,0,1])];

for i = 1 : 60
    x = cos(xx(i));
    y = sin(xx(i));
    topVerts = [ topVerts ;x y 0.5];
    topVertIndex = [topVertIndex i+1];
    botVerts = [botVerts ; x  y -0.5];
    botVertIndex = [botVertIndex i+62];
    vertColors = [vertColors ; hsv2rgb([xx(i)/(2*pi) , 1 ,1]) ];
end

vertColors = [vertColors ; hsv2rgb([0,1,0])];

for i = 1  :  60
    vertColors = [vertColors ; hsv2rgb([xx(i)/(2*pi) , 1 ,0])];
end
verts = [ topVerts; botVerts ];
%vertColors = reshape(vertColors , [122 ,3]);
faces = [1 2 3];
for i = 3 : 60
    faces = [faces ; 1 i i+1];
end
faces = [faces ;1 61 2 ;62 63 64];
for i = 64 : 121
    faces = [faces ; 62 i i+1];
end
faces = [faces ; 62 121 63];
faces = [faces ; 2 63 3];
a = 2; b = 63 ; c = 3;
for i = 2 : 120
    if mod(i,2) == 0
        faces = [faces ; a b c];
    else
        faces = [faces ; a c b];
    end
    tmp = b;
    a = b; b = c; c = tmp +1;
end
faces = [faces ; 61 122 2];
faces = [faces ; 122 63 2];