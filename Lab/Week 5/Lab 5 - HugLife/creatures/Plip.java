package creatures;

import huglife.Creature;
import huglife.Direction;
import huglife.Action;
import huglife.Occupant;

import java.awt.Color;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Map;

import static huglife.HugLifeUtils.randomEntry;

/**
 * An implementation of a motile pacifist photosynthesizer.
 *
 * @author Josh Hug
 */
public class Plip extends Creature {

    /**
     * red color.
     */
    private int r;
    /**
     * green color.
     */
    private int g;
    /**
     * blue color.
     */
    private int b;

    /**
     * probability of taking a move when adjacent empty space available.
     */
    private double moveProbability = 0.5;

    /**
     * creates plip with energy equal to E.
     */
    public Plip(double e) {
        super("plip");
        r = 0;
        g = 0;
        b = 0;
        energy = e;
    }

    /**
     * creates a plip with energy equal to 1.
     */
    public Plip() {
        this(1);
    }

    /**
     * Should return a color with red = 99, blue = 76, and green that varies
     * linearly based on the energy of the Plip. If the plip has zero energy,
     * it should have a green value of 63. If it has max energy, it should
     * have a green value of 255. The green value should vary with energy
     * linearly in between these two extremes. It's not absolutely vital
     * that you get this exactly correct.
     */
    public Color color() {
        g = 63;
        int green = (int) Math.round((96 * energy) + g);
        return color(99, green, 76);
    }

    /**
     * Do nothing with C, Plips are pacifists.
     */
    public void attack(Creature c) {
        // do nothing.
    }

    /**
     * Plips should lose 0.15 units of energy when moving. If you want to
     * to avoid the magic number warning, you'll need to make a
     * private static final variable. This is not required for this lab.
     */
    public void move() {
        // TODO
        this.energy -= 0.15;
        if (this.energy < 0) {
            this.energy = 0;
        }
    }


    /**
     * Plips gain 0.2 energy when staying due to photosynthesis.
     */
    public void stay() {
        // TODO
        this.energy += 0.2;
        if (this.energy > 2) {
            this.energy = 2;
        }
    }

    /**
     * Plips and their offspring each get 50% of the energy, with none
     * lost to the process. Now that's efficiency! Returns a baby
     * Plip.
     */
    public Plip replicate() {
        energy = energy / 2;
        return new Plip(energy);
    }

    /**
     * Plips take exactly the following actions based on NEIGHBORS:
     * 1. If no empty adjacent spaces, STAY.
     * 2. Otherwise, if energy >= 1, REPLICATE towards an empty direction
     * chosen at random.
     * 3. Otherwise, if any Cloruses, MOVE with 50% probability,
     * towards an empty direction chosen at random.
     * 4. Otherwise, if nothing else, STAY
     * <p>
     * Returns an object of type Action. See Action.java for the
     * scoop on how Actions work. See SampleCreature.chooseAction()
     * for an example to follow.
     */
    public Action chooseAction(Map<Direction, Occupant> neighbors) {
        // Rule 1
        /**
         * emptyNeighbors is a deque that will contain the empty neighbors,
         * if any.
         */
        Deque<Direction> emptyNeighbors = new ArrayDeque<>();
        /**
         * anyCLorus is an indicator whether there's any clorus present
         * adjacent to the plip
         */
        boolean anyClorus = false;
        // TODO
        // (Google: Enhanced for-loop over keys of NEIGHBORS?)
        // for () {...}

        /**
         * neighbor is a map of direction:occupant. We get the keys and loop
         * through them to get the names. If the name is empty, add that
         * direction (key) to the deque. If the name is clorus, then
         * change anyClorus to true
         */
        for (Direction key: neighbors.keySet()) {
            if (neighbors.get(key).name().equals("empty")) {
                emptyNeighbors.addLast(key);
            } else if (neighbors.get(key).name().equals("clorus")) {
                anyClorus = true;
            }
        }

        if (emptyNeighbors.isEmpty()) { // FIXME
            // TODO
            return new Action(Action.ActionType.STAY);
        } else if (energy >= 1.0) {
            // Rule 2
            // HINT: randomEntry(emptyNeighbors)
            return new Action(Action.ActionType.REPLICATE, randomEntry(emptyNeighbors));
        } else if (anyClorus && Math.random() < moveProbability) {
            // Rule 3
            return new Action(Action.ActionType.MOVE, randomEntry(emptyNeighbors));
        } else {
            // Rule 4
            return new Action(Action.ActionType.STAY);
        }
    }
}
