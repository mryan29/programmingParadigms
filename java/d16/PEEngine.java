public class PEEngine extends Frame
{
	protected PEGame game;
	protected PEScreen screen;
	protected int width = 640;
	protected int height = 480;
	protected int titlebarHeight = 0; // varies by OS

	public PEEngine(PEGame game)
	{
		screen = new PEScreen(width, height);
		this.game = game;

		// your code here!
	}

	public void paint(Graphics g)
	{
		g.drawImage(screen.render(), 0, titlebarHeight, width, height, Color.BLACK, null);
	}
}
