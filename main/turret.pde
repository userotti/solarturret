
class Turret extends World_object {
  
  
  PShape turret_image;
  float max_left, max_right;
  float rotation_speed;
  Gun current_gun;
  
  
  
  
  float max_shotpower;
  float min_shotpower;
  
 
  float current_shotpower = 0;
  
  // vir die gage
  float max_energy;
  float min_energy;
  float current_energy;
  float energy_recharge_speed;

  float gun_drain;  
  float gun_charge_up_speed;

  Planet base_planet; 
  Turret_Base base;
  

  
  public Turret (float pangle, float protation_speed, float pmin_shotpower, float pmax_shotpower, float pmax_energy, Planet pbase_planet, String pname) {
    super(0,0,120);

    this.setBounds(this.sizeXY*-0.02,this.sizeXY*-0.10,this.sizeXY*0.05,this.sizeXY*0.13);

//    turret_image = loadImage("turret_kleiner.png");
    this.turret_image = loadShape("nuwe_turret.svg");
    

    this.type_of = "turret";
    this.name = pname;
    this.max_shotpower = pmax_shotpower;
    this.max_energy = pmax_energy;
    this.current_energy = this.max_energy;

    this.energy_recharge_speed = 0.25;

    this.gun_drain = 1.6;
    this.gun_charge_up_speed = 0.018;
    this.min_shotpower = pmin_shotpower;

    this.current_shotpower = this.min_shotpower;
     
    this.base_planet = pbase_planet;
    this.base = new Turret_Base(0,-1*int(this.base_planet.sizeXY*0.5)-10,90);
    Cos_Light turret_light1 = new Cos_Light(this.sizeXY*-0.024,this.sizeXY*-0.13,227,86,75,1,0.06);
     
    
    this.max_left = -3.14/2;
    this.max_right = 3.14/2;
    this.rotationZ = pangle;
    this.rotation_speed = protation_speed;


    
       
    this.base_planet.addChild(this.base); 
    this.base.addChild(this); 

    this.addChild(turret_light1);
    
//    Cos_Light turret_light2 = new Cos_Light(0,-10,227,86,75,3,0.06);
//    this.addChild(turret_light2);
     
 
}
  
  
  //shoot vibes
  public Turret (Planet pbase_planet, String pname) {
//    super(0,0,120);
    this(0,0.02,0.5,4.0,100,  pbase_planet, pname); 
    
  }
  void rotate_left() {
    
  
      if (this.rotationZ  > this.max_left)
   
        this.rotationZ -= this.rotation_speed;
   
      else
   
        this.rotationZ = this.max_left;

    
  }

  void rotate_right() {
    
  
      if (this.rotationZ  < this.max_right)
   
        this.rotationZ += this.rotation_speed;
   
      else
   
        this.rotationZ = this.max_right;

    
  }
  
  //begin van die gun stuff ***************************
  
  Point2D.Float get_bullet_vector(Point2D.Float pp, Point2D.Float sp){
    
    float bullet_velx, bullet_vely;
    float die_hoek;
    
    die_hoek = atan2(sp.y-pp.y , sp.x-pp.x);
    
   
    
    bullet_velx = -1*cos(die_hoek) * current_shotpower;
    bullet_vely = -1*sin(die_hoek) * current_shotpower;
    
    return new Point2D.Float(bullet_velx,bullet_vely);
    
  }
  
  Explosion turret_shoot_effects(){
    
    Point2D.Float place_point = new Point2D.Float(0,-14);
    Point2D.Float shootangle_point = new Point2D.Float(0,0);
  
    place_point = this.localToGlobal(place_point);
    shootangle_point = this.localToGlobal(shootangle_point);
    
   
    return new Turret_flash(place_point.x, place_point.y,current_shotpower);
  
  
  }  
  
  
  //shoot vibes
  
  void after_shoot(){
    this.current_shotpower = this.min_shotpower;
  }  
  
  Bullet shoot() {
    

    
    Point2D.Float place_point = new Point2D.Float(0,-10);
    Point2D.Float shootangle_point = new Point2D.Float(0,0);
    Point2D.Float bullet_vector; 
    
    place_point = this.localToGlobal(place_point);
    shootangle_point = this.localToGlobal(shootangle_point);
    
    bullet_vector = get_bullet_vector(place_point,shootangle_point);
    


    return new Bullet (place_point.x, place_point.y, bullet_vector.x, bullet_vector.y);
     

  
  }
  
  float get_min_shotpower(){
   
    return this.min_shotpower; 
  }  
  
  float get_max_enregy(){
   
    return this.max_energy;
    
  }  
  
  void charging_energy(){
  
    this.current_energy = this.current_energy+this.energy_recharge_speed;
    
    if (this.current_energy  >  this.max_energy) 
      this.current_energy = this.max_energy;
    
    
  }
  
  void powerup_gun(){
   
    if  (this.current_shotpower < this.max_shotpower)
      if (this.current_energy > 0)
    {
      this.current_energy = this.current_energy-this.gun_drain;
      this.current_shotpower = this.current_shotpower + this.gun_drain*this.gun_charge_up_speed;//0.028;
      println(this.current_shotpower);
    }
    
  }  
 
  

  //einde van die gun stuff ***************************
  
  void update (PApplet p) {
  //nog niks
    this.charging_energy();

  }
  
  void draw (PApplet p) {
    
   // p.fill(145,145,145,255);
   // p.ellipse(-0.5*sizeXY, -0.5*sizeXY, sizeXY, sizeXY);
   //image(turret_image, -79*sizeXY, -225*sizeXY, 150*sizeXY, 250*sizeXY);
  shape(this.turret_image, 0, 0, this.sizeXY, this.sizeXY); 
//   p.fill(255,255,255,155);
//   p.rect(this.boundsLeft, this.boundsTop,this.width, this.height);// hit area
//   p.rect(this.boundsLeft, this.boundsTop,this.width, this.height);// hit area
    
 //  noFill(); 
 
	
  }
}

class Turret_Base extends World_object {
  
  
  PShape turret_base_image;
  
  public Turret_Base (int px, int py, float angel) {
    super(px,py,1);
    
    this.type_of = "turret_base";
    this.turret_base_image = loadShape("nuwe_turret_base.svg");
    
    
    this.setBounds(this.sizeXY*-13,this.sizeXY*-1.5,this.sizeXY*26,this.sizeXY*15);
  }
  
  // update() is called first by NestSpriteContainer.update(),
  // and should be used to set the transformations
  // (position, scale, rotation) of the NestSprite before drawing it.

  void update (PApplet p) {
  //nog niks

  }
  
  void draw (PApplet p) {
    
   // p.fill(145,145,145,255);
   // p.ellipse(-0.5*sizeXY, -0.5*sizeXY, sizeXY, sizeXY);
    shape(turret_base_image, 0, 0, 80*sizeXY, 80*sizeXY);
   
 //  p.fill(255,255,255,155);
 //  p.rect(this.boundsLeft, this.boundsTop,this.width, this.height);// hit area
	
  }
}

class Gun {
  
    
  
  
  
}  
  
  


