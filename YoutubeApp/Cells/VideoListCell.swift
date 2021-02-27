//
//  VideoListCell.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import UIKit

class VideoListCell: UICollectionViewCell {
   // ジブを紐付けるための設定<
    @IBOutlet weak var channelImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        channelImageView.layer.cornerRadius = 20
    }
    // ジブを紐付けるための設定>
}
