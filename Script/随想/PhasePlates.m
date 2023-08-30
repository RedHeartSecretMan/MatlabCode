%pkg load image
% initialize (empty) phase plate
slm_width = 792;
slm_height = 600;
slm_pix_size = 12.5e-6;

beam_diameter = 1.68e-3;
circ_pp_diameter = 0.66;

pp_width = slm_width / 2;

pp_file = "slm_pp.tif";

p = zeros(slm_height, slm_width);

% Calculate Vortex ('2D') phase plate for the left side
for y = 1 : slm_height
  for x = 1 : pp_width
    p(y, x) = (atan2(y - slm_height / 2, x - pp_width / 2) + pi);
  end
end

% Calculate Circular ('3D') phase plate for the left side
pp_limit = (beam_diameter * circ_pp_diameter / slm_pix_size)^2;
for y = 1 : slm_height
  for x = 1 : pp_width
    r = (x - pp_width / 2)^2 + (y - slm_height / 2)^2;
    if r < pp_limit
      p(y, x + pp_width) = pi;
     end
  end
end

img_pp = im2uint8(p / (2*pi));
figure; imshow(img_pp);
imwrite(img_pp);
