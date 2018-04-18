package edu.nd.cse.paradigms;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Color;
import java.awt.event.KeyListener;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
//import java.util.List;
//import java.util.Queue;
//import java.util.LinkedList;
import java.util.*;
import edu.nd.cse.paradigms.PEGame;
import edu.nd.cse.paradigms.PEScreen;

public class PEEngine extends Frame
{
	protected PEGame game;
	protected PEScreen screen;
	protected PECentralClock clock;
	protected int width = 640;
	protected int height = 480;
	protected int bg = 0x000000;
	protected int titlebarHeight = 0; // varies by OS
	//protected Queue<PEWorldObject> worldObjects;
	List<PEWorldObject> worldObjects;
	private Queue<PEEvent> eventQueue;

	public PEEngine(PEGame game)
	{
		screen = new PEScreen(width, height, bg);
		this.game = game;
		//setSize(width, height); // where is this function
		//setVisible(true);	// where is this function
		clock = new PECentralClock(this, 50);
		worldObjects = new ArrayList<PEWorldObject>();
		eventQueue = new LinkedList<PEEvent>();
		// your code here!
	}


	public void add(PEWorldObject wo)
	{
		worldObjects.add(wo);
		//int i = 0;
		/*for (PEWorldObject w : worldObjects) {
			System.out.printf("%d", i);
			i++;
		} */
	}
	
	public void remove(PEWorldObject wo)
	{
		worldObjects.remove(wo);
	}
	
	public void keyPressed(KeyEvent e)
	{
		PEKeyEvent event = new PEKeyEvent(e);
		eventQueue.add(event);
	}
	
	public void keyReleased(KeyEvent e)
	{
	}
	
	public void keyTyped(KeyEvent e)
	{
	}
	
	public void processEvent(PEKeyEvent e)
	{
		int keycode = e.getKeyCode();
		game.keyPressed(keycode);
	}
	
	public void eventLoopIterate()
	{
		int count = 0;
		int s = eventQueue.size();
		
		while (count != s) {
			PEEvent e = eventQueue.poll();
			if (e instanceof PEKeyEvent) {
				processEvent( (PEKeyEvent)e );
			} // else {
		}
	}
	
	public void tick() // calls render wo in screen for every wo
	{
		game.tick();
		screen.clear();
		//int i = 0;
		for (PEWorldObject wo : worldObjects) {
			screen.renderWorldObject(wo);
			//worldObjects.get(i^1));
			//i++;
		}
		eventLoopIterate();
		repaint();
	}  
	
	public void run()
	{
		this.tick();
	}
	
	public void update(Graphics g) // calls paint
	{
		paint(g);
	}

	public void paint(Graphics g) // calls screen render method
	{
		g.drawImage(screen.render(), 0, titlebarHeight, width, height, Color.BLACK, null);
	}
}
