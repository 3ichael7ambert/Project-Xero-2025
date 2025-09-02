function _vec3_sub(a,b){ 
	return [a[0]-b[0], a[1]-b[1], a[2]-b[2]]; 
	}
	
function _vec3_cross(a,b){
    return [ a[1]*b[2]-a[2]*b[1],
             a[2]*b[0]-a[0]*b[2],
             a[0]*b[1]-a[1]*b[0] ];
}

function _vec3_norm(v){
    var L = sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
    if (L <= 0.000001) return [0,1,0]; // fallback
    return [v[0]/L, v[1]/L, v[2]/L];
}
