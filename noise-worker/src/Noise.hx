import haxe.Timer;

import net.rezmason.utils.workers.Golem;

using NumberTools;

class Noise {

    public function new() {
        trace('Noise');

        // Create the AudioPlayer
        var audio = AudioPlayer.create();

        // Create the AudioWorker
        var worker = AudioWorker
            .create(Golem.rise('../hxml/NoiseWorker.hxml'), audio.bufferSamples, audio.sampleRate)
            .start();
        
        // Play the resulting buffers in an AudioPlayer
        audio
            .useGenerator(worker.generator)
            .play();

        // Stop it after 3 seconds
        Timer.delay(() -> {
            worker.stop();
            audio.stop();
        }, DateTools.seconds(3).int());
    }

    // Main entry point
    static public function main() {
        new Noise();
    }
}