/**
 * GGP Get Global Positions
 * Classe para obter as posições globais no desenho de uma árvore usando algoritmo recursivo
 *
 * No desenho recursivo as posições de cada novo nó da árvore depende do nó anterior e não tem como conhecer a posição global, mas com essa classe você pode conhecer aquelas posições globais de cada nó da árvore. 
 */

class GGP {
  ArrayList <PVector> posiciones;
  ArrayList <Float> angulosIn;  
  ArrayList <PVector> posDinamicaNivel;

  GGP () {
    posiciones = new ArrayList <PVector>();
    angulosIn = new ArrayList <Float>();
    posDinamicaNivel = new ArrayList <PVector>();
  }

  void update() {
    posiciones.clear();
    angulosIn.clear();
    posDinamicaNivel.clear();
  }

  void newPos (float nuevoX, float nuevoY, float ang, int nivelRec) {
    pushStyle();
    fill(0); 
    text ("N: "+nivelRec, 0, 0); 
    noFill();
    float anguloUso=0;

    if (angulosIn.size() == 0) {
      angulosIn.add(nivelRec, ang);
    }  
    else {
      float angP = angulosIn.get(nivelRec-1);
      ang+=angP;
      if (angulosIn.size()>nivelRec)
        angulosIn.remove(nivelRec); 

      angulosIn.add(nivelRec, ang);
      anguloUso=angulosIn.get(nivelRec);
    }

    float angBase = atan2(nuevoY, nuevoX);
    float hipo = sqrt(pow(nuevoX, 2) + pow(nuevoY, 2));
    float nx = hipo*cos(anguloUso+angBase);//angulo+angBase);
    float ny = hipo*sin(anguloUso+angBase);//angulo+angBase);
    PVector nuevo = new PVector (nx, ny, nivelRec); //agrega el nivel recursivo al vector de posicion

    int i = nivelRec-1; 
    if (posDinamicaNivel.size() == nivelRec) {
      posDinamicaNivel.add(nuevo);
      //     println("nive: "+nivelRec+" posDinamicaNivel: "+posDinamicaNivel);
    } 
    else {
      //    println ("i: "+i+" nive: "+nivelRec+" posDinamicaNivel: "+posDinamicaNivel);
      PVector t = posDinamicaNivel.get(i);
      PVector n = new PVector (nuevo.x+t.x, nuevo.y+t.y);
      posDinamicaNivel.remove(i+1);
      posDinamicaNivel.add(i+1, n);
    } 

    if (posiciones.size()==0) {
      posiciones.add(nuevo);
    } 
    else {
      PVector t = posDinamicaNivel.get(i);
      nuevo.add(t);
      nuevo.z=nivelRec;
      posiciones.add(nuevo);      
    }
  popStyle();
  }

  void seePosNivel(float px, float py) {
    pushMatrix();
    translate (px, py);
    int t=0; 
    textAlign(CENTER, CENTER);
    float c = 255/posDinamicaNivel.size(); //divición para cambiar los colores
    for (PVector p : posiciones) { 
      noFill(); 
//      println ("p.z: "+p.z);
      stroke (c*p.z,0,255-c*p.z); 
      ellipse (p.x, p.y, 20, 20);
      if (t == frameCount%posiciones.size() ) { 
        fill (0, 0, 255); 
        text (t, p.x, p.y);
      }
      t++;
    }
    popMatrix();
  }

  void seePos(float px, float py) {
    pushMatrix();
    translate (px, py);
    int t=0; 
    textAlign(CENTER, CENTER);
    for (PVector p : posiciones) { 
      noFill();
      stroke(255, 0, 0);
      ellipse (p.x, p.y, 20, 20);
      if (t == frameCount%posiciones.size() ) { 
        fill (0, 0, 255); 
        text (t, p.x, p.y);
      }
      t++;
    }
    popMatrix();
  }

}

