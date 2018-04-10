import edu.nd.cse.paradigms.*;

class CoolSquare extends PESquare
{
	private int x_rate = 1;
	private int y_rate = 1;

	public void tick()
	{
		this.x += this.x_rate;
		this.y += this.y_rate;
	}
}

