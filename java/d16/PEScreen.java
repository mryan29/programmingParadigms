package edu.nd.cse.paradigms;

import java.awt.image.BufferedImage;

public class PEScreen
{
	private int width, height;
	private int bg;
	private BufferedImage image;
	private int[][] pixels;

	public PEScreen(int width, int height)
	{
		this.width = width;
		this.height = height;
		this.bg = 0x22CC11; // default background color is green
		// your code here
		int[][] pixels = new int [width][height]
	}

	public void setPixel(int px, int py, int color)
	{
		// your code here
	}

	public void clear()
	{
		// your code here
	}

	public boolean inBounds(int px, int py)
	{
		// your code here
	}

	public BufferedImage render()
	{
		// your code here
	}
}
