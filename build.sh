cd code/data 
mpost -interaction=nonstopmode drawlines.mp 
mpost -interaction=nonstopmode plot.mp  
cd ../..

pdflatex qamreceiver.tex 
bibtex qamreceiver 
pdflatex qamreceiver.tex 
pdflatex qamreceiver.tex 
