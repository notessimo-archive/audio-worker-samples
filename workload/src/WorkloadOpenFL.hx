import openfl.display.Sprite;

class WorkloadOpenFL extends Sprite {
    
    public function new() {
        super();

        trace('Workload');

        new Workload();
    }
}