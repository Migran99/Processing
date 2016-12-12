//Rana

int grosor = 500;
int altura = 300;

void setup() {
  size(800, 800);
  strokeWeight(grosor/altura);


  //Cara
  fill(100, 255, 100);
  ellipse(width/2, height/2, grosor, altura);


  //Nariz
  fill(0);
  ellipse((width/2)-grosor/10, (height/2)+altura/8, altura/10, altura/10);
  ellipse((width/2)+grosor/10, (height/2)+altura/8, altura/10, altura/10);


  //Boca
  fill(255, 100, 100);
  ellipse((width/2), (height/2)+altura/3, grosor-(grosor/3), 20);
}


void draw() {
  //Ojos
  fill(255);
  ellipse((width/2)-grosor/4, (height/2)-altura/4, altura/2, altura/2);
  ellipse((width/2)+grosor/4, (height/2)-altura/4, altura/2, altura/2);
  fill(0);
  ellipse(((width/2)-grosor/4)- (((width/2)-grosor/4)-mouseX)/40, ((height/2)-altura/4)- (((height/2)-altura/4)-mouseY)/40, altura/4, altura/4);
  ellipse(((width/2)+grosor/4)- (((width/2)+grosor/4)-mouseX)/40, ((height/2)-altura/4)- (((height/2)-altura/4)-mouseY)/40, altura/4, altura/4);
}

