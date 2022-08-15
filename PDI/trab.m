— TRABALHO PDI —

//THRESHOLDING

img = imread("image1.jpg");
imshow(img);
gimg = rgb2gray(img);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(gimg);
size(gimg);
thimg = gimg > 158;
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(thimg);
subplot(1,2,1);imshow(gimg);subplot(1,2,2);imshow(thimg);
gimg(1:10, 1:10)
thimg(1:10, 1:10)


// ANSWER

>> img = imread("image1.jpg");
>> imshow(img)
>> gimg = rgb2gray(img);
>> subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(gimg)
>> size(gimg)
ans =

   5040   3360

>> thimg = gimg > 158;
>> subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(thimg)
>> subplot(1,2,1);imshow(gimg);subplot(1,2,2);imshow(thimg)
>> gimg(1:10, 1:10)
ans =

  207  206  208  209  209  211  211  205  205  205
  205  206  210  209  205  207  210  208  206  206
  205  208  213  210  203  204  210  211  207  206
  209  211  214  210  204  206  212  214  209  206
  212  211  211  209  205  209  213  212  213  208
  213  209  207  206  205  209  211  207  215  211
  212  209  208  207  206  209  211  206  212  211
  212  210  210  209  207  210  211  207  207  209
  205  210  207  205  210  209  205  206  203  203
  206  210  209  208  212  213  210  210  211  213

>> thimg(1:10, 1:10)
ans =

  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1


// ESCALA DE CINZA

img = imread("image1.jpg");
imshow(img);
gimg = rgb2gray(img);
figure, imshow(gimg);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(gimg);

—HISTORGRAMA ESCALA CINZA
imhist(gimg);


// FILTRO DA MEDIA

%% average fspecial I = imread('eight.tif'); figure, imshow(I); title('Imagem Original');  h = fspecial('average',3); % filtro da média a3 = imfilter(I,h); figure, imshow(a3); figure,imshow (im2bw(a3)); 
 
h = fspecial('average',5); % filtro da média a5 = imfilter(I,h); figure, imshow(a5); figure,imshow (im2bw(a5));
 
h = fspecial('average',7); % filtro da média a7 = imfilter(I,h); figure, imshow(a7); figure,imshow (im2bw(a7));
 
h = fspecial('average',11); % filtro da média a11 = imfilter(I,h); figure, imshow(a11); figure,imshow (im2bw(a11)); %% contar as moedas I = imread('eight.tif'); figure, imshow(I); title('Imagem Original');  h = fspecial('average',7); % filtro da média K = imfilter(I,h); figure, imshow(K);
 
bw= ~im2bw(K,0.7); figure, imshow(bw); bw=imclearborder(bw);
 
stats = regionprops(bw, 'all'); size(stats)


// PASSA ALTA

BÁSICO
h = [-1/9 -1/9 -1/9; -1/9 8/9 -1/9; -1/9 -1/9 -1/9;]
pa =imfilter(img,h);
imshow(pa*10);
%zoom(1.2);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(pa*10);


ALTO REFORÇO

A = 2;
ar = (A-1)*img+pa;
imshow(ar);
%zoom(1.5);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(ar);


// BINARIZACAO

bw= im2bw(img);
imshow(bw);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(bw);


// PASSA BAIXA

h = fspecial('average',25)
pb = imfilter(img,h);
imshow(pb);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(pb);
% zoom(1.2)

% im2bw
bw= im2bw(pb,.8);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(bw);
imshow(bw);


