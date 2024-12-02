//@int(label="channel 1") ch1
//@int(label="channel 2") ch2

setBatchMode(true);
id = getImageID();

selectImage(id);
run("Duplicate...", "duplicate channels="+ch1);
run("32-bit");
run("Subtract...", "value="+getValue("Mean"));
std1 = getValue("StdDev");
id1 = getImageID();

selectImage(id);
run("Duplicate...", "duplicate channels="+ch2);
run("32-bit");
run("Subtract...", "value="+getValue("Mean"));
std2 = getValue("StdDev");
id2 = getImageID();

imageCalculator("Multiply create 32-bit", id1, id2);
pcc = getValue("Mean") / (std1*std2);
print("PCC = " + pcc);
close();
selectImage(id);
setBatchMode(false);