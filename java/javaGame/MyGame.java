import edu.nd.cse.paradigms.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

public class MyGame extends PEGame
{
	protected PEEngine engine;
	private PECircle circle;
	private PESquare square;

	public void collisionDetected(List <PEWorldObject> worldObjects)
	{
		//System.out.println(worldObjects.size());
		int x = circle.getX();
		int y = circle.getY();

		for (PEWorldObject element : worldObjects) {
			if (element.inObjectBoundary(x, y)) {
				engine.remove(element);
			}
		}
	}

	public void tick()
	{
	//
	}

	public void start()
	{
		engine = new PEEngine(this);
		circle = new PECircle();
		square = new PESquare();
		circle.setRadius(50);
		circle.setCenter(50,50);
		square.setSize(50);
		square.setCenter(200, 200);
		engine.add(square);
		engine.add(circle);
	}

	public void keyPressed(int keycode)
	{
		int x = circle.getX();
		int y = circle.getY();
		if (keycode == PEKeyEvent.VK_DOWN) {
			circle.setCenter(x,y+15);
		}
		if (keycode == PEKeyEvent.VK_UP) {
			circle.setCenter(x, y-15);
		}
		if (keycode == PEKeyEvent.VK_RIGHT) {
			circle.setCenter(x+15, y);
		}
		if (keycode == PEKeyEvent.VK_LEFT) {
			circle.setCenter(x-15, y);
		}
	}

}
