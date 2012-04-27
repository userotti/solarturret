class Cameraclass {
  
  float zoomlevel;
  float focus_x;
  float focus_y;
  
  float close_zoomlevel = 2.5;
  float main_zoomlevel = 1.4;
  float dist_zoomlevel = 0.60;
  float map_zoomlevel = 0.05;
 
  float previous_mouseX = 0;
  float previous_mouseY = 0;
  
  boolean dragcam = false;
  
 
  Point2D.Float mouse_point2d = new Point2D.Float(0,0);
  

  
  Point2D.Float first_click_drag_point_static = new Point2D.Float(0,0);
  Point2D.Float first_middle_drag_point_static = new Point2D.Float(0,0);
  
  Point2D.Float drag_focus = new Point2D.Float(0,0);
  
  PMatrix2D matrix_object = new PMatrix2D();
  float[] matrix_array = new float[6];


  
  World_object currently_focused_object;
  
  
  public Cameraclass (World_object wo){
   
    this.zoomlevel = close_zoomlevel;
    this.currently_focused_object = wo;
    this.set_camera_point2d(this.currently_focused_object.global_coords_Point2D());
    
  }
  
  Point2D.Float screen_coords_to_world(float die_screen_point_x,float die_screen_point_y ){
  
    getMatrix().get(this.matrix_array);
    matrix_object.set(this.matrix_array);
    
    matrix_object.invert();
    matrix_object.get(this.matrix_array);
    
    
    Point2D.Float die_world_point = new Point2D.Float(0,0);
    
    die_world_point.x  = (((die_screen_point_x)*this.matrix_array[0])+this.matrix_array[2]);
    die_world_point.y = (((die_screen_point_y)*this.matrix_array[4])+this.matrix_array[5]);
    
    return die_world_point;
    
  }  
  
  
  void mouse_clicked(){
    this.previous_mouseX = this.first_click_drag_point_static.x;
    this.previous_mouseY = this.first_click_drag_point_static.y;
  }  
  void mouse_pan(){
  if (game1.level_camera.dragcam == true){
   
      getMatrix().get(this.matrix_array);
      matrix_object.set(this.matrix_array);
      
      matrix_object.invert();
      matrix_object.get(this.matrix_array);
      
     
      this.mouse_point2d.x  = (((mouseX - this.previous_mouseX)*this.matrix_array[0]));
      this.mouse_point2d.y = (((mouseY - this.previous_mouseY)*this.matrix_array[4]));
      
      this.drag_focus.x =  this.focus_x - this.mouse_point2d.x;
      this.drag_focus.y =  this.focus_y - this.mouse_point2d.y;
  
      this.previous_mouseX = mouseX;
      this.previous_mouseY = mouseY;
  
      this.set_camera_point2d(this.drag_focus);
   
  }
  game1.level_camera.dragcam = false;
 }
 
 void set_new_previous_mouse(){
  this.previous_mouseX = mouseX; 
  this.previous_mouseY = mouseY; 
 } 
  

 void mouse_zoom(int up_or_down){
  
  if (up_or_down == 1)
    this.zoomlevel = this.zoomlevel * 0.9;
  else 
  if (up_or_down == -1)
    this.zoomlevel = this.zoomlevel * 1.1;
  else
    this.zoomlevel = 20;
  
  
 
 }
 
 
 
  void set_camera_point2d (Point2D.Float p){
   
    this.focus_x = p.x;
    this.focus_y = p.y;
 
    
  }


  void zoom(){
   
    
    translate(this.focus_x,this.focus_y);
    scale(this.zoomlevel);
    translate(-this.focus_x,-this.focus_y);
    
  }
  
  
  void focus_and_set_matrix (){
  
  /*  if  (this.currently_focused_object != null){
      this.set_camera_point2d(this.currently_focused_object.global_coords_Point2D());
      translate(width*0.5-this.focus_x,height*0.5-this.focus_y);
      this.zoom();
    }*/
//    this.set_camera_point2d(this.currently_focused_object.global_coords_Point2D());
      translate(width*0.5-this.focus_x,height*0.5-this.focus_y);
      this.zoom();
    
  }
  
  void focus_on (World_object wo){
  
    this.currently_focused_object = wo;
     
  }
  
  
  void zoom_in() {
   
      if (this.zoomlevel == this.main_zoomlevel)
      
        this.zoomlevel = this.close_zoomlevel;
        
      if (this.zoomlevel == this.dist_zoomlevel)
      
        this.zoomlevel = this.main_zoomlevel;
      
      if (this.zoomlevel== this.map_zoomlevel)
      
        this.zoomlevel = this.dist_zoomlevel;
      
        
  }  
  void zoom_map(){
    this.zoomlevel = this.map_zoomlevel;
  }  
  
  void zoom_dist(){
    this.zoomlevel = this.dist_zoomlevel;    
  }  
  
  void zoom_main(){
    this.zoomlevel = this.main_zoomlevel;    
  }  
  
  void zoom_close(){
    this.zoomlevel = this.close_zoomlevel;
  }  
  
  
   void zoom_out() {
   
  
       if (this.zoomlevel == this.dist_zoomlevel)
      
         this.zoomlevel = this.map_zoomlevel;
         
         
       if (this.zoomlevel == this.main_zoomlevel)
      
        this.zoomlevel = this.dist_zoomlevel;
    
     
        
      
      if (this.zoomlevel == this.close_zoomlevel)
      
        this.zoomlevel = this.main_zoomlevel;
        
    
  }  
  
  
  void set_zoomlevel(float pzoom) {
   
   this.zoomlevel = pzoom;
    
    
  }  
  
  
}

