//
//  ViewController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var videoListCollectionView: UICollectionView!
    
    private let cellId = "cellId"
    private var VideoItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoListCollectionView.delegate = self
        videoListCollectionView.dataSource = self
                
        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        fetchYoutubeSerachInfo()
    }
    
    // 検索リストからのレスポンス<
    private func fetchYoutubeSerachInfo() {
        let params = ["q": "nba"]
        // Utilityから処理を呼び出す<
        APIRequest.shared.request(path: .search, params: params, type: Video.self) { (video) in
            self.VideoItems = video.items
            let id = self.VideoItems[0].snippet.channelId
            self.fetchYoutubeChannelInfo(id: id)
        }
        // Utilityから処理を呼び出す>
    }
    // 検索リストからのレスポンス>
    
    // チャンネルリストからのレスポンス<
    private func fetchYoutubeChannelInfo(id: String) {
        let params = [
            "id": id
        ]
        // Utilityから処理を呼び出す<
        APIRequest.shared.request(path: .channels, params: params, type: Channel.self) { (channel) in
            self.VideoItems.forEach{ (item) in
                item.channel = channel
            }
            self.videoListCollectionView.reloadData()
        }
        // Utilityから処理を呼び出す>
    }
    // チャンネルリストからのレスポンス>
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // セルの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return .init(width: width, height: width)
    }
    // セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VideoItems.count
    }
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoListCell
        cell.videoItem = VideoItems[indexPath.row]
        
        return cell
    }
}
