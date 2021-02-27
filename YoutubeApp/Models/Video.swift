//
//  Video.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import Foundation

class Video: Decodable {
    let kind: String
    let items: [Item]
}

class Item: Decodable {
    let snippet: Snippet
}

class Snippet: Decodable {
    let publishedAt: String
    let channelId: String
    let channelTitle: String
    let description: String
    let thumbnails: [Thumbnail]
}

class Thumbnail: Decodable {
    let medium: ThumbnailInfo
    let high: ThumbnailInfo
}

class ThumbnailInfo: Decodable {
    let url: String
    let width: Int
    let height: Int
}
