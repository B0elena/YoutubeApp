//
//  Channel.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import Foundation

// チャンネルの情報の定義<
class Channel: Decodable {
    let items: [ChannelItem]
}

class ChannelItem: Decodable {
    let snippet: ChannelSnippet
}

class ChannelSnippet: Decodable {
    let thumbnails: Thumbnail
}
// チャンネルの情報の定義>
