


class Level
{
  

  PImage bg;
  //items in level
  Turret player_turret;
  float gravconstant = 0;
  ArrayList bullets_in_level;
  ArrayList planets_in_level;
  ArrayList asteroids_in_level;
  ArrayList orbits_in_level;

  ArrayList objects_of_level;
  
  
  int time;
  Bullet single_bullet;
  Planet single_planet;
  Asteroid single_asteroid;
  Orbit single_orbit;
  
  World_object single_object;
  Point2D.Float single_point; 
  
  NestSpriteContainer top_level_Container;
  NestSpriteContainer bullet_Container;
  NestSpriteContainer effect_Container;
  
  
  
  
  public Level (int levelnumber,PApplet p) {
  
    bullets_in_level = new ArrayList();
    planets_in_level = new ArrayList();
    asteroids_in_level = new ArrayList();
    orbits_in_level = new ArrayList();
    
    
    objects_of_level = new ArrayList();
    
    
    top_level_Container = new NestSpriteContainer(p);
    bullet_Container = new NestSpriteContainer(p);
    effect_Container = new NestSpriteContainer(p);
    
    
    switch(levelnumber) {   
    case 1: //LEVEL 1 ------------------------------------------------------------
    
      
      gravconstant = (0.0002 * 30); // sq 10;// not sq 0.0013;  // level 1 se grav constant
  
      // set background
      bg = loadImage("flame-nebula640_480.jpg");
      
      this.single_planet = new Planet(0,0, 280,100, 0.00, "sand", "homeplanet");     // add planets to level
      planets_in_level.add(this.single_planet); 
     
      this.single_orbit = new Orbit(-0.0004,this.single_planet);
      orbits_in_level.add(this.single_orbit);
     
      
      planets_in_level.add(new Planet(100,-250, 45,300, 0.002, "iron","ysterplaat")); 
      
      asteroids_in_level.add(new Asteroid(0,-250,0,0, 10, 0.01, this.single_orbit));
      asteroids_in_level.add(new Asteroid(-50,-200,0,0, 10, 0.01, this.single_orbit));
      asteroids_in_level.add(new Asteroid(-150,-150,0,0, 10, 0.01, this.single_orbit));
      asteroids_in_level.add(new Asteroid(250,-100,0,0, 10, 0.01, this.single_orbit));
     
      asteroids_in_level.add(new Asteroid(23,250,0,0, 10, 0.01, this.single_orbit));
      asteroids_in_level.add(new Asteroid(100,200,0,0, 10, 0.01, this.single_orbit));
      asteroids_in_level.add(new Asteroid(-150,150,0,0, 10, 0.01, this.single_orbit));
      asteroids_in_level.add(new Asteroid(150,+150,0,0, 10, 0.01, this.single_orbit));
      
      //asteroids_in_level.add(new Asteroid(150,-280,0,0, 20, 0.01));
      this.player_turret = new Turret((Planet)planets_in_level.get(0), "player1"); 

      break;
      
    
  
    
    case 2: //LEVEL 2 ------------------------------------------------------------
    
      
      gravconstant = (0.0002 * 30); // sq 10;// not sq 0.0013;  // level 1 se grav constant
  
      // set background
      bg = loadImage("flame-nebula640_480.jpg");
      
      this.single_planet = new Planet(0,0, 280,100, 0.00, "sand", "homeplanet");     // add planets to level
      planets_in_level.add(this.single_planet); 
     
      this.single_orbit = new Orbit(-0.0004,this.single_planet);
      orbits_in_level.add(this.single_orbit);
     
      
      for (int i = 0; i < 150; i++){ //add n honderd astroids
        float die_hoek = 0 + i*(6.28/50);
        asteroids_in_level.add(new Asteroid(cos(die_hoek)*random(230,260),sin(die_hoek)*random(230,260),0,0, 10, 0.01, this.single_orbit));
      }
  

      //asteroids_in_level.add(new Asteroid(150,-280,0,0, 20, 0.01));
      this.player_turret = new Turret((Planet)planets_in_level.get(0), "player1"); 

      break;
      
    }
  
    this.add_level_start_objects_to_scenegraph();

  }

  
  void add_level_start_objects_to_scenegraph() {
    
    this.add_planets_to_scenegraph ();
    this.add_asteroid_to_scenegraph();
    
  }  
  
  
  void add_planets_to_scenegraph()  {
  
    println("num of planets in level = " + planets_in_level.size());
    
    if (planets_in_level.size() != 0) {
      for (int i = 0; i < planets_in_level.size(); i++){
         this.top_level_Container.addChild((Planet)planets_in_level.get(i));      
      }  //for
    
    } //if  
  
  } //method 
  
  
  void add_asteroid_to_scenegraph()  {
  

    
    if (asteroids_in_level.size() != 0) {
      for (int j = 0; j < asteroids_in_level.size(); j++){
        if (  ((Asteroid)asteroids_in_level.get(j)).in_orbit == false   )
        this.top_level_Container.addChild((Asteroid)asteroids_in_level.get(j));      
      }  //for
    
    } //if  
  
  } //method 
  
  
  // set this.single_object to the object your're looking for
  
