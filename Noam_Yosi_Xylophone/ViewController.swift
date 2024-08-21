//
//  ViewController.swift
//  Noam_Yosi_Xylophone
//
//  Created by nir nir on 16/08/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var noteB: UIImageView!
    @IBOutlet weak var noteA: UIImageView!
    @IBOutlet weak var noteG: UIImageView!
    @IBOutlet weak var noteF: UIImageView!
    @IBOutlet weak var noteE: UIImageView!
    @IBOutlet weak var noteD: UIImageView!
    @IBOutlet weak var noteC: UIImageView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add tap gesture recognizers to each note image
        let notes = [noteB, noteA, noteG, noteF, noteE, noteD, noteC]
        
        for note in notes {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(noteTapped(_:)))
            note?.isUserInteractionEnabled = true
            note?.addGestureRecognizer(tapRecognizer)
        }
    }
    
    // Function to handle the tap and create the vibration effect
    @objc func noteTapped(_ sender: UITapGestureRecognizer) {
        if let noteView = sender.view as? UIImageView {
            vibrate(noteView)
            playSound(for: noteView)
        }
    }
    
    // Function to create the vibration/shake effect
    func vibrate(_ view: UIView) {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.04
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        
        let fromPoint = CGPoint(x: view.center.x - 3, y: view.center.y)
        let toPoint = CGPoint(x: view.center.x + 3, y: view.center.y)
        
        shakeAnimation.fromValue = NSValue(cgPoint: fromPoint)
        shakeAnimation.toValue = NSValue(cgPoint: toPoint)
        
        view.layer.add(shakeAnimation, forKey: "position")
    }
    
    // Function to play the sound associated with the tapped note
    func playSound(for note: UIImageView) {
        var soundFileName: String?
        
        // Determine which sound file to play based on the tapped note
        switch note {
        case noteB:
            soundFileName = "soundB"
        case noteA:
            soundFileName = "soundA"
        case noteG:
            soundFileName = "soundG"
        case noteF:
            soundFileName = "soundF"
        case noteE:
            soundFileName = "soundE"
        case noteD:
            soundFileName = "soundD"
        case noteC:
            soundFileName = "soundC"
        default:
            break
        }
        
        // Adjust path to include the "sounds" folder
        if let soundFileName = soundFileName, let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav", subdirectory: "Sounds") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer!.play()
            } catch {
                print("Could not load sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found: \(String(describing: soundFileName))")
        }
    }
    
}
