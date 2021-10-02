//
//  MusicViewController.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 01.10.2021.
//

import UIKit
import SnapKit

class MusicViewController: UIViewController, UIScrollViewDelegate {
    
    var index: Int = 0
    var imageArray: [UIImage] = []
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentMode = .scaleAspectFit
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .black
        view.minimumZoomScale = 1
        view.maximumZoomScale = 6
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Закрыть"), for: .normal)
//        button.addTarget(self, action: #selector(closeButtonUsed), for: .touchUpInside)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupGesture()
        setup()
//        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
//    func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Music"
//    }
    
    func setup() {
        
//        view.backgroundColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Music"
        
        scrollView.delegate = self
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
        
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        guard let navHeight = navHeight else { return }
        
        
        for item in [scrollView, countLabel, closeButton] {
            view.addSubview(item)
        }
        
        scrollView.addSubview(imageView)
        
        
        
        
        countLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
        
        closeButton.snp.makeConstraints{
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(navHeight)
            $0.width.height.equalTo(45)
            
        }
    }
    
    
}
