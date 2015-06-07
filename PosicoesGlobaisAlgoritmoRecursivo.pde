/**
 * Posições globais dos nós que compõem a árvore criada recursivamente
 * by Javier Cruz. 
 * 
 * A classe GGP permite conhecer as coordenadas globais x e y, dos pontos que compõem uma árvore feita com algoritmo recursivo
 */

float larguraGalho;
float angulo;
int nivelRecursivo;

GGP GlobalPos;

void setup () {
  size (500,500);
  
  larguraGalho = 100;
  GlobalPos = new GGP();
  frameRate(2);
}

void draw () {
  nivelRecursivo=0;
  background (255);
  noFill();
  pushMatrix();
  stroke(0, 120);
  GlobalPos.update();
  
  translate (width/2, height*.9);
  line (0,0, 0,-larguraGalho);
  rotate(0);
  translate (0,-larguraGalho);
  GlobalPos.newPos (0, -larguraGalho, 0, nivelRecursivo);
  galho(larguraGalho);
  popMatrix();
  
  GlobalPos.seePosNivel(width/2, height*.9);
}

void galho (float lgalho) {
//  fill(0); text ("N: "+nivelRecursivo, 0,0); noFill();
  nivelRecursivo++;
  println ("nivelRecursivo: "+nivelRecursivo);
  if (nivelRecursivo < 4) {
  lgalho = lgalho * .66;
  pushMatrix();
  float aa=PI*.25;//random(-PI*.25,PI*.25);
  rotate (aa);
  line (0,0, 0, -lgalho);
  translate (0, -lgalho);
  GlobalPos.newPos (0, -lgalho, aa, nivelRecursivo);
  ellipse (0,0, 30,30);
  galho (lgalho);
  popMatrix();
  
  pushMatrix();
  rotate (-aa);
  line (0,0, 0, -lgalho);
  translate (0, -lgalho);
  GlobalPos.newPos (0, -lgalho, -aa, nivelRecursivo);
  ellipse (0,0, 30,30);
  galho (lgalho);
  popMatrix();
  }
  nivelRecursivo--;
}
