param nSCEN;
set SCEN;
param w;

param nCut >= 0 integer;
param nFeas >= 0 integer;
param scenIx integer;

var x1 >= 0, <= 10 := 1;
var x2 >= 0, <= 10 := 5;
var theta >= 0;  #(Since q >=0, y >= 0)

var y1{SCEN} >= 0, <= 15;
var y2{SCEN} >= 0, <= 2;

var y1_aux{SCEN} >= 0, <= 15;
var y2_aux{SCEN} >= 0, <= 2;

var v1{SCEN} >= 0;
var v1_minus{SCEN} >= 0;
var v2{SCEN} >= 0;
var v2_minus{SCEN} >= 0;

param q1{SCEN};
param q2{SCEN};
param p{SCEN} default 1/card(SCEN);
param d1{SCEN};
param d2{SCEN};

param tcoef0{SCEN} default 0;
param tcoef1{SCEN} default 0;
param tcoef2{SCEN} default 0;

param coef0{1..nCut} default 0;
param coef1{1..nCut} default 0;
param coef2{1..nCut} default 0;

param aux_coef1{1..nFeas} default 0;
param aux_coef2{1..nFeas} default 0;
param aux_coef0{1..nFeas} default 0;


minimize SubObj{s in SCEN}:
         q1[s] * y1[s] + q2[s] * y2[s];

subject to c1{s in SCEN}:
		y1[s] + 2 * y2[s] + x1 >= d1[s];
	
subject to c2{s in SCEN}:
		y1[s] + x2 >= d2[s];
		
minimize AuxObj{s in SCEN}:
		v1[s] + v1_minus[s] + v2[s] + v2_minus[s];
		
subject to aux1{s in SCEN}:
	   y1_aux[s] + 2 * y2_aux[s] + v1[s] - v1_minus[s] >= d1[s] - x1;
	   
subject to aux2{s in SCEN}:
		y1_aux[s] + v2[s] - v2_minus[s] >= d2[s] - x2;

minimize MasterObj:
	 7 * x1 + 11 * x2 + theta;

subject to Cuts {k in 1..nCut}:
	theta >= coef0[k] - coef1[k] * x1 - coef2[k] * x2;

subject to Auxs {k in 1..nFeas}:
	aux_coef1[k] * x1 + aux_coef2[k] * x2 >= aux_coef0[k];


		
	
