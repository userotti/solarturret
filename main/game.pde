
class Game {

  
  Level current_level;
  Hud game_hud;
  Cameraclass level_camera;
  Mouse_wheel_class nai;
  boolean paused = false;
  
   
  public Game (PApplet p) {

    this.loadlevel(p);
    this.loadhud(this.current_level, p);
    this.level_camera = new Cameraclass(this.current_level.get_player_turret());// focused on
    // level needs to be passed to camera so that camera can watch the time_to_change_the_camera bool
    // 
  }
    
  void loadhud(Level cl, PApplet p) {
    
    this.game_hud = new Hud(cl,p);
  }
  
  
  
  void loadlevel(PApplet p) {
    
    this.current_level = new Level(1, p);
  }
  
  //input funcs input funcs input funcs input funcs input funcs  input funcsinput funcs input funcs  input funcs input funcs input funcs 
  
  
//mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse mouse

 



  //keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard keyboard 
  
  void pressed_key_once(int the_key_code){
    
   
   switch(the_key_code) {
   
    
      case 90: 
        
        // this.level_camera.zoomlevel = 0.1;

        if (this.paused == true)
        this.paused = false;
        else
        this.paused = true;
        
        
        
            
        
     break;
      
     case 88: 
        
         this.level_camera.zoomlevel = 4.1;
            
        
     break;
     
     
     case 66: //"b"
       
        if ((this.current_level.any_bullets()) && (this.current_level.get_last_fired() != null)) {
       
          
            if (this.level_camera.currently_focused_object.type_of == "bullet")
            {
              this.level_camera.focus_on(this.current_level.get_player_turret());
              this.level_camera.zoom_main(); 
            }
            else 
            {
              this.level_camera.focus_on(this.current_level.get_last_fired());
              this.level_camera.zoom_close();  
          
            }  
          
        }
        else
          {
            this.level_camera.focus_on(this.current_level.get_player_turret()); 
            this.level_camera.zoom_main(); 
          }
        
        
     break;
     
   }
     
  } 
  
  
  
  void keyboard_up(int the_key_code){
  
    switch(the_key_code) {
    
      case 65:
      
       if (game1.paused == false)
       {
        this.current_level.addbullet_to_sg_and_struct(this.current_level.get_player_turret().shoot());  
        this.current_level.effect_Container.addChild(this.current_level.get_player_turret().turret_shoot_effects());  
        
        this.current_level.get_player_turret().after_shoot();
        
        
       
       } 
      
      
      
      break;
   
     
     case 90: 
        
       // "z"
      
        
     break;
      
     case 88: 
        
      // "x"       
        
     break;
      
      
     case 66: 
        
        
        
       //this.level_camera.currently_focused_object = this.current_level.get_player_turret();
        
        
     break;
    }
  }  
  
  
  void keyboard_keysdown_check(int i){
  
  
    Integer the_key = (Integer)currently_pressed_keys.get(i);
 
    
  
    switch(the_key.intValue()) {
    
      case 65:
       
       if (game1.paused == false)
       {
          this.current_level.player_turret.powerup_gun();
       } 
      
      break;
      
        
    case 90: 
        
       // "z"
      
        
     break;
      
     case 88: 
        
      // "x"       
        
     break;
      
      case 66: 
        
       
        
      break;
      
      
      case 37: 
       
        if (game1.paused == false)
        {
        this.current_level.player_turret.rotate_left();
        } 
      
      break;
      
      
      case 39: 

        if (game1.paused == false)
        {
        this.current_level.player_turret.rotate_right();
        }
        
      break;
      
    
      case 38:
    
        println("op nai");
        this.level_camera.mouse_zoom(-1);
       
            
      break;
      
      case 40: 
    
       println("down");
        this.level_camera.mouse_zoom(1);
            
      break;
    
    
      
   } //switch
        
  }// method key down  


  void update_hud(){
  
    this.game_hud.update(); // draw hud
  
    
  }
  
  void update_level(){
  
    this.current_level.update_mechanics(); 
    this.current_level.update_containers(); 
     
  }
  
  void update_camera(){
    
 
    this.level_camera.focus_and_set_matrix(); //maak die matrix reg vir teken
    
  }
}  


//Peasy cam se kak, wat werk, op n mac.... dink ek.


