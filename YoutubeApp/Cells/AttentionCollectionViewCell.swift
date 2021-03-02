//
//  AttentionCollectionViewCell.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/02.
//

import UIKit

class AttentionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .purple
    }
    
}
