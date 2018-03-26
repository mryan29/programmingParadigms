import edu.nd.cse.paradigms.*;

import java.util.List;
import java.util.ArrayList;

public class MyGame extends PEGame
{
	protected PEEngine engine;
	private PECircle circle;

	public void collisionDetected(List <PEWorldObject> worldObjects) {}
	
	public void tick() {
	//
	}
	public void start()
	{
		engine = new PEEngine(this);
		circle = new PECircle();
		circle.setRadius(50);
		circle.setCenter(50,50);
		engine.add(circle);
	}
	
	public void keyPressed(int keycode)
	{
		int x = circle.getX();
		int y = circle.getY();
		if (keycode == PEKeyEvent.VK_DOWN) {
			circle.setCenter(x,y+15);
		}
	}

}
