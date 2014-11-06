inputimg = imread('6circles.png');

% threshold
inputimg(inputimg~=255) = 0;
imshow(inputimg)
%%
imgsize = size(inputimg);
maxradius = ceil(sqrt((imgsize(1)/2)^2 + (imgsize(2)/2)^2));
cx = imgsize(2)/2;
cy = imgsize(1)/2;

% how many radius points do we want?
% 360 = 1 pt per degree.
% laser scanner does 0.25 degrees per point -> 1440 pts
pts = 1440;

outputimg = ones(pts, maxradius)'*255;
angles = linspace(0, 2*pi, pts);

for th = 1:pts
    for r = 1:maxradius
        x = round(cos(th/pts*2*pi) * r + cx);
        y = round(sin(th/pts*2*pi) * r + cy);
        if (x < 1) || (x > imgsize(2)) || (y < 1) || (y > imgsize(1))
            continue
        end
        outputimg(r,th) = inputimg(y,x);
    end
end

% improve visibility by rotating so the edge doesn't fall in the middle
% of a shape
outputimg = circshift(outputimg, [0,100]);


% flip to make it more intuitive
outputimg=flipud(outputimg);
imshow(outputimg)
xlabel('Theta')
ylabel('Raidus')