  void get_object_by_name(String ptype_of, String pname) {  //this.get_object_by_name("planet", "son");
  
    if  (ptype_of == "planet"){

        if (this.planets_in_level.size() != 0) // NET EEN NET EENNET EENNET EENNET EEN sonner { }
        for (int i = 0; i < this.planets_in_level.size();  i++){
      
          single_object = (Planet)planets_in_level.get(i);
         
          if (this.single_object.name  == pname){
          
           return;
            
          }//if
        
        }//for 
      
    }//groot if
    
   
    
   

  }//method
  
  
  
  PImage get_background (){

    return this.bg;
    
  }
  
  Turret get_player_turret(){

    return this.player_turret;
    
  }
 
  boolean any_bullets () {
    
    if (this.bullets_in_level.size() != 0) 
    return true;
    
    else
    return false;
    
    
  }
  Bullet get_last_fired(){
   
    
    
    
    if (this.any_bullets())
    
  // for (int i = 0; i < this.bullets_in_level.size()
    
    {
      
    
      println("true");
      this.single_bullet = (Bullet)(this.bullets_in_level.get(this.bullets_in_level.size()-1));
    
      return this.single_bullet;
    }
    else
    
      return null;
    
    
    
  }  
   
  void addbullet_to_sg_and_struct(Bullet b) {
    
    bullets_in_level.add(b);
 //   println("bullets_in_level.size(); = " + bullets_in_level.size());
    this.bullet_Container.addChild(b);

  }
  
  void calculate_gravity () {
  

    float gravforce = 0;
    float  dist_sqrd = 0;
    float  die_hoek = 0;

    if ((bullets_in_level.size() != 0) && (planets_in_level.size() != 0)){
    
      
      for (int j = 0; j < bullets_in_level.size();  j++){
      
         this.single_bullet = (Bullet)bullets_in_level.get(j);
         this.single_bullet.forcex = 0;
         this.single_bullet.forcey = 0;
      }
     
     
      for (int j = 0; j < bullets_in_level.size();  j++){
        
        for (int i = 0; i < planets_in_level.size();  i++){
          
          
          
          this.single_bullet = (Bullet)bullets_in_level.get(j);
          this.single_planet = (Planet)planets_in_level.get(i);
          
          
          
          dist_sqrd = sq(this.single_bullet.x-this.single_planet.x) + sq(this.single_bullet.y-this.single_planet.y);
          
          die_hoek = atan2((this.single_bullet.y-this.single_planet.y),(this.single_bullet.x-this.single_planet.x));
          
          gravforce = (this.single_bullet.mass*this.single_planet.mass/dist_sqrd) * this.gravconstant;
  
          
          this.single_bullet.forcex = this.single_bullet.forcex + (-1*cos(die_hoek)*gravforce);   
          this.single_bullet.forcey = this.single_bullet.forcey + (-1*sin(die_hoek)*gravforce);
          
          
          
          gravforce = 0;
          dist_sqrd = 0;
          die_hoek = 0;
  
                  
        
        } //for i planets
      
      } //for j  bullets
      
    } 
    

  }  
  
