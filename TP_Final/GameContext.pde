public class GameContext {

  private State gameState;

  public void setState(State state) {
    this.gameState = state;
  }

  public State getState() {
    return this.gameState;
  }
}