/**
 * The NBody class runs the simulation
 *
 * @author Ronald Yonggi
 */
public class NBody{

    /**
     * Takes in a universe .txt data and reads the second number that corresponds to radius of universe
     * @param filename the filepath to a universe .txt data
     * @return the radius of the universe that corresponds to the filename (double)
     */
    public static double readRadius(String filename) {
        In in = new In(filename); // Read the 'finename' and assign it to 'in'
        in.readInt(); // Read the first number, but destroy it right away since it's not needed
        double secondItemInFile = in.readDouble(); // Read the second number, this is what we want
        return secondItemInFile; 
    }

    /**
     * Takes in a universe .txt data and reads the bodies within
     * @param filename the filepath to a universe .txt data
     * @return an array containing bodies that is contained within the filename.txt
     */
    public static Body[] readBodies(String filename) {
        In in = new In(filename); // Read the 'filename' and assign it to 'in'
        int N = in.readInt(); // Read the first number in the .txt file. USE THIS NUMBER to determine the length of the array
        Body[] bodies = new Body[N]; // Create an array that stores reference to bodies. The length depends on the first text read above
        in.readDouble(); // Read the second number in the .txt file, and discard it right away
        for (int i = 0; i < N; i++) { // Iterate from 0 to N (the number of planets)
            double xPos = in.readDouble(); // Read the body's x-coordinate of initial position
            double yPos = in.readDouble(); // Read the body's y-coordinate of initial position
            double xVel = in.readDouble(); // Read the body's x-coordinate of initial velocity
            double yVel = in.readDouble(); // Read the body's y-coordinate of initial velocity
            double mass = in.readDouble(); // Read the body's mass
            String img = in.readString();  // Read the body's image file
            Body b = new Body(xPos, yPos, xVel, yVel, mass, img); // Use the Body constructor to create a body b
            bodies[i] = b; //Assign b to the array bodies at index i
        }
        return bodies; // Return the bodies array
    }

    /**
     * Main method
     * @param args command line arguments:
     * 0th argument corresponds to the time length of simulation
     * 1st argument corresponds to the time increment for simulation frame
     * 2nd argument corresponds to the filename path
     */
    public static void main(String[] args) {
        // Recall Lecture 2 Video 4, the command line arguments are indexed starting from 0
        double T = Double.parseDouble(args[0]); // Read the 0th argument and store in T
        double dt = Double.parseDouble(args[1]); // Read the 1st argument and store in dt
        String filename = args[2]; // Read the 2nd argument and store in 'filename'
        Body[] bodies = NBody.readBodies(filename); // Get the array of bodies from filename
        double radius = NBody.readRadius(filename); // Get the radius of the universe from filename
        int N = bodies.length; // The number of bodies currently present

        // Loop through time
        for (int time = 0; time <= T; time += dt) {
            double[] xForces = new double[N];
            double[] yForces = new double[N];
            // Calculate all the xForces and yForces first before updating bodies 
            for (int i = 0; i < N; i++) {
                xForces[i] = bodies[i].calcNetForceExertedByX(bodies); // Update each xForce
                yForces[i] = bodies[i].calcNetForceExertedByY(bodies); // Update each yForce
            }
            //Now update each of the bodies
            for (int i = 0; i < N; i ++){
                bodies[i].update(time, xForces[i], yForces[i]);
            }

            // Draw background and each body.
            String backgroundImage = "images/starfield.jpg"; // Contains path to background image file
            StdDraw.enableDoubleBuffering(); // Enables double buffering (all drawing will take place on the offscreen canvas)
            StdDraw.setScale(-radius, radius); // Sets up universe so it goes from -radius, -radius to radius, radius
            StdDraw.clear(); // Clears the drawing window
            StdDraw.picture(0, 0, backgroundImage); // Stamp a copy of backgroundImage.png  
            for (Body b: bodies) {b.draw();} // Draw each body
            StdDraw.show(); // Show the offscreen buffer
            StdDraw.pause(10); // Pause animation for 10 milliseconds
        }

    }

}