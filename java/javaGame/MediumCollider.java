import edu.nd.cse.paradigms.*;

public class MediumCollider extends Collider
{
	private PEEngine engine;
	int red = 0xf44253;
	public MediumCollider(PEEngine engine)
	{
		this.engine = engine;
	}

	public void processCollision(PECircle circle, PEWorldObject wo)
	{
		if (wo instanceof Enemy)
			engine.remove(circle);
	}

	public void processCollision(Enemy enemy, PEWorldObject wo)
	{
		if (wo instanceof Enemy)
			if (enemy.getLives() <= 0)
				engine.remove(enemy);
			else if (enemy.getLives() == 1)
				enemy.setColor(red);
				enemy.setLives(enemy.getLives() - 1);
	}
}
