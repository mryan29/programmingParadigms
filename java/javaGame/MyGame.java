import edu.nd.cse.paradigms.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

public class MyGame extends PEGame
{
	protected PEEngine engine;
	private PECircle circle;
	private PESquare square;
	private HardCollider collider;
	private Enemy enemy1;
	private Enemy enemy2;
	private Projectile projectile;
	
	public void collisionDetected(List <PEWorldObject> worldObjects)
	{
		//int x = circle.getX();
		//int y = circle.getY();

		//for (PEWorldObject element : worldObjects) {
		//	if (element.inObjectBoundary(x, y)) {
		//		engine.remove(element);
		//	}
		//}
		int i = 0;
		for (PEWorldObject wo : worldObjects) {
			collider.processCollision(wo, worldObjects.get(i^1));
			i++;
		}

	}

	public void tick()
	{
	//
	}

	public void start()
	{
		engine = new PEEngine(this, 50);
		circle = new PECircle();
		square = new PESquare();
		collider = new HardCollider(engine);
		enemy1 = new Enemy();
		enemy2 = new Enemy();

		enemy1.setSize(25);
		enemy1.setCenter(250, 250);
		engine.add(enemy1);

		enemy2.setSize(25);
		enemy2.setCenter(100, 300);
		engine.add(enemy2);
		
		circle.setRadius(30);
		circle.setCenter(50,50);
		engine.add(circle);

		projectile = new Projectile(enemy1);
		projectile.setRadius(15);

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
		if (keycode == PEKeyEvent.VK_SPACE) {
			//projectile = new Projectile();
			//projectile.setRadius(10);
			projectile.setCenter(x, y);
			engine.add(projectile);
		}

	}

}
