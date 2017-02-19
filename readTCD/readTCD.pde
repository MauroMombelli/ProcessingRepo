import processing.serial.*;

int pointNumber = 1024 ;
int rectSize;
int pointPerLine;

int colors[] = new int[pointNumber];


Serial port = new Serial(this, Serial.list()[0], 115200);
void setup() {
  println("Using serial port: "+Serial.list()[0]);
  println(Serial.list());
  size(300, 300);
  pointPerLine = ceil(sqrt(pointNumber)); 
  rectSize = size/pointPerLine;
  port.buffer(pointNumber);
  /*
  for (int i=0; i < pointNumber; i++){
    colors[i] = 90;
  }
  */
}

int count =0;
void serialEvent(Serial port) {
  if (port.available() < pointNumber){
    while (port.available()>0){
      port.read();
    }
    println ("not enought data!");
    return;
  }
  for (int i=0; i < pointNumber; i++){
    colors[i] = port.read();
  }
  
  if (count % 10 == 0){
    for (int i=0; i < pointNumber; i++){
      print (colors[i]+" ");
    }
    println();
    println();
  }
  
  count++;
}

void draw() {
  background(102);
  fill(0);
  int c = 0;
  for (int y=0; y < pointPerLine; y++){
    for (int x=0; x < pointPerLine; x++){
      if (c >= pointNumber){
        fill( color(255, 204, 0) );//unused
      }else{
        fill( colors[c] );
      }
      c++;
      
      rect(rectSize*x, rectSize*y, rectSize*(x+1), rectSize*(y+1));
    }
  }
}
