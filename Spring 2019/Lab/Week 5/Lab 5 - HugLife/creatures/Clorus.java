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

public class Clorus extends Creature {
    private int r;
    private int g;
    private int b;

    public Clorus(double e){
        super("clorus");
        r = 0;
        g = 0;
        b = 0;
        energy = e;
    }

    public Color color() {
        return color(34, 0, 231);
    }

    public void attack(Creature c) {
        energy += c.energy();
    }

    public void move() {
        energy -= 0.03;
    }

    public void stay() {
        energy -= 0.01;
    }

    public Clorus replicate() {
        energy = energy / 2;
        return new Clorus(energy);
    }

    public Action chooseAction(Map<Direction, Occupant> neighbors) {
        Deque<Direction> emptyNeighbors = new ArrayDeque<>();
        Deque<Direction> plipNeighbors = new ArrayDeque<>();
        boolean anyPlip = false;
        for (Direction key: neighbors.keySet()) {
            if (neighbors.get(key).name().equals("empty")) {
                emptyNeighbors.addLast(key);
            } else if (neighbors.get(key).name().equals("plip")) {
                plipNeighbors.addLast(key);
                anyPlip = true;
            }
        }

        if (anyPlip) {
            return new Action(Action.ActionType.ATTACK, randomEntry(plipNeighbors));
        } else if (emptyNeighbors.isEmpty()) {
            return new Action(Action.ActionType.STAY);
        } else if (energy >= 1) {
            return new Action(Action.ActionType.REPLICATE, randomEntry(emptyNeighbors));
        } else {
            return new Action(Action.ActionType.MOVE, randomEntry(emptyNeighbors));
        }
    }
}
