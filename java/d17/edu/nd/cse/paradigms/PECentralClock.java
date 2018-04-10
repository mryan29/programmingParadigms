package edu.nd.cse.paradigms;

public class PECentralClock extends TimerTask
{
	protected int rate;
	

	public PECentralClock(PEEngine engine, int rate)
	{
	
		engine.tick();
		this.rate = rate;
	}
	
	public void run()
	{
		engine.tick();
	}

}