import processing.net.*;

Server serv;
final int port = 8080;


final int w = 96;
final int h = 64;
final int dot_size = 10;
final int part_dist = 3;
final float offset = dot_size / 2;

final int wind_W = w * dot_size + (w-1) * dot_size/part_dist;
final int wind_H = h * dot_size + (h-1) * dot_size/part_dist;

int filling[][] = new int[w][h];

void setup() {
  surface.setSize(wind_W, wind_H);
  surface.setLocation(displayWidth-wind_W-10, 0);
  noStroke();
  /****************************************/
  serv = new Server(this, port);
  println(wind_W, wind_H);
  println(displayWidth, displayHeight);
}

void draw() {
  background(200);
  for (int j = 0; j < h; j++)
    for (int i = 0; i < w; i++) {
      servUpdate();
      fill(filling[i][j]);
      circle(i*dot_size*(1 + 1f / part_dist)+offset, j*dot_size*(1 + 1f / part_dist)+offset, dot_size);
    }
}


void servUpdate() {
  Client cl = serv.available();
  if (cl != null && cl.available() > 0) {
    String resp = cl.readStringUntil('\n');
    if (resp != null) {
      String[] splstr = split(resp.trim(), ' ');
      printArray(splstr);
      int x, y, fl;
      try{
        x = int(splstr[0]);
        y = int(splstr[1]);
        fl = int(splstr[2]);
      }
      catch(Exception ex){
        println("Exception: ", ex.getMessage());
        return;
      }
      if (x > w-1 || x < 0 || y > h-1 || y < 0)
        return;
      filling[x][y] = fl;
    }
  }
}
