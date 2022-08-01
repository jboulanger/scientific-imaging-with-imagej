/*
 * Compute the Velocity from a kymograph
 * 
 */

run("Interpolate", "interval=1");
Roi.getCoordinates(S, T);

t0 = T[0];
t1 = T[T.length-1];
n = t1-t0;
Sq = newArray(n);
Tq = newArray(n);

for (i = 0; i < n; i++) {
	tq = t0 + i;
	Sq[i] = interpolatePosition(T,S,tq);
	Tq[i] = i;
}

Speed = diff1d(Sq);
Position = Sq;
Time = Tq;
Array.show(Time, Position, Speed);


function interpolatePosition(X,Y,xq) {
	k0 = 0;
	for (k = 0; k < X.length-1; k++) {
		if (X[k] < xq && X[k+1] >= xq) {
			k0 = k;	
			break;
		}
	}	
	y1 = Y[k0];
	y2 = Y[k0+1];
	x1= X[k0];
	x2 = X[k0+1];
	print(xq +"" +k0);
	return y1 + (y2-y1)/(x2-x1) * (xq-x1);
}

function diff1d(X) {
	delta = newArray(X.length);
	for (i = 0; i < X.length-1; i++) {
		delta[i] = X[i+1] - X[i];
	}
	delta[X.length-1] = delta[X.length-2];
	return delta;
}