import processing.sound.*;
SoundFile file;
//globale variabler 

//liste over alle punkter vores slange optager
ArrayList<PVector> longSnake;

//bestemmer hvor lang vores slange skal være,
//før vi sletter den ældste del af slangen.
int snakeSize;

//bestemmer hvilken retning slangen bevæger sig
PVector dir;

//slange mad
PVector food;

void setup(){
  size(660, 660);
  
  //Da vores logik er bundet til frameraten, kan vi
  //forøge hastigheden ved at hæve vores framerate.
  //prøv det
  frameRate(8);
  
  snakeSize = 2;
  
  //vi tilføjer den første del af vores slange
  longSnake = new ArrayList<PVector>();
  longSnake.add(new PVector(9*20, 9*20));
  
  //vi finder et tilfældig sted at ligge noget
  //mad til vores slange
  food = new PVector((int)random(0,32)*20, 
    (int)random(0,32)*20);
    
  dir = new PVector(0, 0);
}

void draw(){
  background(0);
  
  //tegner maden
  fill(255,0,0);
  rect(food.x, food.y, 20, 20);
  fill(0,255,0);
  //har tilføjer vi et extra segment af vores slange,
  //i den retning vi bevæger os i
  longSnake.add(new PVector(
    longSnake.get(longSnake.size()-1).x + dir.x*20, 
    longSnake.get(longSnake.size()-1).y + dir.y*20));
  
  //går igennem vært segment af vores slange
  //og tegner den.
  for(int i = longSnake.size()-1; i >= 0; i--){
    rect(longSnake.get(i).x, longSnake.get(i).y,20,20);
    
    //kollision detection for vores slange,
    //her tjekker vi om hovedt at vores slange
    //rammer sig selv
    if (longSnake.get(longSnake.size()-1).x == longSnake.get(i).x &&
          longSnake.get(longSnake.size()-1).y == longSnake.get(i).y &&
          i < longSnake.size()-1){
      
      //vi fjerner alle dele af vores slange,
      //og sætter den tilbage til sin start 
      //position
      longSnake = new ArrayList<PVector>();
      longSnake.add(new PVector(9*20, 9*20));
      snakeSize = 2;
      //break kan vi bruge til at breake ud af
      //vores for-loop, uden at gøre det færdigt
      break;
    
    }
  }
  
  //kollision detection for vores mad.
  //her tjekker vi om slangens hoved er det
  //samme sted som maden
  if (food.x == longSnake.get(longSnake.size()-1).x &&
        food.y == longSnake.get(longSnake.size()-1).y){
    
    //vi flytter vores mad et nyt sted
    food = new PVector((int)random(0,32)*20, 
    (int)random(0,32)*20);
    
    snakeSize++;
    file = new SoundFile(this, "surprise.mp3");
    file.play();
  }
  
  
  //vi fjerner den ældste del
  //af vores slange, så det ser ud som om
  //den bevægersig
  if (longSnake.size() >= snakeSize){
    longSnake.remove(0);
  }
}


//læser keyboarded, og sætter retningen for
//vores slange
void keyPressed(){
  if (key == CODED) {
    //"dir.y != 1" vi forhinder slangen i at
    //gå bæglens
    if (keyCode == UP && dir.y != 1) {
      dir.y = -1;
      dir.x = 0;
    } else if (keyCode == DOWN && dir.y != -1){
      dir.y = 1;
      dir.x = 0;
    } else if (keyCode == LEFT && dir.x != 1){
      dir.x = -1;
      dir.y = 0;
    } else if (keyCode == RIGHT && dir.x != -1){
      dir.x = 1;
      dir.y = 0;
    }
  }
}

//ideer til udfordringer:
//1. hæv hastigheden vær gang slangen finder mad
//2. styr slangen med musen
//3. hvis slangen rammer kanten af vinduet
//    reset spillet  
//4. SVÆR! forhindre maden af spawne et sted hvor slangen
//    allerede er
//5 SVÆR! hvis slangen rammer kanten af vinduet
//    skal den dukke op fra den anden side