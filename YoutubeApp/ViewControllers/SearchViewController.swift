//
//  SearchViewController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/06.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Youtubeを検索"
        sb.delegate = self
        return sb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        navigationItem.titleView?.frame = searchBar.frame
    }
}

// MARK: -UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    //サーチを始めた時に呼ばれるメソッド<
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // searchBarのキャンセルボタン
        searchBar.showsCancelButton = true
    }
    //サーチを始めた時に呼ばれるメソッド>
    
    // キャンセルボタンを押した時のメソッド<
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        // キーボードを無くす処理
        searchBar.resignFirstResponder()
    }
    // キャンセルボタンを押した時のメソッド>
}
