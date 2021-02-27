//
//  VideoListCell.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/02/27.
//

import UIKit

class VideoListCell: UICollectionViewCell {
    
    var videoItem: Item? {
        didSet {
            
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
