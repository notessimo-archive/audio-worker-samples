import openfl.display.Sprite;

class SinOpenFL extends Sprite {
    
    public function new() {
        super();

        trace('Sin');

        new Sin();

        // Animate something
        var circle = new Sprite();
        circle.graphics.beginFill(0xFF0000);
        circle.graphics.drawCircle(0, 0, 100);
        circle.graphics.endFill();
        addChild(circle);

        var speed = 200.0;
        var lastTimer = Date.now().getTime();
        addEventListener(Event.ENTER_FRAME, (_) -> {
            var delta = (Date.now().getTime() - lastTimer) / 1000.0;
            lastTimer = Date.now().getTime();

            circle.y = circle.x += delta * speed;
            if( circle.x > 200 || circle.x < 0 ) speed *= -1;
        });
    }
}