public abstract class BirdProcess
{
	public abstract void processBird(Duck d);
	public abstract void processBird(Eagle e);

	public void processBird(Bird b)
	{
		if (b instanceof Duck)
			processBird((Duck)b);
		else if(b instanceof Eagle)
			processBird((Eagle)b);
	}
}
