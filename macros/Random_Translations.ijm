/*
 * Open the Blob image and generate random translation
 */

run("Blobs (25K)");

// rescale the image to create a time lapse
run("Size...", "width=128 height=127 depth=10 constrain average interpolation=Bilinear");

x = 0;
y = 0;
for (t = 1; t <= 10; t++) {
	setSlice(t);
	x = x + 5 * (random()-0.5);
	y = y + 5 * (random()-0.5);
	run("Translate...", "x="+x+" y="+y+" interpolation=Bilinear slice");
}