run("Close All");
run("HeLa Cells (48-bit RGB)");
run("Duplicate...", "title=dapi duplicate channels=3");
setAutoThreshold("MaxEntropy dark");
run("Convert to Mask");
run("Connected Components Labeling", "connectivity=4 type=[16 bits]")
run("Label Size Filtering", "operation=Greater_Than size=500");
rename("marker");

run("Duplicate...", "title=distance ");
setThreshold(0, 1);
run("Convert to Mask");
run("Distance Map");
run("Marker-controlled Watershed", "input=distance marker=marker mask=None compactness=0 calculate");
run("Label Map to ROIs", "connectivity=C4 vertex_location=Corners name_pattern=r%03d");

for (i = 0; i < roiManager("count"); i++){
	roiManager("select", i);
	run("Interpolate", "interval=5 smooth");
	roiManager("update");
}

selectImage("hela-cells.tif");
roiManager("Show All");


/// Second example
run("Close All");
run("Blobs (25K)");
id=getImageID();
run("Duplicate...", "title=marker");
setThreshold(128, 255);
run("Convert to Mask");
run("Watershed");
run("Erode");
run("Duplicate...", "title=input");
run("Invert");
run("Distance Map");

run("Marker-controlled Watershed", "input=input marker=marker mask=None compactness=0 binary calculate");

run("Label Map to ROIs", "connectivity=C4 vertex_location=Corners name_pattern=r%03d");
for (i = 0; i < roiManager("count"); i++){
	roiManager("select", i);
	run("Interpolate", "interval=5 smooth");
	roiManager("update");
}
selectImage(id);
roiManager("Show All");