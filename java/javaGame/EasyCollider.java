import edu.nd.cse.paradigms.*;

public class EasyCollider extends Collider
{
	private PEEngine engine;

	public EasyCollider(PEEngine engine)
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
			engine.remove(enemy)
	}
}
