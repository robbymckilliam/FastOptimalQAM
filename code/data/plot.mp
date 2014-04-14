prologues := 2;
filenametemplate "%j-%c.mps";
input TEX; 
TEXPRE("%&latex" & char(10) & 
"\documentclass{minimal}\begin{document}"); 
TEXPOST("\end{document}"); 
input graph;
input sarith;

picture org;
org := currentpicture;

picture diamond;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm rotated 45;
diamond := currentpicture; currentpicture := org;

picture square;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm;
square := currentpicture; currentpicture := org;

picture circle; 
draw fullcircle scaled 0.17cm;
circle := currentpicture; currentpicture := org;

picture cross; 
draw (-0.09cm,0.0)--(0.09cm,0.0);
draw (0,-0.09cm)--(0,0.09cm);
cross := currentpicture; currentpicture := org;

picture times; times := cross rotated 45;

picture legend; 
sx = 0.2cm;
sh = 0.2cm;
ups = 0.35cm;
label.rt(btex Ambiguity Bound etex, (1cm,sh));
draw (sx,sh)--(1cm,sh) dashed evenly;

label.rt(btex LBOD etex, (1cm,sh + ups));
draw (sx,sh + ups)--(1cm,sh + ups) withcolor(0.7,0.7,0.7);
draw diamond shifted 1/2[(sx,sh + ups),(1cm,sh + ups)];

label.rt(btex LBSD etex, (1cm,sh + 2*ups));
draw (sx,sh + 2*ups)--(1cm,sh + 2*ups) withcolor(0.8,0.8,0.8);
draw cross shifted 1/2[(sx,sh + 2*ups),(1cm,sh + 2*ups)];

label.rt(btex FOD etex, (1cm,sh + 3*ups));
draw (sx,sh + 3*ups)--(1cm,sh + 3*ups) withcolor(0.8,0.8,0.8);
draw circle shifted 1/2[(sx,sh + 3*ups),(1cm,sh + 3*ups)];

legend := currentpicture; currentpicture := org;


picture legendtwo; 
label.rt(btex Ambiguity Bound etex, (1cm,sh));
draw (sx,sh)--(1cm,sh) dashed evenly;

label.rt(btex LBSD etex, (1cm,sh + ups));
draw (sx,sh + ups)--(1cm,sh + ups) withcolor(0.8,0.8,0.8);
draw cross shifted 1/2[(sx,sh + ups),(1cm,sh + ups)];

legendtwo := currentpicture; currentpicture := org;


beginfig(1);

draw begingraph(10cm, 10cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex CER etex, OUT) rotated 90;
 
gdraw (20, 0.046875)--(70,0.046875) dashed evenly;
gdraw (20, 0.00047206878662)--(70,0.00047206878662) dashed evenly;
gdraw (20, 0.01538085937500)--(70,0.01538085937500) dashed evenly;
gdraw (20, 0.0029296875)--(70,0.0029296875) dashed evenly;
gdraw (20, 0.00018310546875)--(70,0.00018310546875) dashed evenly;

gdraw "T3OptimalV3T3.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTSubOptimalV3T3.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTOptimalV3T3.txt"  withcolor(0.7,0.7,0.7);

gdraw "T3OptimalV3T5M4.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTSubOptimalV3T5M4.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTOptimalV3T5M4.txt"  withcolor(0.7,0.7,0.7);

glabel.bot(btex $T=5,  M = 4$ etex, 9);

gdraw "T3OptimalV3M8T5.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTSubOptimalV3M8T5.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTOptimalV3M8T5.txt"  withcolor(0.7,0.7,0.7);
glabel.bot(btex $T=5,  M = 8$ etex, 9);

gdraw "T3OptimalV3M4T7.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTSubOptimalV3M4T7.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTOptimalV3M4T7.txt"  withcolor(0.7,0.7,0.7);

gdraw "T3OptimalV3M8T3.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTSubOptimalV3M8T3.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTOptimalV3M8T3.txt"  withcolor(0.7,0.7,0.7);

gdraw "T3OptimalV3T3.txt"  plot diamond;
gdraw "T2LogTSubOptimalV3T3.txt"  plot cross;
gdraw "T2LogTOptimalV3T3.txt"  plot circle;

gdraw "T3OptimalV3T5M4.txt"  plot diamond;
gdraw "T2LogTSubOptimalV3T5M4.txt"  plot cross;
gdraw "T2LogTOptimalV3T5M4.txt"  plot circle;

gdraw "T3OptimalV3M8T5.txt"  plot diamond;
gdraw "T2LogTSubOptimalV3M8T5.txt"  plot cross;
gdraw "T2LogTOptimalV3M8T5.txt"  plot circle;

gdraw "T3OptimalV3M8T3.txt"  plot diamond;
glabel.bot(btex $T=3,  M = 8$ etex, 9);
gdraw "T2LogTSubOptimalV3M8T3.txt"  plot cross;
gdraw "T2LogTOptimalV3M8T3.txt"  plot circle;

gdraw "T3OptimalV3M4T7.txt"  plot diamond;
gdraw "T2LogTSubOptimalV3M4T7.txt"  plot cross;
glabel.bot(btex $T=7,  M = 4$ etex, 9);
gdraw "T2LogTOptimalV3M4T7.txt"  plot circle;



endgraph;

draw legend shifted (6cm,8.4cm);

endfig;


beginfig(2);

draw begingraph(10cm, 10cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex CER etex, OUT) rotated 90;
 
gdraw (20, 0.00047206878662)--(70,0.00047206878662) dashed evenly;


%gdraw "T3OptimalV3M8T5.txt"  withcolor(0.7,0.7,0.7);
gdraw "T2LogTSubOptimalV3M8T5L3.txt" withcolor(0.7,0.7,0.7);
glabel.bot(btex 3 Lines etex, 9);
gdraw "T2LogTSubOptimalV3M8T5L4.txt" withcolor(0.7,0.7,0.7);
glabel.bot(btex 4 Lines etex, 9);
gdraw "T2LogTSubOptimalV3M8T5L5.txt" withcolor(0.7,0.7,0.7);
glabel.bot(btex 5 Lines etex, 9);
gdraw "T2LogTSubOptimalV3M8T5L6.txt" withcolor(0.7,0.7,0.7);
glabel.top(btex 6 Lines etex, 9);
gdraw "T2LogTSubOptimalV3M8T5L7.txt" withcolor(0.7,0.7,0.7);
glabel.bot(btex 7 Lines etex, 9);
%gdraw "T2LogTOptimalV3M8T5.txt"  withcolor(0.7,0.7,0.7);

%gdraw "T3OptimalV3M8T5.txt"  plot diamond;
gdraw "T2LogTSubOptimalV3M8T5L3.txt"  plot cross;
gdraw "T2LogTSubOptimalV3M8T5L4.txt"  plot cross;
gdraw "T2LogTSubOptimalV3M8T5L5.txt"  plot cross;
gdraw "T2LogTSubOptimalV3M8T5L6.txt"  plot cross;
gdraw "T2LogTSubOptimalV3M8T5L7.txt"  plot cross;
%gdraw "T2LogTOptimalV3M8T5.txt"  plot circle;


endgraph;

draw legendtwo shifted (6cm,9.1cm);

endfig;

end;
