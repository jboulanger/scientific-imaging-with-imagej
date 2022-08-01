//@Float(value=1.0,) gamma


getLut(reds, greens, blues);
Array.print(reds);
n = reds.length
for (i = 0 ; i < n; i++) {
	val = n*pow(i/n,gamma);
	k = 0;
	for (j = 0; j < n; j++) {
		if (j<val && j+1>val) {
			k = j;
		}
	}
	reds[i] = reds[k];
	greens[i] = greens[k];
	blues[i] = blues[k];
}
setLut(reds, greens, blues);
