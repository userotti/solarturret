class Hud {
  
  NestSpriteContainer hud_Container; 
  Power_gage hud_power_gage;
  
   public Hud (Level hud_level, PApplet p){
     
     hud_Container = new NestSpriteContainer(p);
     hud_power_gage = new Power_gage(30,450,70, hud_level.get_player_turret());
//    hud_level.player_turret
    
     hud_Container.addChild(hud_power_gage);
    
   }
 
   
   void update() {
   
     hud_Container.update();
     
   }  
 
  
  
}  

  

class Power_gage extends NestSprite {
  
  float sizeXY;
  float gage_height;
  
  float max_gage_height;
  Turret gage_turret;
  
  
  public Power_gage(int px, int py, int psizeXY, Turret pt) {
 
    super();
    this.x = px;
    this.y = py;
    this.sizeXY = psizeXY;
    this.gage_turret = pt;
    this.max_gage_height = this.gage_turret.get_max_enregy(); //100
    this.gage_height = this.max_gage_height;  // 100
    
    
    
    
  } 
   
  
  void update(PApplet p) {
  
    this.gage_height = this.gage_turret.current_energy;
    
  }
  
  
  void inc_gage_height(float mod_energy) {
   
     this.gage_height = this.gage_height + mod_energy; // 100 + 1 
    
  }  
  
  void dec_gage_height(float mod_energy) {
   
     this.gage_height = this.gage_height - mod_energy; // 100 - 1
    
  }  




  void draw(PApplet p) {
  
    
 
   p.fill(215,155,15,255);
   p.rect(0, 0, sizeXY*0.1, -sizeXY*(this.gage_height)*0.01);
   
 p.fill(255,255,255,255); 
   p.rect(0, -sizeXY*(this.max_gage_height)*0.01, sizeXY*0.1, -2);
  // println("teken die powergaege");

  }
  
  
  
  
} 

