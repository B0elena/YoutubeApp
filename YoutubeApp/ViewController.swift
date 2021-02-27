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
    
    private func fetchYoutubeSerachInfo() {
        // 検索リストからのURL<
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=nba&key=AIzaSyAzCAmRGPX4QDsZJEZxhfTTBJ-tQwbaLDM&part=snippet"
        // 検索リストからのURL>
        let request = AF.request(urlString)
        // JSON形式で取得したデータを変換<(ブレイクポイントで取得できているかを確認)
        request.responseJSON{ (response) in
            do{
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let video = try decode.decode(Video.self, from: data)
                self.VideoItems = video.items
                
                let id = self.VideoItems[0].snippet.channelId
                self.fetchYoutubeChannelInfo(id: id)
                
            } catch {
                print("変換に失敗しました。:", error)
            }
        }
        // JSON形式で取得したデータを変換>
    }
    
    private func fetchYoutubeChannelInfo(id: String) {
        // チャンネルリストからのURL<
        let urlString = "https://www.googleapis.com/youtube/v3/channels?key=AIzaSyAzCAmRGPX4QDsZJEZxhfTTBJ-tQwbaLDM&part=snippet&id=\(id)"
        // チャンネルリストからのURL>
        let request = AF.request(urlString)
        // JSON形式で取得したデータを変換<(ブレイクポイントで取得できているかを確認)
        request.responseJSON{ (response) in
            do{
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let video = try decode.decode(Video.self, from: data)
                self.VideoItems = video.items
                
                
                
                self.videoListCollectionView.reloadData()
            } catch {
                print("変換に失敗しました。:", error)
            }
        }
        // JSON形式で取得したデータを変換>
    }
    
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
