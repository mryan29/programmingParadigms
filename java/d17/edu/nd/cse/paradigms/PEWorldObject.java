package edu.nd.cse.paradigms;

abstract public class PEWorldObject 
{
	public int x, y, color;

	public PEWorldObject()
	{
	}
	
	public void setCenter(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
	
	public void setColor(int color)
	{
		this.color = color;
	}
	
	public int getX()
	{
		return this.x;
	}
	
	public int getY()
	{
		return this.y;
	}
	
	public abstract void tick();
	
	public abstract void render(PEScreen screen);

}