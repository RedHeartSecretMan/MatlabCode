%%  start to do
clear;close all;clc;
data = imread('/Users/WangHao/Pictures/雪山.jpg');
outputFileName = '保存名称.tif';
t = Tiff(outputFileName,'w');

% Setup tags
tagstruct.ImageLength         = size(data ,1);
tagstruct.ImageWidth          = size(data ,2);
tagstruct.SampleFormat        = Tiff.SampleFormat.UInt;
tagstruct.BitsPerSample       = 8;
tagstruct.SamplesPerPixel     = 1;
tagstruct.Photometric         = Tiff.Photometric.MinIsBlack;
tagstruct.RowsPerStrip        = 16;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software            = 'MATLAB';
% tagstruct.DateTime            = char(datetime('now','TimeZone','local','Format','y年MMMd日 HH:mm'));
tagstruct.Artist              = 'wyyd';
setTag(t,tagstruct)   % t.setTag(tagstruct)

% write data
t.write(data);
t.close;   % 退出创建tiff对象的进程，若不执行，生成的图片将无法打开