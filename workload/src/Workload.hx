import haxe.Timer;

import net.rezmason.utils.workers.Golem;

using NumberTools;

class Workload {

    public function new() {
        trace('Workload');

        playSin();
        //playNoise();
    }

    function playSin() {
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

        // Stop it after 3 seconds
        Timer.delay(() -> {
            worker.stop();
            audio.stop();
        }, DateTools.seconds(5).int());
    }

    function playNoise() {
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
        new Workload();
    }
}