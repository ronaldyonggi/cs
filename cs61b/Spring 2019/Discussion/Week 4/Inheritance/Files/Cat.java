public class Cat extends Animal{
    public Cat (String name, int age) {
        this.name = name;
        this.age = age;
        this.noise = "Meow!";
    }

    @Override
    public void greet() {
        System.out.println("Cat " + name + " says: " + makeNoise());
    }
}
