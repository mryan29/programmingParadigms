package paradigms;

import java.lang.Math;

public class Sphere
{
	private double radius; // want to protect from being modified by any objects, only visible w/i this	class
							// **encapsulation** module behaves independently of other things
//	public static double PI;	// static variable is one which is consisten across all instantiations of thatcls
								// if changed in one object, will be reflected in every instance of tht clsss
	public Sphere(double radius){
		this.radius = radius;
	}

	public double getRadius()
	{
		return this.radius; // keyword which refers to current object
							// when i call this method, will return this objects radius
							// example of being object oriented program
	}

	public void setRadius(double radius)
	{
		this.radius = radius; // set member variable radius (this.radius initialized above) to given parameter)
	}

	public double getVolume()
	{
		double vol = (4/3.0) * Math.PI * Math.pow(this.radius,3);	// using java math library
		return vol;
	}

	public double getSurfaceArea()
	{
		double sa = 4 * Math.PI * Math.pow(this.radius,2);
		return sa;
	}

	public String toString()
	{
		String out = String.format("Radius:\t\t%.1f\nVolume:\t\t%.13f\nSurface Area:\t%.13f\n", this.radius, 
		getVolume(), getSurfaceArea());
		return out;
	}
}
