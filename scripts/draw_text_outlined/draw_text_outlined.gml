//draw_text_outlined(x, y, outline color, string color, string)  
function draw_text_outlined(_xx,_yy,_words,_colored)
{
var xx,yy,outline,words, colored;  
xx = _xx;  
yy = _yy;  
outline=argument[4];
words=_words;
colored=_colored;
  
//Outline  
draw_set_color(c_black);  
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