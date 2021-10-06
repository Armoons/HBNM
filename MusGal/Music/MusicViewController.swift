//
//  MUSIC.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 03.10.2021.
//

import UIKit

class MusicViewController: UIViewController {
    
    struct Cells {
        static let cell = "CustomCell"
    }

    var songs: [Song] = []

    private let tableView: UITableView = {
       let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(UINib(nibName: Cells.cell, bundle: nil), forCellReuseIdentifier: Cells.cell)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
//        if #available(iOS 15.0, *) {
//            UITableView.appearance().sectionHeaderTopPadding = 0
//        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Music"
        configureSongs()
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureSongs() {
        songs.append(Song(trackName: "Experience",
                          artistName: "Angèle Dubeau, La Pietà",
                          imageName: "Experience",
                          songName: "Angèle Dubeau, La Pietà - Experience"))
        songs.append(Song(trackName: "One Day",
                          artistName: "Imagine Dragons",
                          imageName: "One Day",
                          songName: "Imagine Dragons - One Day"))
        songs.append(Song(trackName: "Sweater Weather",
                          artistName: "The Neighbourhood",
                          imageName: "Sweater Weather",
                          songName: "The Neighbourhood - Sweater Weather"))
        songs.append(Song(trackName: "Chlorine",
                          artistName: "Twenty One Pilots",
                          imageName: "Chlorine",
                          songName: "Twenty One Pilots - Chlorine"))
        songs.append(Song(trackName: "Dance for Me Wallis",
                          artistName: "Abel Korzeniowski",
                          imageName: "Dance for Me Wallis",
                          songName: "Abel Korzeniowski - Dance For Me Wallis"))
        songs.append(Song(trackName: "Demons",
                          artistName: "Imagine Dragons",
                          imageName: "Demons",
                          songName: "Imagine Dragons - Demons"))
        songs.append(Song(trackName: "Believer",
                          artistName: "Imagine Dragons",
                          imageName: "Believer",
                          songName: "Imagine Dragons - Believer"))
        songs.append(Song(trackName: "Irresistible",
                          artistName: "Fall Out Boy",
                          imageName: "Irresistible",
                          songName: "Fall Out Boy - Irresistible"))
        songs.append(Song(trackName: "Hideaway",
                          artistName: "Dan Owen",
                          imageName: "Hideaway",
                          songName: "Dan Owen - Hideaway"))
        songs.append(Song(trackName: "Crash",
                          artistName: "Eden",
                          imageName: "Crash",
                          songName: "Eden - Crash"))
        songs.append(Song(trackName: "All I Want",
                          artistName: "Kodaline",
                          imageName: "All I Want",
                          songName: "Kodaline - All I Want"))
        songs.append(Song(trackName: "Places",
                          artistName: "Portair",
                          imageName: "Places",
                          songName: "Portair - Places"))
        songs.append(Song(trackName: "Earth",
                          artistName: "Sleeping At Last",
                          imageName: "Earth",
                          songName: "Sleeping At Last - Earth"))
        songs.append(Song(trackName: "Where's My Love",
                          artistName: "SYML",
                          imageName: "Where's My Love",
                          songName: "SYML - Where's My Love"))
    }

}

extension MusicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cell, for: indexPath) as! CustomCell
//        if cell == nil {
//            cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
//        }
        

        let song = songs[indexPath.row]
//        cell.textLabel?.text = song.trackName
//        cell.detailTextLabel?.text = song.artistName
//        cell.imageView?.image = UIImage(named: song.imageName)
        
        cell.trackLabel.text = song.trackName
        cell.artistLabel.text = song.artistName
        cell.albumImageView.image = UIImage(named: song.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        let vc = PlayerViewController()
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else { return }
        vc.position = position
        vc.songs = songs
        present(vc, animated: true)
        
    }
}

struct Song {
    let trackName: String
    let artistName: String
    let imageName: String
    let songName: String
    
}


