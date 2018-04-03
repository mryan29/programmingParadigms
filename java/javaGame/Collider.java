public abstract class Collider
{
	public abstract void processCollision(PECircle circle, PEWorldObject wo);
	public abstract void processCollision(Enemy enemy, PEWorldObject wo);

	public void processCollision(PEWorldObject wo1, PEWorldObject wo2)
	{
		if (wo1 instanceof PECircle)
			processCollision((PECircle)wo1, wo2);
		else if (wo1 instanceof Enemy)
			processCollision((Enemy)wo1, wo1);
	}
}
