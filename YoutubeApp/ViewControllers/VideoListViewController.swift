//
//  ViewController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import UIKit
import Alamofire

class VideoListViewController: UIViewController {

    @IBOutlet weak var videoListCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    private var prevContentOffset: CGPoint = .init(x: 0, y: 0)
    private let headerMoveHeight: CGFloat = 5
    
    private let cellId = "cellId"
    private let atentionCellId = "atentionCellId"
    private var videoItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchYoutubeSerachInfo()
    }
    
    private func setupViews() {
        videoListCollectionView.delegate = self
        videoListCollectionView.dataSource = self
        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        videoListCollectionView.register(AttentionCell.self, forCellWithReuseIdentifier: atentionCellId)
        profileImageView.layer.cornerRadius = 20
    }
    
    // 検索リストからのレスポンス<
    private func fetchYoutubeSerachInfo() {
        let params = ["q": "netflix"]
        // Serviceから処理を呼び出す<
        API.shared.request(path: .search, params: params, type: Video.self) { (video) in
            self.videoItems = video.items
            let id = self.videoItems[0].snippet.channelId
            self.fetchYoutubeChannelInfo(id: id)
        }
        // Serviceから処理を呼び出す>
    }
    // 検索リストからのレスポンス>
    
    // チャンネルリストからのレスポンス<
    private func fetchYoutubeChannelInfo(id: String) {
        let params = [
            "id": id
        ]
        // Serviceから処理を呼び出す<
        API.shared.request(path: .channels, params: params, type: Channel.self) { (channel) in
            self.videoItems.forEach{ (item) in
                item.channel = channel
            }
            self.videoListCollectionView.reloadData()
        }
        // Serviceから処理を呼び出す>
    }
    // チャンネルリストからのレスポンス>
    
    // ヘッダーが途中で止まった時の処理<
    private func headerViewEndAnimation() {
        if headerTopConstraint.constant < -headerHeightConstraint.constant / 2 {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
                self.headerTopConstraint.constant = -self.headerHeightConstraint.constant
                self.headerView.alpha = 0
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
                self.headerTopConstraint.constant = 0
                self.headerView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    // ヘッダーが途中で止まった時の処理>
}

// MARK: -ScrollViewのDelegateメソッド
extension VideoListViewController {
    // scrollVillがスクロールした時に呼ばれるメソッド<
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerAnimetion(scrollView: scrollView)
    }
    // scrollVillがスクロールした時に呼ばれるメソッド>
    
    private func headerAnimetion(scrollView: UIScrollView) {
        // 0.5秒後の値を比較してどの方向にスクロールしているのかを判断する<
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.prevContentOffset = scrollView.contentOffset
        }
        // 0.5秒後の値を比較してどの方向にスクロールしているのかを判断する>
        
        // スクロールし過ぎた時のヘッダーの処理<
        guard let presentIndexPath = videoListCollectionView.indexPathForItem(at: scrollView.contentOffset) else { return }
        if scrollView.contentOffset.y < 0 { return }
        if presentIndexPath.row >= videoItems.count - 2 { return }
        // スクロールし過ぎた時のヘッダーの処理>
        
        // ヘッダーのalpha設定
        let alphaRatio = 1 / headerHeightConstraint.constant
        
        // 上にスクロールする時
        if self.prevContentOffset.y < scrollView.contentOffset.y {
            if headerTopConstraint.constant <= -headerHeightConstraint.constant { return }
            // スクロールするとヘッダーのトップの値とalphaがマイナスされていく
            headerTopConstraint.constant -= headerMoveHeight
            headerView.alpha -= alphaRatio * headerMoveHeight
        // 下にスクロールする時
        } else if self.prevContentOffset.y > scrollView.contentOffset.y {
            if headerTopConstraint.constant >= 0 { return }
            // スクロールするとヘッダーのトップの値とalphaがプラスされていく
            headerTopConstraint.constant += headerMoveHeight
            headerView.alpha += alphaRatio * headerMoveHeight
        }
    }
    // scrollViewのスクロールがピタッと止まった時に呼ばれる
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            headerViewEndAnimation()
        }
    }
    // scrollViewのスクロールが止まった時に呼ばれる
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        headerViewEndAnimation()
    }
}

// MARK: -UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension VideoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // セルを選んだ時の遷移
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoViewController = UIStoryboard(name: "Video", bundle: nil).instantiateViewController(identifier: "VideoViewController") as VideoViewController
        // モーダルをフルスクリーンにする
        videoViewController.modalPresentationStyle = .fullScreen
        self.present(videoViewController, animated: true, completion: nil)
    }
    
    // セルの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        
        if indexPath.row  == 2 {
            return .init(width: width, height: 200)
        } else {
            return .init(width: width, height: width)
        }
    }
    // セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count + 1
    }
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 2 {
            
            let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: atentionCellId, for: indexPath) as! AttentionCell
            
            cell.videoItems = self.videoItems
            
            return cell
            
        } else {
            
            let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoListCell
            
            if self.videoItems.count == 0 { return cell }
            if indexPath.row > 2 {
                cell.videoItem = videoItems[indexPath.row - 1]
            } else {
                cell.videoItem = videoItems[indexPath.row]
            }
            
            return cell
        }
    }
}
