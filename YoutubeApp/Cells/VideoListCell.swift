//
//  VideoListCell.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import UIKit
import Nuke

class VideoListCell: UICollectionViewCell {
    
    var videoItem: Item? {
        didSet {
            //サムネイルの読み込みをして反映<
            if let url = URL(string: videoItem?.snippet.thumbnails.medium.url ?? "") {
                Nuke.loadImage(with: url, into: thumbnailImageView)
            }
            //サムネイルの読み込みをして反映>
            //  チャンネルイメージの読み込みをして反映<
            if let channelUrl = URL(string: videoItem?.channel?.items[0].snippet.thumbnails.medium.url ?? "") {
                Nuke.loadImage(with: channelUrl, into: channelImageView)
            }
            //  チャンネルイメージの読み込みをして反映>
            titleLabel.text = videoItem?.snippet.channelTitle
            descriptionLabel.text = videoItem?.snippet.description
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    // ジブを紐付けるための設定<
    override func awakeFromNib() {
        super.awakeFromNib()
        channelImageView.layer.cornerRadius = 20
    }
    // ジブを紐付けるための設定>
}
