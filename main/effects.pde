
class Effect extends World_object {
  
  public Effect (float px, float py) {
    
    super(px,py,0);
    
  
    
  }

}
  
  
class Explosion extends Effect {
  
  float sizelimit; 
  float current_size;
  float fade;
  
  
  public Explosion (float px, float py) {
    super(px, py);
//    println("px : " + px);  
    
    this.sizelimit = 15;
    this.current_size = 0;
    this.fade = 255;
    
  }

  void update (PApplet p) {
  
   if (game1.paused == false)
   {
    
        if (this.current_size < this.sizelimit)
          this.current_size = this.current_size + 1.2;
        else{
          this.visible = false;
          this.dispose();  
        }  
          
    
        this.fade = this.fade - 35;
   } 

    
  }
  
  void draw (PApplet p) {
  
    p.fill(240,240,134,this.fade);
    p.ellipse(0,0, this.current_size, this.current_size);
    
 //   println("draw this.x : " + this.x);  
  
//    p.fill(255,255,255,255);
//    p.ellipse(0,0,50,50);
    
  
   
  }


}
  
class Turret_flash extends Explosion  {
 
  public Turret_flash(float px, float py, float pcurrent_shotpower){
    
    super(px,py);
    this.sizelimit = 2.0+pcurrent_shotpower*5;
    print ("current_shotpower = " + pcurrent_shotpower);
  }  
  
  void update (PApplet p) {
  
   if (game1.paused == false)
   {
    
        if (this.current_size < this.sizelimit)
          this.current_size = this.current_size + 1.9;
        else{
          this.visible = false;
          this.dispose();  
        }  
          
    
        this.fade = this.fade - 25;
   } 

    
  }
   
  void draw (PApplet p) {
  
    p.fill(240,240,34,this.fade);
    p.ellipse(0,0, this.current_size, this.current_size);
  
   
  }
}
  
class astroid_explosion extends Effect  {
  
  float sizelimit; 
  float current_size;
  float fade;
  PShape s;
  
  
  public astroid_explosion (float px, float py) {
    super(px, py);
//    println("px : " + px);  
    
    this.sizelimit = 35;
    this.current_size = 5;
    this.fade = 200;

    this.s = astretoid_explotion_svg;
    this.s.disableStyle();
  }

  void update (PApplet p) {
   
    if (game1.paused == false)
    {
        if (this.current_size < this.sizelimit)
          this.current_size = this.current_size + 0.8;
        else{
          this.visible = false;
          this.dispose();  
       
        }  
          
        
        this.fade = this.fade - 6.5;
    }    

    
  }
  
  void draw (PApplet p) {
  
  
    p.fill(240,240,134,this.fade); 
//    p.ellipse(0,0, this.current_size, this.current_size);
    p.shape(this.s,0,0, this.current_size, this.current_size);
 //   println("draw this.x : " + this.x);  
  
//    p.fill(255,255,255,255);
//    p.ellipse(0,0,50,50);
    
  
   
  }


}
  
  


class Cos_Light extends Effect {
  
  float pause_time = 0;
  int dimmer;
  int light_red,light_green,light_blue;
  float flikker_speed;
  
  public Cos_Light (float px, float py, int pr, int pg, int pb, float psize, float pspeed) {
    super(px, py);
    sizeXY = psize;
    light_red = pr;
    light_green = pg;
    light_blue = pb;
    flikker_speed = pspeed;
  }
  
 
  void update (PApplet p) {
    if (game1.paused == false)
    {
      pause_time = pause_time + flikker_speed;
      dimmer = int(abs(255*cos(pause_time)));
    }
  }
  
  void draw (PApplet p) {
  
    p.fill(0,0,0,255);
    p.ellipse(0, 0, sizeXY, sizeXY);
    
  
    p.fill(light_red,light_green,light_blue,dimmer);
    p.ellipse(0, 0, sizeXY, sizeXY);
  
   
   
  }


}

