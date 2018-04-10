package edu.nd.cse.paradigms;

import java.awt.image.BufferedImage;
import java.awt.Graphics;
import java.awt.Color;

public class PEScreen
{
	private int width, height, color;
	private int bg;
	private BufferedImage image;
	private int[][] pixels;

	public PEScreen(int width, int height, int color)
	{
		this.width = width;
		this.height = height;
		this.color = color;
		this.bg = 0x22CC11; // default background color is green
		this.pixels = new int [width][height];
		clear();
	}

	public void setPixel(int px, int py, int color)
	{
		if (inBounds(px, py))
			this.pixels[px][py] = color;
		
	}

	public void clear()
	{
		// your code here
		for (int i = 0; i < this.width; i++) {
			for (int j = 0; j < this.height; j++) {
				setPixel(i, j, this.bg);
			}
		}
	}

	public boolean inBounds(int px, int py)
	{
		// your code here
		if (px >= 0 && px < this.width && py >= 0 && py < this.height) {
			return true;
		} else {
			return false;
		}
	}
/*	
	public void renderWorldObject(PEWorldObject wo)
	{
	}
*/
	public BufferedImage render()
	{
		// your code here
		this.image = new BufferedImage(this.width, this.height, BufferedImage.TYPE_INT_RGB);
		for (int i = 0; i < this.width; i++) {
			for (int j = 0; j < this.height; j++) {
				image.setRGB(i, j, this.pixels[i][j]);
			}
		}
		
		return this.image;
	}
}
