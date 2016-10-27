//
//  ViewController.swift
//  SpeechRecognitionDemo
//
//  Created by Upendar Gareri on 27/10/2016.
//  Copyright © 2016 Upendar Gareri. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class MainVC: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var speechTextview: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer.stop()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let url = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        self.audioPlayer.delegate = self
                        self.audioPlayer.play()
                    } catch {
                        print("Error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: url)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                            self.speechTextview.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        requestSpeechAuth()
    }
    
    
    
}

