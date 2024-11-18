sprite_index = sprSpike
angle = 0
planet = noone
found1 = false
found2 = false

//the following stuff is used to determine where the nearest planet is so it can "attach itself"

//first use a circle
for(i=1; i<=50; i+=1) {
    len = i*1
    if collision_circle(x,y,len,par_planet,true,true) {
        found1 = true
        break
    }
}

//then find the angle
if found1 = true {
    for(i=0; i<=360; i+=1) {
        dir = i
        _x = x+lengthdir_x(len,dir)
        _y = y+lengthdir_y(len,dir)
        if collision_point(_x,_y,par_planet,true,true) {
            planet = instance_position(_x,_y,par_planet).id
            found2 = true
            break
        }
    }
}
else {
    show_message("spike can't find planet")
}

//find the surface, set the angle
if found2 = true {
    
    gravDir = point_direction(x,y,_x,_y)
    x = _x
    y = _y

    pointDist = 10
    xDist1 = x+lengthdir_x(pointDist,gravDir-90)
    yDist1 = y+lengthdir_y(pointDist,gravDir-90)
    xDist2 = x+lengthdir_x(pointDist,gravDir+90)
    yDist2 = y+lengthdir_y(pointDist,gravDir+90)
    legLength = 50
    
    for (i[0]=0; i[0]<legLength; i[0]+=1){
        xLength1 = xDist1+lengthdir_x(i[0],gravDir)
        yLength1 = yDist1+lengthdir_y(i[0],gravDir)
        if collision_point(xLength1,yLength1,par_planet,1,1) break;
    }
    
    for(i[1]=0; i[1]<legLength; i[1]+=1){
        xLength2 = xDist2+lengthdir_x(i[1],gravDir)
        yLength2 = yDist2+lengthdir_y(i[1],gravDir)
        if collision_point(xLength2,yLength2,par_planet,1,1) break;
    }
    
    image_angle = point_direction(xLength1,yLength1,xLength2,yLength2)
    
    //straight angle fix
    //only use if you want straight angles (like in TNTBF)
    //image_angle = round(image_angle/90)*90+(360*(image_angle<0))

    xLength0 = (xLength1+xLength2)/2
    yLength0 = (yLength1+yLength2)/2
    x = xLength0+lengthdir_x(0,gravDir-180)
    y = yLength0+lengthdir_y(0,gravDir-180)
}

plen = point_distance(x,y,planet.x,planet.y)
angle = point_direction(x,y,planet.x,planet.y)

