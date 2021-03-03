//
//  VideoViewController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/03.
//

import UIKit
import Nuke

class VideoViewController: UIViewController {

    var selectedItem: Item?
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var baseBackGroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.baseBackGroundView.alpha = 1
        }
    }
    
    private func setupViews() {
        channelImageView.layer.cornerRadius = 22.5
        //サムネイルの読み込みをして反映<
        if let url = URL(string: selectedItem?.snippet.thumbnails.medium.url ?? "") {
            Nuke.loadImage(with: url, into: videoImageView)
        }
        //サムネイルの読み込みをして反映>
        //  チャンネルイメージの読み込みをして反映<
        if let channelUrl = URL(string: selectedItem?.channel?.items[0].snippet.thumbnails.medium.url ?? "") {
            Nuke.loadImage(with: channelUrl, into: channelImageView)
        }
        //  チャンネルイメージの読み込みをして反映>
        videoTitleLabel.text = selectedItem?.snippet.channelTitle
        channelTitleLabel.text = selectedItem?.channel?.items[0].snippet.title
        // イメージをスワイプした時の情報の取得の処理
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panVideoImageView))
        videoImageView.addGestureRecognizer(panGesture)
    }
    @objc private func panVideoImageView(gesture: UIPanGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        let move = gesture.translation(in: imageView)
        
        if gesture.state == .changed {
            
            imageView.transform = CGAffineTransform(translationX: 0, y: move.y)
            
        } else if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                
                imageView.transform = .identity
                self.view.layoutIfNeeded()
            })
        }
    }
}
