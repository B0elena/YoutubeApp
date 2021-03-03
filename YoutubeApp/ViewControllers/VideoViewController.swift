//
//  VideoViewController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/03.
//

import UIKit
import Nuke

class VideoViewController: UIViewController {

    var selectedItem: Item?
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

    }
    
    private func setupViews() {
        channelImageView.layer.cornerRadius = 22.5
        //サムネイルの読み込みをして反映<
        if let url = URL(string: selectedItem?.snippet.thumbnails.medium.url ?? "") {
            Nuke.loadImage(with: url, into: videoImageView)
        }
        //サムネイルの読み込みをして反映>
        //  チャンネルイメージの読み込みをして反映<
        if let channelUrl = URL(string: selectedItem?.channel?.items[0].snippet.thumbnails.medium.url ?? "") {
            Nuke.loadImage(with: channelUrl, into: channelImageView)
        }
        //  チャンネルイメージの読み込みをして反映>
        videoTitleLabel.text = selectedItem?.snippet.channelTitle
        channelTitleLabel.text = selectedItem?.channel?.items[0].snippet.title
    }
}
