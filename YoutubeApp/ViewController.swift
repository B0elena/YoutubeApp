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
        let path = "search"
        let params = ["q": "nba"]
        apiRequest(path: path, params: params, type: Video.self) { (video) in
            self.VideoItems = video.items
            let id = self.VideoItems[0].snippet.channelId
            self.fetchYoutubeChannelInfo(id: id)
        }
    }
    // 検索リストからのレスポンス>
    
    // チャンネルリストからのレスポンス<
    private func fetchYoutubeChannelInfo(id: String) {
        let path = "channels"
        let params = [
            "id": id
        ]
        apiRequest(path: path, params: params, type: Channel.self) { (channel) in
            self.VideoItems.forEach{ (item) in
                item.channel = channel
            }
            self.videoListCollectionView.reloadData()
        }
    }
    // チャンネルリストからのレスポンス>
    
    // 検索かチャンネルかを分けてセットするGenericsのメソッドの書き方<
    private func apiRequest<T: Decodable>(path: String, params: [String: Any], type: T.Type, completion: @escaping (T) -> Void) {
        // ベースのURL<
        let baseUrl = "https://www.googleapis.com/youtube/v3/"
        let path = path
        let url = baseUrl + path + "?"
        var params = params
        params["key"] = "AIzaSyAzCAmRGPX4QDsZJEZxhfTTBJ-tQwbaLDM"
        params["part"] = "snippet"
        // ベースのURL>
        let request = AF.request(url, method: .get, parameters: params)
        // JSON形式で取得したデータを変換<
        request.responseJSON{ (response) in
            do{
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let value = try decode.decode(T.self, from: data)

                completion(value)
            } catch {
                print("変換に失敗しました。:", error)
            }
        }
        // JSON形式で取得したデータを変換>
    }
    // 検索かチャンネルかを分けてセットするGenericsのメソッドの書き方>
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
