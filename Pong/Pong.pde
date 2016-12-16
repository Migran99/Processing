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
float angulov0 = 0;

//Variables HUD
int pantalla = 0;
PFont font1;

//Variables generales
int puntos = 0;
int vidas = 0;

void setup() {
  size(500, 500);  //Tamaño de la pantalla
  frameRate(50);  //Framerate de la pantalla para evitar el tearing
  colorMode(HSB, 500);//Cambiamos el modo de color a HSB para poder cambiar los colores mas facilmente
  strokeWeight(5);  //Grosor del borde de los objetos
  font1 = createFont("Arial", 16, true); //Creamos una fuente para las letras
  vidas = 3; //Iniciamos las vidas y los puntos
  puntos = 0;
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
  //Iniciamos todas la variables necesarias salvo vida y puntos ya que estas se manejaran externamente para mayor comodidad
  pad_posy = height-height/5;
  pad_posx = mouseX-(grosor/2);
  bola_posx = width/2;
  bola_posy = height/4;
  angulov0 = random(-0.6, 0.6); //Variamos la velocidad inicial en funcion de una direccion aletoria (angulo en radianes)
  bola_vely=round(vel0*cos(angulov0));
  bola_velx = round(vel0*sin(angulov0));
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
      bola_vely = bola_vely*-1;
      puntos+=1;
    }
  }

  //Fin del juego
  if (bola_posy+radio >= height) {
    vidas -=1;
    iniciar_variables();
    if (vidas == 0) pantalla = 2;
  }
}

void dibujar_hud() { //Dibujamos el HUD en el juego. Los puntos y las vidas
  textFont(font1, height/9);  //Seleccionamos la fuente del texto            
  fill(mouseX, mouseY, (mouseX+mouseY)/2);
  textAlign(LEFT); //La alineacion del texto con la posicion que demos
  text("Puntos: " + puntos, width/2 - textWidth("Puntos:  " + puntos), height/9);
  fill(mouseY, mouseX, (mouseX+mouseY)/2);
  textAlign(RIGHT);
  text("Vidas: " + vidas, width/2 + textWidth("Vidas:  " + vidas), height/9);
  textFont(font1, 16); 
  fill(500);
  textAlign(LEFT);
  text("Pulsa P para pausar", width-textWidth("Pulsa P para pausar:"), height-16);
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
  text("Miguel Granero", width-textWidth("Miguel Granero:"), height-16);
}

void juego() { //Dibujamos el HUD del juego
  dibujar_paddle();
  dibujar_bola();
  mover_bola();
  mover_paddle();
  limites();
  dibujar_hud();
}

void perder() { //Al perder
  textFont(font1, height/6);         
  fill(mouseX, mouseY, (mouseX+mouseY)/2);
  textAlign(CENTER);
  text("PIERDES", width/2, height/4);   
  textFont(font1, height/9); 
  text("Pulsa 'r' para repetir ", width/2, height/2);   
  text("o 'c' para salir ", width/2, height/2 + height/6); 
  fill(mouseY, mouseX, (mouseX+mouseY)/2);
  text("Puntos: " + puntos, width/2, height - height/8);
}

void pausa() { //Al pausar el juego
  dibujar_paddle();
  dibujar_bola();
  dibujar_hud();
  textFont(font1, height/4);         
  fill(mouseX, mouseY, (mouseX+mouseY)/2);
  textAlign(CENTER);
  text("PAUSA", width/2, height/2);
}

void keyPressed() { //CUando pulsamos una tecla
  switch (key) {
  case 'r': 
    if (pantalla == 1 || pantalla == 2) iniciar_variables(); //Para reiniciar la partida en el juego o una vez hayamos perdido
    puntos = 0;
    vidas = 3;
    pantalla = 1; 
    break;
  case 'c':
    exit(); //Para salir del juego
    break;

  case 'p': 
    if (pantalla == 1) pantalla = 3; //Para pausar el juego
    else if (pantalla  == 3) pantalla = 1;
  }
}

void mouseClicked() { //Al pulsar el raton
  if (mouseY < height/2 + height/6 && mouseY > height/2 && pantalla == 0) {
    pantalla=1; //Si pulsamos el boton del menu entramos al juego
  }
}
