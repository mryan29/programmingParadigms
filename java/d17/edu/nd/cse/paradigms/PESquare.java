package edu.nd.cse.paradigms;

public class PESquare extends PEWorldObject 
{

	public int size;
	public PESquare()
	{
	}
	
	public void tick()
	{
	}
	
	public void setSize(int size)
	{
		this.size = size;
	}
	
	
	public void render(PEScreen screen)
	{
		screen.renderWorldObject(this);
	}

}