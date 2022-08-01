/*
 * Create a flower and apply a serie of command
 */
run("Close All");
cmd = newArray("Erode","Dilate","Open","Close-","Skeletonize","Fill Holes","Watershed");
w = 50;
h = 50;
newImage("flower", "8-bit black", w, h, 1);
n = 6;
d = 15;
r = d-2
setColor(255);
for (i=0;i<n;i++) {
	makeOval(w/2+r*cos(2*PI*i/n)-d/2, h/2+r*sin(2*PI*i/n)-d/2, d, d);
	fill();
}
run("Select None");

run("Size...", "width="+w+" height="+h+" depth="+cmd.length+1+" constrain average interpolation=Bilinear");
setThreshold(128, 255);

run("Convert to Mask","stack");


for (i=0;i<cmd.length;i++) {
	setSlice(i+2); run(cmd[i], "slice");
}
run("Size...", "width="+4*w+" height="+4/h+" depth="+cmd.length+1+" constrain average interpolation=None");
run("Make Montage...", "columns="+cmd.length+1+" rows=1 scale=1");
setColor("black");
for (i=0;i<cmd.length;i++) {	
	Overlay.drawString(cmd[i],4*w*(i+1)+4*w/2-20,10);
	Overlay.add();
	Overlay.show();
}
Overlay.drawString("Original",0*w*(i+1)+4*w/2-20,10);
Overlay.add();
Overlay.show();

