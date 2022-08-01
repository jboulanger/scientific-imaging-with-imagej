/*
 * Open the Blob image and generate random translation
 */
run("Blobs (25K)");
run("Size...", "width=128 height=127 depth=10 constrain average interpolation=Bilinear");

for (t=1;t<=10;t++) {
	setSlice(t);
	run("Translate...", "x="+5*random()+" y="+5*random()+" interpolation=Bilinear slice");
}