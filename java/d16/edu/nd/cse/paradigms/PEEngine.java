package edu.nd.cse.paradigms;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Color;

public class PEEngine extends Frame
{
	protected PEGame game;
	protected PEScreen screen;
	protected int width = 640;
	protected int height = 480;
	protected int bg = 0x000000;
	protected int titlebarHeight = 0; // varies by OS

	public PEEngine(PEGame game)
	{
		screen = new PEScreen(width, height, bg);
		this.screen = screen;
		this.game = game;
		setSize(width, height); // where is this function
		setVisible(true);	// where is this function

		// your code here!
	}

/*
	public void add(PEWorldObject wo)
	{
	}
	
	public void remove(PEWorldObject wo)
	{
	}
*/	
	public void tick()
	{
	}
	
	public void run()
	{
	}
	
	public void update(Graphics g)
	{
	}

	public void paint(Graphics g)
	{
		g.drawImage(screen.render(), 0, titlebarHeight, width, height, Color.BLACK, null);
	}
}
