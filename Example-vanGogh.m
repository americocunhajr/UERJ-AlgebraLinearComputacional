clc 
clear 
close all

% import images from .jpg files
ImageFiles = dir('*.jpg');
Nfiles.    = length(ImageFiles); 
ImagesRGB  = cell(1, Nfiles);

for n = 1:Nfiles
   CurrentFileName = ImageFiles(n).name;
   CurrentImage    = imread(CurrentFileName);
   ImagesRGB{n}    = CurrentImage;
end

% function to convert from RBG to double vector
function ImageVector = ImageRGB2ImageVector(ImageRGB)
    ImageVector = reshape(uint8(rgb2gray(ImageRGB)),[],1);
end

% function to compute the angle between vectors
function cos_theta = VectorSimilarity(v1,v2)
    cos_theta = dot(v1,v2)/(norm(v1)*norm(v2));    
end

% compute norm and similarity between images
ImagesNorm       = zeros(Nfiles, 1); 
ImagesSimilarity = zeros(Nfiles, Nfiles);

for m = 1:Nfiles 
   Image1          = ImageRGB2ImageVector(ImagesRGB{m});
   ImagesNorm(m,1) = Norm(Image1);

   for n = 1:Nfiles
      Image2                = ImageRGB2ImageVector(ImagesRGB{n});
      ImagesSimilarity(m,n) = VectorSimilarity(Image1,Image2);
   end
end

% show norm and similarity measures
ImagesNorm
ImagesSimilarity