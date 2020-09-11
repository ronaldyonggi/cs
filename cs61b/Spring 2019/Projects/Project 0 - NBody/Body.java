
/**
 * A class that represents a matter in the universe.
 *
 * @author Ronald Yonggi
 */
public class Body {
    /**
     * Instance variables
     */
    public double xxPos; // Body's x position
    public double yyPos; // Body's y position
    public double xxVel; // Body's current velocity int the x direction
    public double yyVel; // Body's current velocity in the y direction
    public double mass; // Body's mass
    public String imgFileName; // image filename that depicts the Body object
    public static double G = 6.67e-11; // Gravitational constant

    /**
     * Body instance constructor
     * @param xP the Body's x-directional position
     * @param yP the Body's y-directional position
     * @param xV the Body's current velocity in x-direction
     * @param yV the Body's current velocity in y-direction
     * @param m the Body's mass
     * @param img the image filename that depicts the Body object
     */
    public Body(double xP, double yP, double xV, double yV, double m, String img) {
        xxPos = xP;
        yyPos = yP;
        xxVel = xV;
        yyVel = yV;
        mass = m;
        imgFileName = img;
    }
    
    // Body constructor 2, creates a copy of an existing Body object

    /**
     * Body instance deep copy construcotr, creates a copy of an existing Body object
     * @param b a Body object whose attribute to be copied
     */
    public Body (Body b) {
        xxPos = b.xxPos;
        yyPos = b.yyPos;
        xxVel = b.xxVel;
        yyVel = b.yyVel;
        mass = b.mass;
        imgFileName = b.imgFileName;
    }

    /**
     * Calculates the distance between 2 Bodies
     * @param b the Body whose distance to be calculated with
     * @return the distance between Bodies (double)
     */
    public double calcDistance(Body b){
        // Note that the calculation works in terms of how 'b' exerts force on "this"
        double dx = b.xxPos - xxPos; // Calculates dx
        double dy = b.yyPos - yyPos; // Calculates dy
        double r = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2)); // Distance between 'b' and 'this'
        return r;
    }


    /**
     * Calculates the Force exerted by a Body
     * @param b the Body that's exerting Force
     * @return the Force exerted by the Body b (double)
     */
    public double calcForceExertedBy (Body b) {
        double r = this.calcDistance(b); // Calculates r using calcDistance method
        double F = G * mass * b.mass  / Math.pow(r, 2); // Calculates F, the force exerted by b to 'this'
        return F;
    }


    /**
     * Calculates the x-directional Force exerted by a Body
     * @param b the Body that exerts the x-directional Force
     * @return x-directional Force exerted by the Body b (double)
     */
    public double calcForceExertedByX (Body b) {
        double F = this.calcForceExertedBy(b); // Calculates F
        double r = this.calcDistance(b); // Calculates r
        double dx = b.xxPos - xxPos; // Calculates dx
        return F * dx / r;
    }

    /**
     * Calculates the y-directional Force exerted by a Body
     * @param b the Body that exerts the y-directional Force
     * @return y-directional Force exerted by the Body b (double
     */
    public double calcForceExertedByY (Body b) {
        double F = this.calcForceExertedBy(b); // Calculates F
        double r = this.calcDistance(b); // Calculates r
        double dy = b.yyPos - yyPos; // Calculates dy
        return F * dy / r;
    }

    // Calculates the net Force exerted by input body to 'this' body in x-direction

    /**
     * Calculates the net Force exerted by multiple bodies in x-direction
     * @param bodies an array of bodies
     * @return net Force exerted by multiple bodies in x-direction (double)
     */
    public double calcNetForceExertedByX(Body[] bodies) {
        double Fnetx = 0 ; // Net Force on x-direction so far
        for (Body b : bodies) { // Iterate through each Body in bodies. This is an enhanced for loop
            if (this.equals(b)) continue; // If b is the same as 'this', don't include it in the calculation!
            Fnetx += calcForceExertedByX(b); // Otherwise, increment Fnetx by the result of calculating calcForceExertedByX on the currently selected Body
        }
        return Fnetx;
    }


    /**
     * Calcuates the net Force exerted by multiple bodies in y-direction
     * @param bodies an array of bodies
     * @return net Force exerted by multiple bodies in y-direction (double)
     */
    public double calcNetForceExertedByY(Body[] bodies) {
        double Fnety = 0 ; // Net Force on y-direction so far
        for (Body b : bodies) { // Iterate through each Body in bodies. This is an enhanced for loop
            if (this.equals(b)) continue; // If b is the same as 'this', don't include it in the calculation!
            Fnety += calcForceExertedByY(b); // Otherwise, increment Fnety by the result of calculating calcForceExertedByX on the currently selected Body
        }
        return Fnety;
    }

    // Updates a body's position and velocity instance variables

    /**
     * Updates self's position and velocity instance variable
     * @param dt the time increment between previous state and the current state (double)
     * @param fx net Force exerted by outside Bodies in x-direction (double)
     * @param fy net Force exerted by outside Bodies in y-direction
     */
    public void update(double dt, double fx, double fy){
        /* dt is the amount of time elapsed / used
        fx is the amount of force exerted in x-direction
        fy is the amount of force exerted in y-direction */
        // Calculate accelerations
        double ax = fx / mass; // x-direction acceleration
        double ay = fy / mass; // y-direction acceleration
        // Calculate new velocities
        double vnewx = xxVel + dt * ax; // x-direction new velocity
        double vnewy = yyVel + dt * ay; // y-direction new velocity
        // Calculate new positions
        double pnewx = xxPos + dt * vnewx; // x-direction new position
        double pnewy = yyPos + dt * vnewy; // y-direction new position

        // Update instance variables
        xxPos = pnewx; // Updates x-position
        yyPos = pnewy; // Updates y-position
        xxVel = vnewx; // Updates x-velocity
        yyVel = vnewy; // Updates y-velocity
    }

    /**
     * Draw self's image depiction
     */
    public void draw() {
        // BEWARE! The image files are located inside the 'images' directory! We can't just call it
        // with 'imgFilename', we need to include the directory as well.
        StdDraw.picture(xxPos, yyPos, "./images/" + imgFileName);
    }
}