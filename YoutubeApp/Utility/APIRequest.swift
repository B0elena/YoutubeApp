//
//  APIRequest.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import Foundation
import Alamofire

class APIRequest {
    
    enum PathType: String {
        case search
        case channels
    }
    
    
    // これはひとつのインスタンスであるという認識<(シングルトン)
    static var shared = APIRequest()
    // これはひとつのインスタンスであるという認識>
    
    private let baseUrl = "https://www.googleapis.com/youtube/v3/"
    
    
    // 検索かチャンネルかを分けてセットするGenericsのメソッドの書き方<
    func request<T: Decodable>(path: PathType, params: [String: Any], type: T.Type, completion: @escaping (T) -> Void) {
        // ベースのURL<
        let path = path.rawValue
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
