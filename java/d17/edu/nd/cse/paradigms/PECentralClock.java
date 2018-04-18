package edu.nd.cse.paradigms;

public class PECentralClock extends TimerTask
{
	protected int rate;
	//protected PEEngine engine;
	protected PEEngine myEngine;

	public PECentralClock(PEEngine engine, int rate)
	{
		//this.engine = engine;
		myEngine = engine;
		//this.rate = rate;
		//Timer time = new Timer(true);
		//time.scheduleAtFixedRate(this, 0, rate);
	}
	
	public void run()
	{
		myEngine.tick();
	}

}