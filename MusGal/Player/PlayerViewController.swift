//
//  MusicViewController.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 01.10.2021.
//

import UIKit
import AVFoundation
import SnapKit

class PlayerViewController: UIViewController, AVAudioPlayerDelegate {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    
    var player: AVAudioPlayer?
    
    
   
    private let volumeSlider = UISlider()
    private let trackSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0
        slider.tintColor = .white
        slider.maximumTrackTintColor = .lightGray
        slider.setThumbImage(UIImage(named: "Thumb20"), for: .normal)
        return slider
    }()
    
    private let musicTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = UIFont(name: "Palatino Bold", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.stop()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateMusicTimeLabel), userInfo: nil, repeats: true)

        if self.view.subviews.count == 0{
            configure(position: position)
            setup()
        }
    }
    
    func configure(position: Int){
        
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
        
        volumeSlider.value = 0.5
        
        
    }
    
    @objc func didVolumeSliderUsed( _ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }

    @objc func didTrackSliderUsed( _ slider: UISlider) {
        guard let player = player else { return }
        
        player.stop()
        player.currentTime = TimeInterval(slider.value)
        if pausePlayButton.currentBackgroundImage == UIImage(named: "Pause") {
            player.prepareToPlay()
            player.play()
        }

        
    }
    
    @objc func didPrevButtonUsed(){
        if position > 0 {
            position -= 1
            player?.stop()
            for subview in self.view.subviews {
                subview.removeFromSuperview()
            }
            configure(position: position)
        }
    }
    
    @objc func didPausePlayButtonUsed(){
        if player?.isPlaying == true {
            player?.pause()
            
            UIView.animate(withDuration: 3) {
                self.pausePlayButton.setBackgroundImage(UIImage(named: "Play"), for: .normal)
            }
            
            pausePlayButton.setBackgroundImage(UIImage(named: "Play"), for: .normal)
        } else {
            player?.play()
            UIView.animate(withDuration: 3) {
                self.pausePlayButton.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
            }
            
        }
    }
    
    @objc func didNextButtonUsed(){
        if position < songs.count - 1 {
            position += 1
            player?.play()
            for subview in self.view.subviews {
                subview.removeFromSuperview()
            }
            configure(position: position)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //You can stop the audio
        configure(position: position + 1)
        position = position + 1
        setup()
    }
    

    
    @objc func updateSlider() {
        guard let player = player else { return }
        self.trackSlider.value = Float(player.currentTime)
    }
    

    
    @objc func updateMusicTimeLabel() {
        guard let player = player else { return }
        let min = Int(player.currentTime) / 60
        let sec = Int(player.currentTime) % 60
        if sec < 10 {
            musicTimeLabel.text = "\(min):0\(sec)"
            
        } else {
            musicTimeLabel.text = "\(min):\(sec)"
        }
        
    
    }
    
    
    
    func setup() {
        
        
        guard let player = player else { return }
        
        player.delegate = self
        
        trackSlider.maximumValue = Float(player.duration)

        pausePlayButton.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
        
        self.view.backgroundColor = .gray
        
        for subview in [trackLabel, artistLabel, albumImageVIew, volumeSlider, trackSlider, prevButton,
                        pausePlayButton, nextButton, musicTimeLabel] {
            self.view.addSubview(subview)
        }
        
        albumImageVIew.snp.makeConstraints{
            $0.height.equalTo(self.view.snp.width)
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
        
        volumeSlider.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(20)
            $0.bottomMargin.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        trackSlider.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(artistLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
        }
        
        musicTimeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(trackSlider).inset(40)
            $0.height.equalTo(15)
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
        
        trackSlider.addTarget(self, action: #selector(didTrackSliderUsed(_:)), for: .valueChanged)
        volumeSlider.addTarget(self, action: #selector(didVolumeSliderUsed(_:)), for: .valueChanged)
        prevButton.addTarget(self, action: #selector(didPrevButtonUsed), for: .touchUpInside)
        pausePlayButton.addTarget(self, action: #selector(didPausePlayButtonUsed), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didNextButtonUsed), for: .touchUpInside)
        
    }
    
    
}




