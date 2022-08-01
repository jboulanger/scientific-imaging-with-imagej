//@Integer(label="Image width",value=500) width
//@Integer(label="Image height",value=500) height
//@Integer(label="Number of frames",value=500) nframes
//@Integer(label="Number of objects",value=10) nobj
//@Integer(label="Smoothing",value=10) nsmooth
//@Integer(label="Object size",value=10) dobj
//@Float(label="Object speed",value=5) vobj
//@Float(label="Object speed std",value=5) sobj
//@Float(label="Object directionality",value=0.1) objdir
//@Float(label="Proba change direction",value=0) probachg

setBatchMode(true);
newImage("test", "8-bit black",width,height,nframes);
id0 = getImageID();
newImage("test", "32-bit",nframes,2,nobj);
id1 = getImageID();
run("Add Noise", "stack");
for (iter = 0; iter < nsmooth; iter++) {
	run("Convolve...", "text1=[1 1 1\n] normalize stack");
}
setColor(255);

for (iobj = 0; iobj < nobj; iobj++) {
	selectImage(id1);	
	setSlice(iobj+1);
	delta = newArray(2*nframes);	
	for (d = 0; d < 2; d++) {
		for (t = 0; t < nframes; t++) {
			val = getPixel(t,d);
			delta[t+nframes*d] = val;			
		}
	}
	selectImage(id0);
	//drift
	vx0 = random-0.5;
	vy0 = random-0.5;
	vx0 /= sqrt(vx0*vx0+vy0*vy0);
	vy0 /= sqrt(vx0*vx0+vy0*vy0);
	// start point
	X = width*(0.25+0.5*random);
	Y = height*(0.25+0.5*random);
	for (t = 0; t < nframes; t++) {
		if (random() < probachg/100) {
			vx0 = random-0.5;
			vy0 = random-0.5;
			vx0 /= sqrt(vx0*vx0+vy0*vy0);
			vy0 /= sqrt(vx0*vx0+vy0*vy0);
		}
		dx = 1/objdir * delta[t] + vx0;
		dy = 1/objdir * delta[t+nframes] + vy0;
		v = sqrt(dx*dx+dy*dy);		
		X = X + (vobj + sobj * random("gaussian")) * dx / v;
		Y = Y + (vobj + sobj * random("gaussian")) * dy / v;
		if (X < 0) {X=-X; vx0=-vx0;}
		if (X > width) {X=2*width-X; vx0=-vx0;}
		if (Y < 0) {Y=-Y; vy0 = -vy0;}
		if (Y > height) {Y=2*height-Y;vy0 = -vy0;}
		setSlice(t+1);
		makeOval(X-dobj/2, Y-dobj/2, dobj, dobj);
		fill();		
	}
	run("Select None");
}
selectImage(id0);
setBatchMode(false);
