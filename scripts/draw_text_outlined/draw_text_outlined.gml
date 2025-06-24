//draw_text_outlined(x, y, outline color, string color, string)  
function draw_text_outlined(_xx,_yy,_words,_colored,_colline)
{
var xx,yy,outline,words, colored;  
xx = _xx;  
yy = _yy;  
outline=argument[4];
words=_words;
colored=_colored;
  
//Outline  
draw_set_color(_colline);  
draw_text(xx+1, yy+1, _words);  
draw_text(xx-1, yy-1, _words);  
draw_text(xx,   yy+1, _words);  
draw_text(xx+1,   yy, _words);  
draw_text(xx,   yy-1, _words);  
draw_text(xx-1,   yy, _words);  
draw_text(xx-1, yy+1, _words);  
draw_text(xx+1, yy-1, _words);  
  
//Text  
draw_set_color(_colored);  
draw_text(xx, yy, _words); 

}

function draw_text_transformed_outlined(_xx,_yy,_words,_colored=c_white,_colline=c_black,_xscale,_yscale,_angle)
{
var xx,yy,outline,words, colored;  
xx = _xx;  
yy = _yy;  
outline=argument[4];
words=_words;
colored=_colored;
  
//Outline  
draw_set_color(_colline);  
draw_text_transformed(xx+1, yy+1,_words,_xscale,_yscale,_angle); 
draw_text_transformed(xx-1, yy-1,_words,_xscale,_yscale,_angle); 
draw_text_transformed(xx,   yy+1,_words,_xscale,_yscale,_angle); 
draw_text_transformed(xx+1,   yy,_words,_xscale,_yscale,_angle); 
draw_text_transformed(xx,   yy-1,_words,_xscale,_yscale,_angle);  
draw_text_transformed(xx-1,   yy,_words,_xscale,_yscale,_angle); 
draw_text_transformed(xx-1, yy+1,_words,_xscale,_yscale,_angle); 
draw_text_transformed(xx+1, yy-1,_words,_xscale,_yscale,_angle); 

  
//Text  
draw_set_color(_colored);  
draw_text_transformed(xx, yy, _words,_xscale,_yscale,_angle); 

}