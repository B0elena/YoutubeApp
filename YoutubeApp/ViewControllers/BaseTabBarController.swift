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
                setTabbarInfo(viewController, selectedImageName: "家の無料アイコン (1)", unselectedImageName: "家の無料アイコン", title: "ホーム")
            case 1:
                setTabbarInfo(viewController, selectedImageName: "方位磁針のアイコン素材2 (1)", unselectedImageName: "方位磁針のアイコン素材2", title: "検索")
            case 2:
                setTabbarInfo(viewController, selectedImageName: "再生ボタン付きのカチンコアイコン2 (1)", unselectedImageName: "再生ボタン付きのカチンコアイコン2", title: "登録チャンネル")
            case 3:
                setTabbarInfo(viewController, selectedImageName: "メールの無料アイコン (1)", unselectedImageName: "メールの無料アイコン", title: "受信トレイ")
            case 4:
                setTabbarInfo(viewController, selectedImageName: "積み重ねた本のアイコン素材 (1)", unselectedImageName: "積み重ねた本のアイコン素材", title: "ライブラリ")
            default:
                break
            }
        })
    }
    private func setTabbarInfo(_ viewController: UIViewController, selectedImageName: String, unselectedImageName: String, title: String) {
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.resize(size: .init(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.image = UIImage(named: unselectedImageName)?.resize(size: .init(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.title = title
    }
}
