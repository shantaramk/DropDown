//
//  DropDownModel.swift
//  DropDown
//
//  Created by Shantaram Kokate on 9/26/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
protocol DropDownModel {
    func show(animated:Bool)
    func hide(animated:Bool)
    var backgroundView:UIView {get set}
    var containerView:UIView {get set}
    var dataSource: [String] {get set}
}
extension DropDownModel where Self: UIView {
    func show(animated:Bool){
        self.backgroundView.alpha = 0
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
   
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                let count = self.dataSource.count * 48
                self.containerView.heightAnchor.constraint(equalToConstant: CGFloat(count)).isActive = true;                self.backgroundView.alpha = 1.0
             }) { (completion) in
                self.backgroundView.alpha = 1.0
             }
 
        } else {
             self.backgroundView.alpha = 1.0
        }
    }
    func hide(animated: Bool) {
        if animated {
            self.backgroundView.alpha = 1.0
            self.containerView.transform = .identity
            UIView.animate(withDuration: 0.1, animations: {
                self.backgroundView.alpha = 0.0
                self.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { (completion) in
                self.backgroundView.alpha = 0.0
                self.removeFromSuperview()
            }
        } else {
            self.backgroundView.alpha = 0.0
            self.removeFromSuperview()
        }
        
    }
}
