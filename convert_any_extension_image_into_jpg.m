%clear all command window and workshop 
clc
clear all 
close all
myFolder = 'C:\Users\shivpoojan saini\Desktop\image_extension_conversion\inputfolder';%loction from where images will be read
outputfolder = 'C:\Users\shivpoojan saini\Desktop\image_extension_conversion\outputfolder';%location where all image in jpg will store
if ~isdir(myFolder)%check for existance of folder
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
if ~isdir(outputfolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', outputfolder);
  uiwait(warndlg(errorMessage));
  return;
end
count =1;%value will be name of non jpg image 
image_read = dir(myFolder);
for j=1:length(image_read)
    thisname = image_read(j).name;%read image from myfolder
    thisfile = fullfile(myFolder, thisname);%full file name of image
    try
      Img = imread(thisfile);  %  read image
      %Im = Img(:,:,1);  % if want gray scale image 
      image_information = imfinfo(thisfile)%get image information
      image_extension = image_information.Format%get image extension
      if image_extension == 'tif'%if image is of tiff extension
            Img = Img(:,:,1:3); %Discard transperency layer from tiff
            outfile = sprintf('%d.jpg',count)%create jpg name extension for non jpg extension image
            outfilename = fullfile(outputfolder,outfile)%full output image with jpg extension
            imwrite(Img,outfilename)  %write image in outputfolder
            count = count+1;
      elseif  image_extension == 'pdf';     
      elseif  image_extension ~= 'jpg' | image_extension == 'png'%check  image extension 
          outfile = sprintf('%d.jpg',count)%create jpg name extension for non jpg extension image
          outfilename = fullfile(outputfolder,outfile)%full output image with jpg extension
          imwrite(Img,outfilename)  %write image in outputfolder
          count = count+1;
      elseif image_extension == 'jpg'%jpg image will directly wirte in output folder 
          outfilename = fullfile(outputfolder,thisname)
          imwrite(Img,outfilename)
      
      end
      imshow(Img)%show image
      title(thisname);%tiltle of image
      pause(1)%create delay of 1 sec between images
    catch
    end
  
end
