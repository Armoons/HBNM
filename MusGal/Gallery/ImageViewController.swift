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
        setupGesture()
        setup()
        loadImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    
    func setup() {
            
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
        dismissView()

    }
    
    func setupGesture() {
        let singleTapGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(singleTapOnScrollView(recognizer:)))
        singleTapGesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapOnScrollView(recognizer:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
        
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                            action: #selector(handleSwipeFrom(recognizer:)))
        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                           action: #selector(handleSwipeFrom(recognizer:)))
        
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        
        for swipe in [rightSwipe, leftSwipe] {
            scrollView.addGestureRecognizer(swipe)
        }
        

    }
    
    @objc func singleTapOnScrollView(recognizer: UITapGestureRecognizer) {
        closeButton.isHidden = !closeButton.isHidden
        countLabel.isHidden = !countLabel.isHidden
    }
    
    @objc func doubleTapOnScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            print("rgr")
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale,
                                                 center: recognizer.location(in: recognizer.view)),animated: true)
            closeButton.isHidden = true
            countLabel.isHidden = true
        } else {
            scrollView.setZoomScale(1, animated: true)
            closeButton.isHidden = false
            countLabel.isHidden = false
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2)
        
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @objc func handleSwipeFrom(recognizer: UISwipeGestureRecognizer) {
        let direction: UISwipeGestureRecognizer.Direction = recognizer.direction
        
        switch direction {
        case UISwipeGestureRecognizer.Direction.right:
            self.index -= 1
        case UISwipeGestureRecognizer.Direction.left:
            self.index += 1
        default:
            break
        }
        
        self.index = self.index < 0 ? self.imageArray.count - 1 : self.index % self.imageArray.count
        loadImage()
    }
    
}
