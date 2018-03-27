import java.util.List;
import java.util.ArrayList;

public class MyDyn
{
	public void start()
	{
		ArrayList<Bird> al = new ArrayList<Bird>();
		BirdProcess bp = new EatingBirds();

		Duck donald = new Duck();
		Eagle baldy = new Eagle();

		al.add(donald);
		al.add(baldy);

		for(Bird b: al)
		{
			bp.processBird(b);
		}
	}
}

