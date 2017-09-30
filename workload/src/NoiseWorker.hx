import haxe.io.Float32Array;

import net.rezmason.utils.workers.BasicWorker;

class NoiseWorker extends BasicWorker<AudioWorkerParams<Void>, Float32Array> {

    override function process( params : AudioWorkerParams<Void> ) {
        var buffer : Float32Array = new Float32Array( params.samples << 1 );

        for( i in 0...params.samples ) {
            var noise = Math.random() * 2 - 1;
            buffer.set(i << 1, noise); // Left
            buffer.set(i << 1 + 1, noise); // Right
        }

        return buffer;
    }
}