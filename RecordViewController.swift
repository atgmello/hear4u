//
//  RecordViewController.swift
//  Hear4uApp
//
//  Created by Student on 13/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getAudioURL(fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    func startRecording() {
        // TODO
        // GET FILE NAME FROM UITEXTFIELD
        var fileName = "name.m4a"
        
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        recordButton.setTitle("Tap to Stop", for: .normal)
        
        let audioURL = RecordViewController.getAudioURL(fileName: fileName)
        print(audioURL.absoluteString)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            soundRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            soundRecorder.delegate = self
            soundRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        soundRecorder.stop()
        soundRecorder = nil
        
        if success {
            recordButton.setTitle("Gravar novamente", for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            recordButton.setTitle("Iniciar gravação", for: .normal)
            
            let ac = UIAlertController(title: "Falha", message: "There was a problem recording your whistle; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    var player: AVAudioPlayer?
    
    func playSound(fileName: String) {
        print("Entered play sound")
        
        let url = RecordViewController.getAudioURL(fileName: fileName)
            
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            print("Playing sound now!")
            print(url.absoluteString)
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    @objc func recordTapped() {
        print("Tapped record")
        if soundRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @objc func nextTapped() {
        
    }
    
    @objc func playTapped() {
        print("Tapped play")
        // TODO
        // GET FILE NAME FROM UITEXTFIELD
        var fileName = "sound.m4a"
        playSound(fileName: fileName)
    }

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var messageTextField: UITextField!

    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var recordButtonInfo: UIButton!
    
    var recordingSession: AVAudioSession!
    var soundRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)

        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)

        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
        
    }
    

    func loadRecordingUI() {
        recordButton.setTitle("Iniciar gravação", for: .normal)
        playButton.setTitle("Tocar gravação", for: .normal)
    }
    
    func loadFailUI() {
//        StatusLabel.font = UIFont.preferredFont(forTextStyle: .headline)
//        StatusLabel.text = "Recording failed: please ensure the app has access to your microphone."
        statusLabel.text = "Impossível gravar: por favor certifique-se de que o aplicativo tem acesso ao seu microfone."
        statusLabel.numberOfLines = 0
        recordButton.setTitle("Falha", for: .normal)
        playButton.setTitle("Falha", for: .normal)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
