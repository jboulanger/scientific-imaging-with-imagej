//@int(label="channel 1") ch1
//@int(label="channel 2") ch2

setBatchMode(true);
id = getImageID();
selectImage(id);
run("Select None");
run("Duplicate...", "duplicate channels="+ch1);
run("32-bit");
//setAutoThreshold("Default dark");
//run("Create Selection");
run("Subtract...", "value="+getValue("Mean"));
std1 = getValue("StdDev");
id1 = getImageID();

selectImage(id);
run("Select None");
run("Duplicate...", "duplicate channels="+ch2);
run("32-bit");
//run("Restore Selection");
run("Subtract...", "value="+getValue("Mean"));
std2 = getValue("StdDev");
id2 = getImageID();

imageCalculator("Multiply create 32-bit", id1, id2);
//run("Restore Selection");
pcc = getValue("Mean") / (std1*std2);
print("PCC = " + pcc);
close();
selectImage(id);
setBatchMode(false);
run("Restore Selection");