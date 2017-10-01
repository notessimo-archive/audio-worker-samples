import haxe.io.Float32Array;

import net.rezmason.utils.workers.BasicWorker;

class NoiseWorker extends BasicWorker<AudioWorkerParams<Void>, Float32Array> {

    override function process( params : AudioWorkerParams<Void> ) {
        var buffer : Float32Array = new Float32Array( params.samples << 1 );

        for( i in 0...params.samples ) {
            
            // Unnecessary heavy load noise
            var noise = 0.0;
            var sign = Math.random() < 0.5 ? -1 : 1;
            var n = 1000;
            for( j in 0...n ) noise += sign * Math.random() / n;
            noise = noise > 1 ? 1 : noise < 0 ? 0 : noise;

            buffer.set(i << 1, noise); // Left
            buffer.set(i << 1 + 1, noise); // Right
        }

        return buffer;
    }
}