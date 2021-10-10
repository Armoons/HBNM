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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Music"
        configureSongs()
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    struct tracksName {
        static let experience = "Angèle Dubeau, La Pietà-Experience"
        static let oneDay = "Imagine Dragons-One Day"
        static let chlorine = "Twenty One Pilots-Chlorine"
        static let sweaterWeather  = "The Neighbourhood-Sweater Weather"
        static let demons = "Imagine Dragons-Demons"
        static let believer = "Imagine Dragons-Believer"
        static let irresistible = "Fall Out Boy-Irresistible"
        
    }
    
    
    func configureSongs() {
        
        songs.append(Song(trackName: String(tracksName.experience.split(separator: "-")[1]),
                          artistName: String(tracksName.experience.split(separator: "-")[0]),
                          imageName: String(tracksName.experience.split(separator: "-")[1]),
                          songName: tracksName.experience))
        songs.append(Song(trackName: String(tracksName.oneDay.split(separator: "-")[1]),
                          artistName: String(tracksName.oneDay.split(separator: "-")[0]),
                          imageName: String(tracksName.oneDay.split(separator: "-")[1]),
                          songName: tracksName.oneDay))
        songs.append(Song(trackName: String(tracksName.chlorine.split(separator: "-")[1]),
                          artistName: String(tracksName.chlorine.split(separator: "-")[0]),
                          imageName: String(tracksName.chlorine.split(separator: "-")[1]),
                          songName: tracksName.chlorine))
        songs.append(Song(trackName: String(tracksName.sweaterWeather.split(separator: "-")[1]),
                          artistName: String(tracksName.sweaterWeather.split(separator: "-")[0]),
                          imageName: String(tracksName.sweaterWeather.split(separator: "-")[1]),
                          songName: tracksName.sweaterWeather))
        songs.append(Song(trackName: String(tracksName.demons.split(separator: "-")[1]),
                          artistName: String(tracksName.demons.split(separator: "-")[0]),
                          imageName: String(tracksName.demons.split(separator: "-")[1]),
                          songName: tracksName.demons))
        songs.append(Song(trackName: String(tracksName.believer.split(separator: "-")[1]),
                          artistName: String(tracksName.believer.split(separator: "-")[0]),
                          imageName: String(tracksName.believer.split(separator: "-")[1]),
                          songName: tracksName.believer))
        songs.append(Song(trackName: String(tracksName.irresistible.split(separator: "-")[1]),
                          artistName: String(tracksName.irresistible.split(separator: "-")[0]),
                          imageName: String(tracksName.irresistible.split(separator: "-")[1]),
                          songName: tracksName.irresistible))
        songs.append(Song(trackName: String(tracksName.demons.split(separator: "-")[1]),
                          artistName: String(tracksName.demons.split(separator: "-")[0]),
                          imageName: String(tracksName.demons.split(separator: "-")[1]),
                          songName: tracksName.demons))

    }

}

extension MusicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
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


