clear all
pkg load image

imagem = imread('levi.png')
imagemPreta = rgb2gray(imagem)
imagemNoise = imnoise(imagemPreta, 'salt & pepper')

imshow(imagemNoise)