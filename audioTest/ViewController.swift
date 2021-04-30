//import UIKit
//import AVFoundation
//import CoreMotion
//
//func delay(delay:Double, closure: @escaping ()->()) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//        closure()
//    }
//}
//
//func radToDeg(rad:Double) -> Float {
//    return Float(rad * 180.0 / .pi)
//}
//
//class ViewController: UIViewController {
//    let engine = AVAudioEngine()
//    let motionManager = CMHeadphoneMotionManager()
//    let environment = AVAudioEnvironmentNode()
//
//    @IBOutlet weak var yawLabel: UILabel!
//    @IBOutlet weak var pitchLabel: UILabel!
//    @IBOutlet weak var rollLabel: UILabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if motionManager.isDeviceMotionAvailable {
//            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
//                if let data = data {
//                    // YAW: goes from -PI to PI
//                    // When phone is sitting on a table:
//                    //      0: Due West
//                    //      -PI/PI: due East
//                    //      -PI/2: due North
//                    //      PI/2: due South
//
//                    // Audio XYZ coordinates
//                    //  Z-axis: East-West (-Z = West)
//                    //  X-axis: North-South (+X = North)
//                    //  Y-axis: Top-Bottom (+Y = Up)
//
//                    self.rollLabel.text = data.attitude.roll.description
//                    self.pitchLabel.text = data.attitude.pitch.description
//
//                    let roll = radToDeg(rad: data.attitude.roll)
//                    let pitch = radToDeg(rad: data.attitude.pitch)
//                    let yaw = radToDeg(rad: data.attitude.yaw)
//                    self.yawLabel.text = yaw.description
//
//                    self.environment.listenerAngularOrientation = AVAudioMake3DAngularOrientation(yaw, 0, 0)
//                } else {
//                    print(error)
//                }
//            }
//        }
//
//
//        environment.listenerPosition = AVAudio3DPoint(x: 0, y: 0, z: 0)
//        environment.listenerAngularOrientation = AVAudioMake3DAngularOrientation(0.0, 0, 0)
//
//        engine.attach(environment)
//
//
//        let reverbParameters = environment.reverbParameters
//        reverbParameters.enable = true
//        reverbParameters.loadFactoryReverbPreset(.largeHall)
//
//        let westNode = self.playSound(file: "1", withExtension: "m4a", atPosition: AVAudio3DPoint(x: 0, y: 0, z: 10))
//        //        let eastNode = self.playSound(file: "beep-g", atPosition: AVAudio3DPoint(x: 0, y: 0, z: -10))
//        //        let northNode = self.playSound(file: "beep-e", atPosition: AVAudio3DPoint(x: 10, y: 0, z: 0))
//        //        let southNode = self.playSound(file: "beep-bb", atPosition: AVAudio3DPoint(x: -10, y: 0, z: 0))
//        //        let nodes = [westNode, eastNode, northNode, southNode]
//        let nodes = [westNode]
//
//        engine.connect(environment, to: engine.mainMixerNode, format: nil)
//        engine.prepare()
//
//        do {
//            try engine.start()
//            nodes.map({ $0.play() })
//            print("Started")
//        } catch let e as NSError {
//            print("Couldn't start engine", e)
//        }
//    }
//
//    func playSound(file:String, withExtension ext:String = "wav", atPosition position:AVAudio3DPoint) -> AVAudioPlayerNode {
//        let node = AVAudioPlayerNode()
//        node.position = position
//        node.reverbBlend = 0.1
//        node.renderingAlgorithm = .HRTF
//
//        let url = Bundle.main.url(forResource: file, withExtension: ext)!
//        let file = try! AVAudioFile(forReading: url)
//        let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length))!
//        try! file.read(into: buffer)
//        engine.attach(node)
//        engine.connect(node, to: environment, format: buffer.format)
//        node.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
//
//        return node
//    }
//}


import UIKit
import AVFoundation
import CoreMotion

