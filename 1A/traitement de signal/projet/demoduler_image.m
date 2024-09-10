

load 'FICHIERS POUR ELEVES IMAGES/fichier1.mat';
image_1 = demoduler(signal);
load 'FICHIERS POUR ELEVES IMAGES/fichier2.mat';
image_2 = demoduler(signal);
load 'FICHIERS POUR ELEVES IMAGES/fichier3.mat';
image_3 = demoduler(signal);
load 'FICHIERS POUR ELEVES IMAGES/fichier4.mat';
image_4 = demoduler(signal);
load 'FICHIERS POUR ELEVES IMAGES/fichier5.mat';
image_5 = demoduler(signal);
load 'FICHIERS POUR ELEVES IMAGES/fichier6.mat';
image_6 = demoduler(signal);

re_image1 = reconstitution_image(image_1);
re_image2 = reconstitution_image(image_2);
re_image3 = reconstitution_image(image_3);
re_image4 = reconstitution_image(image_4);
re_image5 = reconstitution_image(image_5);
re_image6 = reconstitution_image(image_6);

image_recon= [re_image6 re_image1 re_image5;re_image2 re_image4 re_image3];

image(image_recon);