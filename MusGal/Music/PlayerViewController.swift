//
//  MusicViewController.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 01.10.2021.
//

import UIKit
import AVFoundation
import SnapKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    
    var player: AVAudioPlayer?
    private let slider = UISlider()
    
    private let albumImageVIew: UIImageView = {
        let album = UIImageView()
        album.contentMode = .scaleAspectFit
        return album
    }()
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Palatino Bold", size: 30)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Palatino", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    private let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "Back"), for: .normal)
        return button
    }()
    
    private let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
//        button.setImage(UIImage(named: "Конец"), for: .normal)
        button.setBackgroundImage(UIImage(named: "Next"), for: .normal)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.view.subviews.count == 0{
            configure()
            setup()
        }
    }
    
    func configure(){
        
        let song  = songs[position]
        let path = Bundle.main.path(forResource: song.songName, ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        

        do {
            
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.volume = 0.5
            player.play()
        }
        
        catch {
            print("Error")
        }
        
        trackLabel.text = song.trackName
        artistLabel.text = song.artistName
        albumImageVIew.image = UIImage(named: song.imageName)
        
        slider.value = 0.5
       
        
    }
    
    func setup() {
        
        pausePlayButton.setBackgroundImage(UIImage(named: "Pause"), for: .normal)

        guard let playerView = self.view else { return }
        
        playerView.backgroundColor = .gray
        
        for subview in [trackLabel, artistLabel, albumImageVIew, slider, prevButton,
                        pausePlayButton, nextButton] {
            self.view.addSubview(subview)
        }
        
        albumImageVIew.snp.makeConstraints{
            $0.height.equalTo(playerView.snp.width)
            $0.topMargin.equalToSuperview().inset(10)
            $0.right.left.equalToSuperview().inset(10)
            
        }
        
        trackLabel.snp.makeConstraints{
            $0.bottom.equalTo(albumImageVIew).offset(90)
            $0.height.equalTo(30)
            $0.left.equalToSuperview().inset(20)
        }
        
        artistLabel.snp.makeConstraints{
            $0.bottom.equalTo(trackLabel).offset(30)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        slider.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(20)
            $0.bottomMargin.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        pausePlayButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(70)
            $0.top.equalTo(artistLabel).inset(100)
        }
        
        prevButton.snp.makeConstraints{
            $0.trailing.equalTo(pausePlayButton).inset(90)
            $0.width.height.equalTo(70)
            $0.centerY.equalTo(pausePlayButton)
        }
        nextButton.snp.makeConstraints{
            $0.leading.equalTo(pausePlayButton).inset(90)
            $0.width.height.equalTo(70)
            $0.centerY.equalTo(pausePlayButton)
        }
    
    }
}



