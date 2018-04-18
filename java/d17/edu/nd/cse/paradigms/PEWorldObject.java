package edu.nd.cse.paradigms;

abstract public class PEWorldObject 
{
	public int x = 0;
	public int y = 0; 
	public int color = 0x0000ff;
	private PEScreen screen;

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