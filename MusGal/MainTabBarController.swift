//
//  ViewController.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 01.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupTabBar()
    }
    
    @available(iOS 15.0, *)
    private func updateTabBarAppearance() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()

        let barTintColor: UIColor = .white
        tabBarAppearance.backgroundColor = barTintColor

        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    func setupTabBar() {
        
        if #available(iOS 15.0, *) {
            updateTabBarAppearance()
        }

        self.definesPresentationContext = true
        guard let musicImage: UIImage = UIImage(named: "Music") else { return }
        guard let galerryImage: UIImage = UIImage(named: "Gallery") else { return }
        
        let musicController = createNavigationVC(vc: MusicViewController(), itemImage: musicImage)
        let galleryController = createNavigationVC(vc: GalleryViewController(), itemImage: galerryImage)
        
        viewControllers = [musicController, galleryController]

        guard let items = tabBar.items else { return }
        
        for i in items {
            i.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
    }
}

extension UITabBarController {
    
    func createNavigationVC(vc: UIViewController, itemImage: UIImage) -> UINavigationController {
        let navigVC = UINavigationController(rootViewController: vc)
        navigVC.tabBarItem.image = itemImage
        return navigVC
    }
}






    

