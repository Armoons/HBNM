//
//  ImageViewController.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 05.10.2021.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
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
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonUsed), for: .touchUpInside)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupGesture()
        setup()
        loadImage()
        
    }
    
    func setup() {
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true

        
        scrollView.delegate = self
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
        
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        guard let navHeight = navHeight else {return}
        
        
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
    
    func loadImage() {
        imageView.image = imageArray[index]
        countLabel.text = "\(index+1)/\(imageArray.count)"
    }
    
    @objc func closeButtonUsed() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .reveal
        transition.subtype = .fromBottom
        self.view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: true)
    }
}
