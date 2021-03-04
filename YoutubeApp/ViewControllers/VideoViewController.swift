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
    private var imageViewCenterY: CGFloat?
    
    var videoImageMaxY: CGFloat {
        let ecludeValue = view.safeAreaInsets.bottom + (imageViewCenterY ?? 0)
        return view.frame.maxY - ecludeValue
    }
    
    // videoImageView
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoImageViewTrailingConstraint: NSLayoutConstraint!
    
    // backView
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backViewBottomConstoraint: NSLayoutConstraint!
    
    // describeView
    @IBOutlet weak var describeView: UIView!
    @IBOutlet weak var describeViewTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
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
        self.view.bringSubviewToFront(videoImageView)
        
        imageViewCenterY = videoImageView.center.y
        
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
            
            if videoImageMaxY <= move.y {
                moveToBottom(imageView: imageView as! UIImageView)
                return
            }
            
            imageView.transform = CGAffineTransform(translationX: 0, y: move.y)
            
            // 左右のpadding設定
            let movingConstant = move.y / 30
            
            if movingConstant <= 12 {
                videoImageViewTrailingConstraint.constant = movingConstant
                videoImageViewLeadingConstraint.constant = movingConstant
                
                backViewTrailingConstraint.constant = -movingConstant
            }
            
            // imageViewの高さの動き
            // 280(最大値) - 70(最小値) = 210
            let parantViewHeight = self.view.frame.height
            let heightRatio = 210 / (parantViewHeight - (parantViewHeight / 6))
            let moveHeight = move.y * heightRatio
            
            backViewTopConstraint.constant = move.y
            videoImageViewHeightConstraint.constant = 280 - moveHeight
            describeViewTopConstraint.constant = move.y * 0.8
            
            
            let bottomMoveY = parantViewHeight - videoImageMaxY
            let bottomMoveRatio = bottomMoveY / videoImageMaxY
            let bottomMoveConstant = move.y * bottomMoveRatio
            backViewBottomConstoraint.constant = bottomMoveConstant
            
            // alpha値の設定
            let alphaRatio = move.y / (parantViewHeight / 2)
            describeView.alpha = 1 - alphaRatio
            
            // imageViewの横幅の動き 150(最小値)
            let originalWidth = self.view.frame.width
            let minimumImageViewTrailingConstant = originalWidth - (150 + 12)
            let constant = originalWidth - move.y
            
            if minimumImageViewTrailingConstant < -constant {
                videoImageViewTrailingConstraint.constant = minimumImageViewTrailingConstant
                return
            }
            
            if constant < -12 {
                videoImageViewTrailingConstraint.constant = -constant
            }
        } else if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {

                self.backToIdentityAllViews(imageView: imageView as! UIImageView)
            })
        }
    }
    
    private func moveToBottom(imageView: UIImageView) {
        imageView.transform = CGAffineTransform(translationX: 0, y: videoImageMaxY)
        backView.transform = CGAffineTransform(translationX: 0, y: videoImageMaxY)
    }
    
    private func backToIdentityAllViews(imageView: UIImageView) {
        // 手を離した時の処理
        imageView.transform = .identity
        self.videoImageViewHeightConstraint.constant = 280
        self.videoImageViewLeadingConstraint.constant = 0
        self.videoImageViewTrailingConstraint.constant = 0
        
        self.view.layoutIfNeeded()
    }
}
