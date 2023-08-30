file_path = 'W:\桌面\新建文件夹 (3)\';
img_path_list =  dir(strcat(file_path,'*.png'));
img_num = length(img_path_list);
if img_num > 0
    for i = 1+51 : 51+img_num
        image_name = img_path_list(i-51).name;
        headdata1 = rgb2gray(imread(strcat(file_path, image_name)));
%         figure
%         imshow(headdata1)
        headdata2 = headdata1;
        [a1, b1, L1 ,L2 ,L3] = FindSidePoint(headdata2);
        headdata3 = imcrop(headdata2,[a1, b1, L1 ,L2]);  
%         figure
%         imshow(headdata3)
        L4 = floor(1.35*L3);
        headdata4=255*ones(L4);
        headdata4(L4/2 - L2/2 : L4/2 + L2/2, L4/2 - L1/2 : L4/2 + L1/2) = headdata3;
%         figure
%         imshow(headdata4)
        headdata5 = imbinarize(imresize(headdata4, [800 800], 'bicubic'), 0.7);
        filepathnewname = strcat('W:\桌面\新建文件夹\', 'image_', num2str(i), '.png');
        imwrite(headdata5 , filepathnewname);
    end
end
