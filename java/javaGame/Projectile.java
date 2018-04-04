import edu.nd.cse.paradigms.*;

public class Projectile extends PECircle
{
	private int x_rate	= 1;
	private int y_rate	= 1;
	private int enemy_x;
	private int enemy_y;

	// y = m*x + b
	// m = enemy_y - this.y / enemy_x - this.x


	public Projectile(Enemy enemy)
	{
		super();
		enemy_x	= enemy.getX();
		enemy_y = enemy.getY();
		//x_rate = enemy_x - this.x;
		//y_rate = enemy_y - this.y;

	}

	public void tick()
	{
		this.x	+= this.x_rate;
		this.y	+= this.y_rate;

	}
}
