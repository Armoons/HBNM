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
        
        

//        updateTabBarItemAppearance(appearance: tabBarAppearance.compactInlineLayoutAppearance)
//        updateTabBarItemAppearance(appearance: tabBarAppearance.inlineLayoutAppearance)
//        updateTabBarItemAppearance(appearance: tabBarAppearance.stackedLayoutAppearance)

        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
//
//    @available(iOS 13.0, *)
//    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
//        let tintColor: UIColor = .red
//        let unselectedItemTintColor: UIColor = .green
//
//        appearance.selected.iconColor = tintColor
//        appearance.normal.iconColor = unselectedItemTintColor
//    }
    
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
            i.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
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






    