MÉDIA
% adiciona ruído na imagem J = imnoise(img,’salt & pepper'); imshow(J);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(J); title("salt & pepper");
 
figure(4), subplot(2,1,2); imhist(med);

%passa baixa
h = fspecial('average',7)
pb = imfilter(J,h);
imshow(pb);
subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(pb);title('Passa Baixa');zoom(1.2);



MEDIANA
Your image is a very likely a color image with RGB frames. medfilt2 only works on 2D images of a single color. The easiest workaround is probably to apply it on each color separately.
See example:
% load an image
img = imread('peppers.png');

% add some noise
img_noisy = imnoise(img, 'salt & pepper', 0.02);
figure; imshow(img_noisy);

% apply medfilt2 on each color
img_filtered = img_noisy;
for c = 1 : 3
    img_filtered(:, :, c) = medfilt2(img_noisy(:, :, c), [3, 3]);
end
figure; imshow(img_filtered);



——— OUTRO JEITO
img = rgb2gray(img);
J = imnoise(img,’salt & pepper');
med = medfilt2(J,[7,7]); figure(5); imshow(med);title('Mediana'); subplot(1,2,1);imshow(img);subplot(1,2,2);imshow(med);title('Passa Baixa');zoom(1.2);
 
figure(5), subplot(2,2,3); imhist(pb);  figure(5), subplot(2,2,4); imhist(med);



// Mediana

% median
Img = gb2gray(img); 
med= medfilt2(img);
figure(5);
imshow(med);
title('Mediana');
zoom(1.2);


// PREWITT

——— GRAYSCALE
— SIMPLES
img = rgb2gray(img);
BW2 = edge(img,’prewitt');
figure, imshow(BW2);title('Prewitt');


————
%% Prewitt e exibir a imagem. % I = imread('board.tif'); % I = imread('circuit.tif'); % I = imread('peppers.png'); % I = rgb2gray(I); img = imread(‘image1.’jpg);
 
figure(1);subplot(2,2,1);imshow(img);title('Imagem Original'); % figure(2); % subplot(1,2,1); %dividir a figura para 2 imagens % imshow(I); % title('Imagem Original');

h = fspecial('prewitt'); % filtro Sobel
K = imfilter(img,h);
figure(1);subplot(2,2,2);imshow(K);title('Prewitt: Horizontal');
K2 = imfilter(img,h); % mesmo filtro transposto.
figure(1);subplot(2,2,3);imshow(K2);title('Prewitt: Vertical');
K=K+K2; % combinar as duas imagens para resultado final
figure(1);subplot(2,2,4);imshow(K);title('Prewitt: Vertical + Horizontal');
figure(2);subplot(1,2,2);imshow(K);title('Prewitt: Vertical + Horizontal');

figure(2);subplot(1,2,1);imshow(img+K);title('Original + Prewitt: Vertical + Horizontal');

// SOBEL 

—— SIMPLES
—GRAYSCALE
img = rgb2gray(img);
BW3 = edge(img,’sobel');
figure, imshow(BW3);title('Sobel');

————
%% Sobel. Ler e exibir a imagem. I = imread('board.tif'); % I = imread('circuit.tif'); % I = imread('peppers.png'); % I= rgb2gray(I); % I = imread('eight.tif');
 
figure(3);subplot(2,2,1);imshow(img);title('Imagem Original'); figure(4);subplot(1,2,1);imshow(img);title('Imagem Original');
 
 h = fspecial('sobel'); % filtro Sobel K = imfilter(img,h); figure(3);subplot(2,2,2);imshow(K);title('Sobel: Horizontal'); K2 = imfilter(img,h’); % mesmo filtro transposto. figure(3);subplot(2,2,3);imshow(K2);title('Sobel: Vertical'); K=K+K2; % combinar as duas imagens para resultado final figure(3);subplot(2,2,4);imshow(K);title('Sobel: Vertical + Horizontal'); figure(4);subplot(1,2,2);imshow(K);title('Sobel: Vertical + Horizontal');   figure(6);subplot(1,2,1); imshow(img);subplot(1,2,2);imshow(img+K);title('Original + Sobel: Vertical + Horizontal');



// ROBERTS

—GRAYSCALE
%%
img = imread(‘image1.jpg’);
img = rgb2gray(img);
figure, imshow(img);title('Original');
BW1 = edge(img,’roberts');
figure, imshow(BW1);title('Roberts');


// CANNY

— GRAYSCALE
img = imread(‘image1.jpg’);
img = rgb2gray(img);
BW4 = edge(img,’canny');
figure, imshow(BW4);title('Canny');


// LOG

—GRAYSCALE
img = imread(‘image1.jpg’);
img = rgb2gray(img);
BW5 = edge(img,’log');
figure, imshow(BW5);title('Log');
BW6 = edge(img,’log');figure, imshow(BW6);title('Laplacian of Gaussian');


// HISTOGRAMA E AJUSTES

imshow(img);
figure, imhist(img);

—— GRAYSCALE BINARIZAR
figure, imshow(histeq(img));
figure, imhist(histeq(img));

img(10:110, 10:110)=0;

img=0;

— AJUSTES

img = imread(‘image1.jpg’);
figure, imshow(img);
bw= im2bw(img);
figure, imshow(bw);

se = strel('disk',15, 0);
background = imopen(img,se);
figure, imshow(background);

img2 = img - background;
figure, imshow(img2);

img3 = imadjust(img2);
figure,imshow(img3)

bw = im2bw(img3);
bw = bwareaopen(bw,50);
bw = imclearborder(bw);
figure, imshow(bw);