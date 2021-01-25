//
//  SecondViewController.swift
//  Jeffrey
//
//  Created by Mizia Lima on 1/24/21.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    @IBOutlet weak var socialMediaView: UIView!
    @IBOutlet weak var videoLayerView: UIView!
    @IBOutlet weak var emailAcess: UIButton!
    @IBOutlet weak var registerAcess: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        configButtons(button: emailAcess)
        configButtons(button: registerAcess)
        
        configButtonsMedia(button: facebookBtn)
        configButtonsMedia(button: googleBtn)
        configButtonsMedia(button: appleBtn)
        
        
    }
    
    func playVideo(){
        guard let path = Bundle.main.path(forResource: "video", ofType: "tipo") else {
        return
    }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayerView.layer.addSublayer(playerLayer)
        
        player.play()
        
        videoLayerView.bringSubviewToFront(emailAcess)
        videoLayerView.bringSubviewToFront(registerAcess)
        videoLayerView.bringSubviewToFront(socialMediaView)
        videoLayerView.bringSubviewToFront(appleBtn)
        videoLayerView.bringSubviewToFront(googleBtn)
        videoLayerView.bringSubviewToFront(facebookBtn)
            
    
    }
    
    
    func configButtons(button: UIButton?){
        button?.backgroundColor = UIColor.tertiaryLabel.withAlphaComponent(1.0)
        button?.tintColor = UIColor.black
        button?.layer.cornerRadius = 10
        button?.clipsToBounds = true
    }
    
    func configButtonsMedia(button: UIButton?){
        button?.layer.cornerRadius = (button?.layer.frame.size.height)!/2
        button?.layer.borderColor = UIColor.clear.cgColor
        button?.layer.borderWidth = 0.5
        button?.clipsToBounds = true
    }
    
    
    func configView(){
        socialMediaView.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        socialMediaView.layer.borderWidth = 0.5
        socialMediaView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
