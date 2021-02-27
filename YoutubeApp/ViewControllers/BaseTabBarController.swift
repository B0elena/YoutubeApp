//
//  BaseTabBarController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/28.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers?.enumerated().forEach({ (index, viewController) in
            switch index {
            case 0:
                viewController.tabBarItem.selectedImage = UIImage(named: "")
            default:
                break
            }
        })
    }
}
