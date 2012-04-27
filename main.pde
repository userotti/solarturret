import com.transmote.nest.events.*;
import com.transmote.nest.*;

import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;


//Groot Globals

Game game1; 

//keyboard globals
ArrayList currently_pressed_keys = new ArrayList();
Integer last_released_key = 0;
boolean newkey = false;
boolean drawhom = false;
boolean just_clicked = false;

PShape astretoid_explotion_svg;


//keyboard funcs
void keyPressed() {
  
  
  newkey = true;

  for (int i = currently_pressed_keys.size()-1; i >= 0; i--) { 
     
     Integer c = (Integer)currently_pressed_keys.get(i);
     if (keyCode == c.byteValue())
       newkey = false; 
  } 
 
  if (newkey == true)
    currently_pressed_keys.add(keyCode);

  
  game1.pressed_key_once(keyCode);
  
}

void keyReleased()
{ 

  for (int i = currently_pressed_keys.size()-1; i >= 0; i--) { 
     
     Integer c = (Integer)currently_pressed_keys.get(i);
     if (keyCode == c.byteValue()){
       game1.keyboard_up(c.byteValue());        //gooi game1 se keyboard_up func
       currently_pressed_keys.remove(i);
     }
  } 

}  


void mouseDragged() {
  game1.level_camera.dragcam = true;
  
  
}

void mousePressed() {
  game1.level_camera.set_new_previous_mouse();  // baie belangrik vir die pan-ing
}


void loadShapes() {
  astretoid_explotion_svg = loadShape("explosion_ring.svg");

}

void setup() 
{
  size(640,480);
  smooth();
  frameRate(60);
  noStroke();

  new Mouse_wheel_class(this);
  loadShapes();
  
  game1 = new Game(this);
  resetMatrix();
}





void draw() {
   
//  shape(game1.current_level.get_background (),0,0,800,600);
   background(game1.current_level.get_background());
 // background(0);

  for (int i = currently_pressed_keys.size()-1; i >= 0; i--) { 
    game1.keyboard_keysdown_check(i);
  }  
  
  if (last_released_key != 0) {
    println ("last_released_key is not null!");
    last_released_key = 0;
  }
  
  

  pushMatrix();  
  game1.update_camera();
  game1.level_camera.mouse_pan();
  
  //draw Nestsprites in containers
  

  game1.update_level();

  popMatrix();

  game1.update_hud();
 

  text(frameRate,10,20);
  
  if (game1.paused)
    text("Paused: True", 500, 20);
  
  else
    text("Paused: False", 500, 20);
  

  
}
  

public class Mouse_wheel_class {
	
	private final WheelHandlerInterface zoomWheelHandler = new WheelHandlerInterface() {
		public void handleWheel(final int delta) {
                        drawhom = true;
  			game1.level_camera.mouse_zoom(delta);
                        println("zoomlevel: " + game1.level_camera.zoomlevel);
  
		}
	};
	
        private WheelHandlerInterface wheelHandler = zoomWheelHandler;
	private final PApplet p;
	
	private final PeasyMousewheelListener mouseWheelListener = new PeasyMousewheelListener();
	
	public Mouse_wheel_class(PApplet pp) {

                this.p = pp;
  		this.setActive();
	}

	
	public void setActive() {
		this.p.addMouseWheelListener(mouseWheelListener);
		
	}

	
	public WheelHandlerInterface getZoomWheelHandler() {
		return zoomWheelHandler;
	}

	
	public WheelHandlerInterface getWheelHandler() {
		return wheelHandler;
	}

	public void setWheelHandler(final WheelHandlerInterface wheelHandler) {
		this.wheelHandler = wheelHandler;
	}

	
	protected class PeasyMousewheelListener implements MouseWheelListener {
		public void mouseWheelMoved(final MouseWheelEvent e) {
			if (wheelHandler != null) {
				wheelHandler.handleWheel(e.getWheelRotation());
			}
		}
	}

	
}



public interface WheelHandlerInterface {
	public void handleWheel(final int delta);
}



