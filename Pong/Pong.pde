///Pong
///
/// Creado por Miguel Granero.
///  2ºBachillerato IES Vicente Aleixandre.
///

//Variables Paddle
int pad_posx = 0;
int pad_posy =0;
int grosor = 100;
int altura = 20;

//Variables Bola
int bola_posx = 0;
int bola_velx = 0;
int bola_vely = 0;
int bola_posy =0;
int radio = 15;
int vel0 = 10;

//Variables HUD
int pantalla = 0;
PFont font1;

void setup() {
  size(500, 500);  //Tamaño de la pantalla
  frameRate(50);  //Framerate de la pantalla para evitar el tearing
  colorMode(HSB, 500);//Cambiamos el modo de color a HSB para poder cambiar los colores mas facilmente
  strokeWeight(5);  //Grosor del borde de los objetos
  iniciar_variables(); //Iniciamos todas la variables necesarias
}


void draw() {
  background(200, 0, 50); //Limpiamos la pantalla
  switch (pantalla) { //Dibujamos una cosa u otra dependiendo del estado del juego
  case 0: 
    menu();
    break;

  case 1: 
    juego();
    break;

  case 2: 
    perder();
    break;

  case 3:
    pausa();
    break;
  }
}

void iniciar_variables() {
  //Iniciamos todas la variables necesarias
  pad_posy = height-height/5;
  pad_posx = mouseX-(grosor/2);
  bola_posx = width/2;
  bola_posy = height/4;
  bola_vely=round(random(1, vel0-(vel0/8)));
  bola_velx = (vel0 - bola_vely);
  font1 = createFont("Arial", 16, true);
}

void dibujar_paddle() { //Dibujamos el Paddle
  fill(pad_posx, pad_posy, pad_posx);
  stroke(pad_posx+10, pad_posy-10, 300);
  rect(pad_posx, pad_posy, grosor, altura);
}

void dibujar_bola() {//Dibujamos la bola
  fill(bola_posx, bola_posy, bola_posx);
  stroke(bola_posx+20, bola_posy-20, 300);
  ellipse(bola_posx, bola_posy, radio*2, radio*2);
}

void mover_bola() { //Movemos la bola
  bola_posx+= bola_velx;
  bola_posy+= bola_vely;
}

void mover_paddle() {   //Cambiamos la posicion del paddle
  pad_posx = mouseX-(grosor/2);
}

void limites() { //Detectamos los limites
  //Rebote bordes
  if (bola_posy-radio<= 0) {
    bola_vely = bola_vely*-1;
  }
  if (bola_posx+radio >= width || bola_posx-radio<= 0 ) {
    bola_velx = bola_velx*-1;
  }

  //Rebote con el paddle
  if (bola_posx >= pad_posx && bola_posx <= pad_posx+grosor) {
    if (bola_posy+radio >= pad_posy && bola_posy <= pad_posy) {
      bola_vely = (bola_vely * -1) - 1;
    }
  }

  //Fin del juego
  if (bola_posy+radio >= height) {
    pantalla = 2;
  }
}

void menu() { //En este bloque dibujamos el HUD del menu principal
  textFont(font1, height/4);  //Seleccionamos la fuente del texto            
  fill(mouseX, mouseY, (mouseX+mouseY)/2);
  textAlign(CENTER); //La alineacion del texto con la posicion que demos
  text("PONG", width/2, height/4); //Dibujamos el string que queramos (PONG en este caso)
  fill(mouseY, (mouseX+mouseY)/2, mouseX );
  rect(0, height/2, width, height/6);
  textFont(font1, height/6); 
  fill(mouseX, mouseY, (mouseX+mouseY)/2);
  text("PLAY", width/2, height/2 + height/6 - height/50);
  textFont(font1, 16); 
  fill(500);
  textAlign(LEFT);
  text("Miguel Granero", width-textWidth("Miguel Granero"), height-16);
}

void juego() { //Dibujamos el HUD del juego
  dibujar_paddle();
  dibujar_bola();
  mover_bola();
  mover_paddle();
  limites();
}

void perder() {
  textFont(font1, height/6);         
  fill(mouseX, mouseY, (mouseX+mouseY)/2);
  textAlign(CENTER);
  text("PIERDES", width/2, height/4);   
  textFont(font1, height/9); 
  text("Pulsa 'r' para repetir ", width/2, height/2);   
  text("o 'c' para salir ", width/2, height/2 + height/6);
}

void pausa() {
  dibujar_paddle();
  dibujar_bola();
}

void keyPressed() {
  switch (key) {
  case 'r': 
    if (pantalla == 1 || pantalla == 2) iniciar_variables(); 
    pantalla = 1; //Para reiniciar la partida en el juego o una vez hayamos perdido
    break;
  case 'c':
    exit();
    break;

  case 'p': 
    if (pantalla == 1) pantalla = 3;
    else if (pantalla  == 3) pantalla = 1;
  }
}

void mouseClicked() {
  if (mouseY < height/2 + height/6 && mouseY > height/2 && pantalla == 0) {
    pantalla=1; //Si pulsamos el boton del menu entramos al juego
  }
}
