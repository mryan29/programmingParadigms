package edu.nd.cse.paradigms;

public class PECentralClock //extends TimerTask
{
	protected int rate;
	protected PEEngine engine;

	public PECentralClock(PEEngine engine, int rate)
	{
		this.engine = engine;
		engine.tick();
		this.rate = rate;
	}
	
	public void run()
	{
		engine.tick();
	}

}