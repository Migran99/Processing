//Recta color mouse

int grosor = 5;
void setup() {
  size(500, 500);
  background(50, 50, 50);
}



void draw() {
  background(50, 50, 50);
  strokeWeight(grosor);
  stroke(mouseX/2, mouseY/2, ((mouseX+mouseY)/2)/2);
  line(0, 0, mouseX, mouseY);
}

void keyPressed() {
  if (key == 'a' && grosor<=100) {
	grosor+=1;
  }
  if (key == 'd'&& grosor>=1) {
	grosor-=1;
  }
  if (key == 'w') {
	background(50, 50, 50);
  }
}