func delay(delay:Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

func radToDeg(rad:Double) -> Float {
    return Float(rad * 180.0 / M_PI)
}

class ViewController: UIViewController {
    let engine = AVAudioEngine()
    let motionManager = CMMotionManager()
    let environment = AVAudioEnvironmentNode()

    @IBOutlet weak var yawLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var rollLabel: UILabel!

    let player = AudioPlayerWithHead()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.play()
//
//        if motionManager.isDeviceMotionAvailable {
//            motionManager.deviceMotionUpdateInterval = 0.01
//            motionManager.startDeviceMotionUpdates(
//                using: .xTrueNorthZVertical,
//                to: .main) { (data, error) in
//
//                if let data = data {
//
//                    // YAW: goes from -PI to PI
//                    // When phone is sitting on a table:
//                    //      0: Due West
//                    //      -PI/PI: due East
//                    //      -PI/2: due North
//                    //      PI/2: due South
//
//                    // Audio XYZ coordinates
//                    //  Z-axis: East-West (-Z = West)
//                    //  X-axis: North-South (+X = North)
//                    //  Y-axis: Top-Bottom (+Y = Up)
//
//                    let yaw = radToDeg(rad: data.attitude.yaw)
//                    let roll = radToDeg(rad: data.attitude.roll)
//                    let pitch = radToDeg(rad: data.attitude.pitch)
//
//                    self.rollLabel.text = "roll deg: \(roll.description) rad: \(data.attitude.roll)"
//                    self.pitchLabel.text = "pitch: \(pitch.description) rad: \(data.attitude.pitch)"
//                    self.yawLabel.text = "yaw: \(yaw.description) rad: \(data.attitude.yaw)"
//
//                    self.environment.listenerAngularOrientation = AVAudioMake3DAngularOrientation(yaw, 0, 0)
//                } else {
//                    print(error)
//                }
//            }
//        }
//
//
//        let reverbParameters = environment.reverbParameters
//        reverbParameters.enable = true
//        reverbParameters.loadFactoryReverbPreset(.largeHall)
//
//        environment.listenerPosition = AVAudio3DPoint(x: 0, y: 0, z: 0)
//        environment.listenerAngularOrientation = AVAudioMake3DAngularOrientation(0.0, 0, 0)
//
//        engine.attach(environment)
//
//
//
//        let westNode = self.playSound(file: "1", withExtension: "ac3", atPosition: AVAudio3DPoint(x: 0, y: 0, z: 10))
////        let eastNode = self.playSound(file: "beep-g", atPosition: AVAudio3DPoint(x: 0, y: 0, z: -10))
////        let northNode = self.playSound(file: "beep-e", atPosition: AVAudio3DPoint(x: 10, y: 0, z: 0))
////        let southNode = self.playSound(file: "beep-bb", atPosition: AVAudio3DPoint(x: -10, y: 0, z: 0))
//        // let nodes = [eastNode, northNode, southNode]
//         let nodes = [westNode]
//
//        let stereoFormat =  AVAudioFormat(standardFormatWithSampleRate: self.engine.outputNode.outputFormat(forBus: 0).sampleRate, channels: 2)
//        engine.connect(environment, to: engine.mainMixerNode, format: nil)
//        engine.prepare()
//
//        do {
//            try engine.start()
//            nodes.forEach({ $0.play() })
//            print("Started")
//        } catch let e as NSError {
//            print("Couldn't start engine", e)
//        }
    }

    func playSound(file:String, withExtension ext:String = "wav", atPosition position:AVAudio3DPoint) -> AVAudioPlayerNode {
        let node = AVAudioPlayerNode()
        node.position = position
        node.reverbBlend = 0.1
        node.renderingAlgorithm = .HRTF

        let url = Bundle.main.url(forResource: file, withExtension: ext)!
        let file = try! AVAudioFile(forReading: url)
        let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length))!
        try! file.read(into: buffer)
        engine.attach(node)
        engine.connect(node, to: environment, format: buffer.format)
        node.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)

        return node
    }
}

final class AudioPlayerWithGyro {
    let audioEngine = AVAudioEngine()
    let environment = AVAudioEnvironmentNode()
    let player = AVAudioPlayerNode()
    let motionManager = CMMotionManager()
    
    func track() {
        if motionManager.isDeviceMotionAvailable {
                    motionManager.deviceMotionUpdateInterval = 0.01
                    motionManager.startDeviceMotionUpdates(
                        using: .xTrueNorthZVertical,
                        to: .main) { (data, error) in
        
                        if let data = data {
                            let yaw = radToDeg(rad: data.attitude.yaw)
                            let roll = radToDeg(rad: data.attitude.roll)
                            let pitch = radToDeg(rad: data.attitude.pitch)
        
                            self.environment.listenerAngularOrientation = AVAudioMake3DAngularOrientation(yaw, pitch, roll)
                        } else {
                            print(error)
                        }
                    }
                }
    }
    
    func play() {
        
        track()
        let url = Bundle.main.url(forResource: "1", withExtension: "m4a")!
        do {
            environment.outputType = .auto
            audioEngine.attach(environment)
            
            player.renderingAlgorithm = .auto
            player.sourceMode = .ambienceBed
            
            let audioFile = try AVAudioFile(forReading: url)
            guard let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: .init(audioFile.length)) else { return }
            try audioFile.read(into: buffer)
            audioEngine.attach(player)
            audioEngine.connect(player, to: environment, format: buffer.format)
            audioEngine.connect(environment, to: audioEngine.mainMixerNode, format: buffer.format)
            try audioEngine.start()
            player.play()
            player.scheduleBuffer(buffer, at: nil, options: .loops)
            
        } catch {
            print(error)
        }
    }
}


final class AudioPlayerWithHead {
    let audioEngine = AVAudioEngine()
    let environment = AVAudioEnvironmentNode()
    let player = AVAudioPlayerNode()
    let motionManager = CMHeadphoneMotionManager()
    
    func track() {
        if motionManager.isDeviceMotionAvailable {
                        motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                        if let data = data {
                            let yaw = radToDeg(rad: data.attitude.yaw)
                            let roll = radToDeg(rad: data.attitude.roll)
                            let pitch = radToDeg(rad: data.attitude.pitch)
        
                            self.environment.listenerAngularOrientation = AVAudioMake3DAngularOrientation(yaw, pitch, roll)
                        } else {
                            print(error)
                        }
                    }
                }
    }
    
    func play() {
        
        track()
        let url = Bundle.main.url(forResource: "1", withExtension: "ac3")!
        do {
            environment.outputType = .auto
            audioEngine.attach(environment)
            
            player.renderingAlgorithm = .auto
            player.sourceMode = .ambienceBed
            
            let audioFile = try AVAudioFile(forReading: url)
            guard let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: .init(audioFile.length)) else { return }
            try audioFile.read(into: buffer)
            audioEngine.attach(player)
            audioEngine.connect(player, to: environment, format: buffer.format)
            audioEngine.connect(environment, to: audioEngine.mainMixerNode, format: buffer.format)
            try audioEngine.start()
            player.play()
            player.scheduleBuffer(buffer, at: nil, options: .loops)
            
        } catch {
            print(error)
        }
    }
}
