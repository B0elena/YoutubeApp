//
//  SearchViewController.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/06.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    private let videoCellId = "videoCellId"
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Youtubeを検索"
        sb.delegate = self
        return sb
    }()
    
    lazy var videoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        navigationItem.titleView?.frame = searchBar.frame
        
        videoCollectionView.frame = self.view.frame
        self.view.addSubview(videoCollectionView)
        videoCollectionView.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: videoCellId)
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
    
    // キーボードのsearchを押した時の処理<
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        // API通信を呼ぶ
    }
    // キーボードのsearchを押した時の処理>
}

// MARK: -UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: videoCellId, for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