  void collision_bullets_planets () {
    
   
    boolean just_killed_at_least_one = false;
    
    if ((bullets_in_level.size() != 0) && (planets_in_level.size() != 0)){
       
       
       for (int j = 0; j < this.bullets_in_level.size();  j++){    // die if
         for (int i = 0; i < this.planets_in_level.size();  i++){
         
                    this.single_bullet = (Bullet)bullets_in_level.get(j);
                    this.single_planet = (Planet)planets_in_level.get(i);
         
                    if  (this.single_planet.hitTest(this.single_planet.globalToLocal(this.single_bullet.global_coords_Point2D()),false)){ //check hit
                        
            
                     //maybe less expecive
                          if (this.single_planet.dist_to_center_in_local_squared(this.single_planet.globalToLocal(this.single_bullet.global_coords_Point2D())) < sq( (this.single_planet.sizeXY*0.5)+ this.single_bullet.sizeXY)){ 
      
                                
                            // this.single_bullet.explode();
                         //       println();                            
                         //       println("die bullet vel hoek" + atan2(this.single_bullet.vely,this.single_bullet.velx) * 180/PI);
                         //       println("die bullet en planet hoek" + atan2(this.single_planet.y-this.single_bullet.y,this.single_planet.x-this.single_bullet.x) * 180/PI);
                                
                            //    print("velx" + this.single_bullet.velx);
                            //    print("vely" + this.single_bullet.vely);
                                
                                
                                this.single_bullet.is_stil_alive = false;
                                just_killed_at_least_one = true;

                                //this.single_bullet.velx = -1*this.single_bullet.velx;
                                //this.single_bullet.vely = -1*this.single_bullet.vely;
                                
                         }  
                    }//th first if
           
         } //for i

       }//for j  
       
    } 
    
    if (just_killed_at_least_one){// save_crazy //so now one must actuacly delete it from the data, if (stil_alive = false) the scenegraph deletes it from there
       
           for (int j = 0; j < this.bullets_in_level.size();  j++){    // remove_invisibles
                      
                        this.single_bullet = (Bullet)bullets_in_level.get(j);
                      
                        if  (this.single_bullet.is_stil_alive == false) {
 
                          this.single_bullet.visible = false;  
                          this.effect_Container.addChild(this.single_bullet.explode());
                          //println ("draw die fokken ding");
                          this.bullets_in_level.remove(j);  // BUT THE CAMRA IS STILL LLOKING AT YOU!!!!!!!!!!!!!!!!!!!!!! witch is fine nowz
                          j = 0;                            // level needs to be passed to camera    
                          this.bullet_Container.removeChild(this.single_bullet).dispose();
                           
                          // this.time_to_change_the_camera == true;
                           //camera check for a flag from its level
                        }
           } //for j

    }
   
 
 }// method
void collision_bullets_asteroids () {
    
   
    boolean just_killed_at_least_one_b = false;
    boolean just_killed_at_least_one_a = false;

    if ((bullets_in_level.size() != 0) && (asteroids_in_level.size() != 0)){
       
       
       for (int j = 0; j < this.bullets_in_level.size();  j++){    // die if
         for (int i = 0; i < this.asteroids_in_level.size();  i++){
         
                    this.single_bullet = (Bullet)bullets_in_level.get(j);
                   
                    this.single_asteroid = (Asteroid)asteroids_in_level.get(i);
                          
                    if  (this.single_asteroid.hitTest(this.single_asteroid.globalToLocal(this.single_bullet.global_coords_Point2D()),false)){ //check hit
                        
                        println("asteroid hit!");
                        
                     //maybe less expecive
                          if (this.single_asteroid.dist_to_center_in_local_squared(this.single_asteroid.globalToLocal(this.single_bullet.global_coords_Point2D())) < sq( (this.single_asteroid.sizeXY*0.5)+ this.single_bullet.sizeXY)){ 
      
                                
                            // this.single_bullet.explode();
                                this.single_bullet.is_stil_alive = false;
                                just_killed_at_least_one_b = true;
                                
                                this.single_asteroid.is_stil_alive = false;
                                just_killed_at_least_one_a = true;
                                
                            
                         }  
                    }//th first if
           
         } //for i

       }//for j  
       
    } 
    
    if (just_killed_at_least_one_b){// save_crazy //so now one must actuacly delete it from the data, if (stil_alive = false) the scenegraph deletes it from there
       
           for (int j = 0; j < this.bullets_in_level.size();  j++){    // remove_invisibles
                      
                        this.single_bullet = (Bullet)bullets_in_level.get(j);
                      
                        if  (this.single_bullet.is_stil_alive == false) {
 
                          this.single_bullet.visible = false;  
                          this.effect_Container.addChild(this.single_bullet.explode());
                          //println ("draw die fokken ding");
                          this.bullets_in_level.remove(j);  // BUT THE CAMRA IS STILL LLOKING AT YOU!!!!!!!!!!!!!!!!!!!!!! witch is fine nowz
                          j = 0;                            // level needs to be passed to camera    
                          this.bullet_Container.removeChild(this.single_bullet).dispose();
                           
                          // this.time_to_change_the_camera == true;
                           //camera check for a flag from its level
                        }
           } //for j

    }
    
    if (just_killed_at_least_one_a){// save_crazy //so now one must actuacly delete it from the data, if (stil_alive = false) the scenegraph deletes it from there
       
           for (int j = 0; j < this.asteroids_in_level.size();  j++){    // remove_invisibles
                      
                        this.single_asteroid = (Asteroid)asteroids_in_level.get(j);
                      
                        if  (this.single_asteroid.is_stil_alive == false) {
 
                          this.single_asteroid.visible = false;  
                          this.effect_Container.addChild(this.single_asteroid.explode());
                          //println ("draw die fokken ding");
                          this.asteroids_in_level.remove(j);  // BUT THE CAMRA IS STILL LLOKING AT YOU!!!!!!!!!!!!!!!!!!!!!! witch is fine nowz
                          j = 0;                            // level needs to be passed to camera    
                          this.top_level_Container.removeChild(this.single_asteroid).dispose();
                           
                          // this.time_to_change_the_camera == true;
                           //camera check for a flag from its level
                        }
           } //for j

    }
   
 
 }// method
  
 
  
  //void remove
  
  void collision_detection (){
   
   
     this.collision_bullets_planets();
     this.collision_bullets_asteroids();
  }  
 
 /* void remove_sprite_from_container (NestSpriteContainer sc, NestSprite s){
   
    for  
    sc.removeC
    
  }
  */
    
  void update_containers(){
   
    this.bullet_Container.update(); //draw bullets
    this.effect_Container.update();
    this.top_level_Container.update();  // draw top level stuff

    
  }
  
  void update_mechanics (){
  
       
    this.calculate_gravity();
    this.collision_detection();
  
    
   
    time = time + 1;
    
    
    
    
    
  }  
}

