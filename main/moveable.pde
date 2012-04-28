


// RectSprite subclasses NestSprite,
// and specifies how it is transformed every frame
// and how it is drawn to the screen.
// update() and then draw() will be
// called every frame by NestSpriteContainer.update().




import java.awt.geom.Point2D;
import java.awt.geom.Rectangle2D;

class World_object extends NestSprite {
  
  float velx, vely;
  float accx, accy;
  float forcex, forcey;
  float sizeXY;
  String name;
  String type_of;
  int age;
  boolean is_stil_alive;
  float mass = 1;
  float health;
  
  public World_object (float px, float py, float psizeXY) {
  



    super((-psizeXY*0.5)/*+px*/,(-psizeXY*0.5)/*+py*/,psizeXY,psizeXY);
  
  
    //this.setBounds((-this.sizeXY*0.5),(-this.sizeXY*0.5),this.sizeXY,this.sizeXY);
    
    this.x = px;
    this.y = py;
   
    this.sizeXY = psizeXY;
    this.is_stil_alive = true;
    this.name = "new_object";
    this.type_of = "world_object";
    
    
    
  } 
  
  public World_object (float px, float py, float pvelx, float pvely, float psizeXY) {
    
    this(px,py,psizeXY);

    this.velx = pvelx;
    this.vely = pvely;

  }
  
 
  void move_update() {
    
    if (game1.paused == false) {
    
        this.accx = this.forcex/this.mass; //EERSTE DIVIDE IN DIE MAIN LOOP WAT EK VAN WEEEET!!!!
        this.accy = this.forcey/this.mass;
        
        
        this.velx =   this.velx + this.accx;
        this.vely =   this.vely + this.accy;
        
        
        this.x =   this.x + this.velx;
        this.y =   this.y + this.vely;    
    
    }
   
  } 
   
   void draw_bound_box(PApplet p){
    
      println("DRAW");
       p.fill(255,255,255,55);
       p.rect((-this.sizeXY*0.5),(-this.sizeXY*0.5),this.sizeXY,this.sizeXY);
     
   }  
   
   void inc_age() {
   
    
     this.age = this.age + 1;     
    
     
   }  
 
   Point2D.Float global_coords_Point2D(){
   
     
     return this.localToGlobal(new Point2D.Float(0,0));
  
   
   }  

   float dist_to_center_in_local_squared (Point2D die_point){
   
    
       
  
       return  sq((float)die_point.getX())  +  sq((float)die_point.getY());
     
   }


}


class Bullet extends World_object {
  
 

  float rotation_speed;
  
  public Bullet (float px, float py, float pvelx,float pvely) {
    super(px,py,pvelx,pvely, 2.2);  
    
    
    this.type_of = "bullet";
    this.mass  =  this.sizeXY * 10; 
    this.rotation_speed = random(0.5);

  }
  
  
  Effect explode(){
  
  //  println("(bullet) this.x" + this.x);
    return (new Explosion(this.x,this.y));
    
  }
 
  void update(PApplet p) {
  
  if (game1.paused == false)
    {
       this.inc_age();
       this.move_update();
       this.rotationZ += this.rotation_speed;
    }  
      
  } 

  
  void draw (PApplet p) {

    p.fill(230,10,14,255); 
    p.ellipse(0,sizeXY*0.3,sizeXY*0.6,sizeXY*0.8); // bullet effect

    p.fill(110,110,134,255); 
    p.ellipse(0,0,sizeXY,sizeXY);
 //   this.draw_bound_box(p);
  }
}


class Planet extends World_object {
  
  
  PImage moon_image;
  float  rotation_speed;
  PShape s;
  float planet_density;
  String planet_type;
  
  public Planet (int px, int py, int psize,float pplanet_density, float prot_speed,String pplanet_type,String pname) {
    super(px,py,psize);
   
    this.type_of = "planet";
    this.name = pname;
    
    this.rotation_speed = prot_speed;
    //moon_image = loadImage("moon1.png");
    this.planet_density = pplanet_density;
    this.mass  =  psize * this.planet_density; 
    this.planet_type = pplanet_type;


    if (pplanet_type == "sand"){
      this.s = loadShape("sand_planet_ronder.svg");
 
      
    }  
    if (pplanet_type == "iron"){
      this.s = loadShape("iron_planet_ronder.svg");

    }
 
  }
  

  void update (PApplet p) {
    if (game1.paused == false)
      {
        this.rotationZ = this.rotationZ + this.rotation_speed;
        this.move_update();  
      }
      
  }
  
  void draw (PApplet p) {
    
   shape(this.s, 0, 0, sizeXY*2.03, sizeXY*2.03);

  }
}



class Asteroid extends World_object {
  
  
  PImage asteroid_image;
  float  rotation_speed;
  boolean in_orbit = false;
  PShape s;

  
  public Asteroid (float px, float py, float vx, float vy, float psize, float prot_speed) {
    
    super(px,py,(psize*random(0,1)*0.5)+(psize*0.7));
  
    println("asteroid: " + this.sizeXY); 
    println("random(0,1): " + random(0,1)); 
    println("random(4,12): " + random(4,12)); 
    
    
 
    this.type_of = "Asteroid";
   
    this.rotation_speed = prot_speed*random(1);
    this.mass  =  psize * 30; 
    this.velx = vx;
    this.vely = vy;
   
     int  asteroid_pic = (round(random(1,4)) % 10); 
      
     switch (asteroid_pic){
     
       case 1:
        
          s = loadShape("asteroid1.svg");
        
       break;
     
       case 2:
        
          s = loadShape("asteroid2.svg");
        
       break;
     
       case 3:
        
          s = loadShape("asteroid3.svg");
        
       break;
     
       case 4:
        
          s = loadShape("asteroid4.svg");
        
       break;
     
     }
  
  }
  
  public Asteroid (float px, float py, float vx, float vy, float psize, float prot_speed, Orbit pastroid_orbit) {
    
    this(px,py,0,0,psize,prot_speed);
    this.in_orbit = true;
    pastroid_orbit.addChild(this);

  }
  
  Effect explode(){
  
    return (new astroid_explosion(this.global_coords_Point2D().x,this.global_coords_Point2D().y));

  }
 
  
  
  void update (PApplet p) {
  if (game1.paused == false)
      {
    
          this.rotationZ = this.rotationZ + this.rotation_speed;
          this.move_update();  
      }
   
  }
  
  void draw (PApplet p) {
    
   // if (game1.level_camera.zoomlevel < 1.3)
   // ellipse(0,0,
    shape(s, 0, 0, sizeXY*3.30, sizeXY*3.30);
    
 
  }
}


class Orbit extends NestSprite  {
    
  float rotation_speed;
  
  public Orbit (float prot_speed, Planet pplanet) {
   
    this.rotation_speed = prot_speed-pplanet.rotation_speed;
    pplanet.addChild(this);
   
  } 

  void update (PApplet p) {
 
    if (game1.paused == false)
    {
      this.rotationZ = this.rotationZ + this.rotation_speed;
    }
    
  }
  
  void draw (PApplet p) {

  }
}  



//clas turret !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!















