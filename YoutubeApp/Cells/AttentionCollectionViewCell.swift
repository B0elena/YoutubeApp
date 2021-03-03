//
//  AttentionCollectionViewCell.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/02.
//

import UIKit
import Nuke

// 横スクロールのセルに反映させる<
class AttentionCollectionViewCell: UICollectionViewCell {
    var videoItem: Item? {
        didSet {
            //サムネイルの読み込みをして反映<
            if let url = URL(string: videoItem?.snippet.thumbnails.medium.url ?? "") {
                Nuke.loadImage(with: url, into: thumbnailImageView)
            }
            //サムネイルの読み込みをして反映>
            videoTitleLabel.text = videoItem?.snippet.channelTitle
            discriptionLabel.text = videoItem?.snippet.description
            channelTitleLabel.text = videoItem?.channel?.items[0].snippet.title
        }
    }
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    // ジブを紐付けるための設定<
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // ジブを紐付けるための設定>
}
// 横スクロールのセルに反映させる>
