prologues := 2;
filenametemplate "%j-%c.mps";
input TEX; 
TEXPRE("%&latex" & char(10) & 
"\documentclass{minimal}\begin{document}"); 
TEXPOST("\end{document}"); 

T = 3;
M = 4;

numeric yt[];
numeric yb[];
yt0 = -0.1076; yt1 = -0.4728; yt2 = -0.7002; 
yt3 = -0.0968; yt4 = -1.1228; yt5 = 0.4955; 
yb0 = 0.4728; yb1 = -0.1076; yb2 = 0.0968; 
yb3 = -0.7002; yb4 = -0.4955; yb5 = -1.1228; 

a = 6;

beginfig(1);

for t=0 upto 2*T-1:
  for k=-M+2 step 2 until M-2: 
    draw ((-a, (k + a*yt[t])/yb[t])--(a, (k - a*yt[t])/yb[t])) scaled 1cm; 
  endfor
endfor

%k = 3;
%t = 3;
%label.top(btex $L(3,3)$ etex, 1/4[(-a , (k + a*yt[t])/yb[t]), (a, (k - a*yt[t])/yb[t])] scaled 1cm);

%label.bot(btex $G(-s(\underline{x}))$ etex, (-3.8cm, 2cm));
%label.top(btex $G(s(\underline{x}))$ etex, (3.8cm, -2cm));
label.top(btex $G(\underline{x})$ etex, (2cm,3.8cm));
%label.bot(btex $G(-\underline{x})$ etex, (-2cm,-3.8cm));

label.top(btex $L(k,t)$ etex, (2.4cm,4.2cm)) rotated 10;
%label.top(btex $L(k,t+1)$ etex, (2.4cm,4.2cm)) rotated 10 rotated -90;
%label.top(btex $L(-k,t+1)$ etex, (2.5cm,4.3cm)) rotated 10 rotated 90;
%label.bot(btex $L(-k,t)$ etex, (-2.4cm,-4.2cm)) rotated 10;

w =8cm;
h= 6cm;

clip currentpicture to (-w,-h)--(-w,h)--(w,h)--(w,-h)--cycle;

endfig;

end;