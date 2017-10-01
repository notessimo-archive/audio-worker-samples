import haxe.io.Float32Array;

import net.rezmason.utils.workers.BasicWorker;

class SinWorker extends BasicWorker<AudioWorkerParams<Float>, Float32Array> {

    var n = 0;

    override function process( params : AudioWorkerParams<Float> ) {
        var buffer : Float32Array = new Float32Array( params.samples << 1 );

        var volume = 0.25;
        for( i in 0...params.samples ) {
            var sin = MathUtils.sin(2 * MathUtils.PI * n++ * params.data / params.sampleRate) * volume;
            buffer.set(i << 1, sin); // Left
            buffer.set(i << 1 + 1, sin); // Right
        }

        return buffer;
    }
}