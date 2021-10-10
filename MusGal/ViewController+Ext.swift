//
//  ViewController+Ext.swift
//  MusGal
//
//  Created by Stepanyan Arman  on 06.10.2021.
//

import UIKit

extension UIViewController {
    
    func pushView(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.0
        transition.type = .fade
//        self.view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismissView() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .reveal
        transition.subtype = .fromLeft
        navigationController?.popViewController(animated: true)
    }
}
