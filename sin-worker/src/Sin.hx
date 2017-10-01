import haxe.Timer;

import net.rezmason.utils.workers.Golem;

using NumberTools;

class Sin {

    public function new() {
        trace('Sin');

        // Array of frequencies
        var frequency = [425.0, 200.0, 500.0, 340.0, 100.0, 50.0, 400.0];

        // Create the AudioPlayer
        var audio = AudioPlayer.create();

        // Create the AudioWorker
        var worker = AudioWorker
            .create(Golem.rise('../hxml/SinWorker.hxml'), audio.bufferSamples, audio.sampleRate)
            .requestBufferUsing((position) -> frequency[position % frequency.length])
            .start();
        
        // Play the resulting buffers in an AudioPlayer
        audio
            .useGenerator(worker.generator)
            .play();

        // Stop it after 5 seconds
        Timer.delay(() -> {
            worker.stop();
            audio.stop();
        }, DateTools.seconds(5).int());
    }

    // Main entry point
    static public function main() {
        new Sin();
    }
}