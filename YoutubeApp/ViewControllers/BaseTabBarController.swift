//
//  BaseTabBarController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/28.
//

import UIKit

class BaseTabBarController: UITabBarController {
    // enumで設定<
    enum ControllerName: Int {
        case home, search, channel, inbox, library
    }
    // enumで設定>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers?.enumerated().forEach({ (index, viewController) in
            if let name = ControllerName.init(rawValue: index) {
                switch name {
                case .home:
                    setTabbarInfo(viewController, selectedImageName: "家の無料アイコン (1)", unselectedImageName: "家の無料アイコン", title: "ホーム")
                case .search:
                    setTabbarInfo(viewController, selectedImageName: "方位磁針のアイコン素材2 (1)", unselectedImageName: "方位磁針のアイコン素材2", title: "検索")
                case .channel:
                    setTabbarInfo(viewController, selectedImageName: "再生ボタン付きのカチンコアイコン2 (1)", unselectedImageName: "再生ボタン付きのカチンコアイコン2", title: "登録チャンネル")
                case .inbox:
                    setTabbarInfo(viewController, selectedImageName: "メールの無料アイコン (1)", unselectedImageName: "メールの無料アイコン", title: "受信トレイ")
                case .library:
                    setTabbarInfo(viewController, selectedImageName: "積み重ねた本のアイコン素材 (1)", unselectedImageName: "積み重ねた本のアイコン素材", title: "ライブラリ")
                }
            }
        })
    }
    
    private func setTabbarInfo(_ viewController: UIViewController, selectedImageName: String, unselectedImageName: String, title: String) {
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.resize(size: .init(width: 20, height: 20))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.image = UIImage(named: unselectedImageName)?.resize(size: .init(width: 20, height: 20))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.title = title
    }
}
