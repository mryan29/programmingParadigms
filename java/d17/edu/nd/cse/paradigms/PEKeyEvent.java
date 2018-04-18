package edu.nd.cse.paradigms;
import java.awt.event.KeyEvent;

public class PEKeyEvent extends PEEvent
{
	int keycode = -1;
	
	public PEKeyEvent(KeyEvent awtKeyEvent)
	{
		this.keycode = awtKeyEvent.getKeyCode();
	}
	
	public int getKeyCode()
	{
		return KeyEvent.keycode;
		// maybe return this.keycode?
	}
}