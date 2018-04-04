import edu.nd.cse.paradigms.*;

public class Enemy extends PESquare
{
	private int x_rate = 1;
	public int lives = 2;

	public Enemy()
	{
		super();
	}

	public void tick()
	{
		this.x += this.x_rate;

		if (x >= 640)
			this.x_rate = -1;
	}

	public void setLives(int lives)
	{
		this.lives = lives;
	}

	public int getLives()
	{
		return this.lives;
	}

}
