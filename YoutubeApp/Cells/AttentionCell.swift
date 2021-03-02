//
//  AttentionCell.swift
//  YoutubeApp
//
//  Created by 須賀辰則 on 2021/03/02.
//

import UIKit

class AttentionCell: UICollectionViewCell {
    
    private let attentionId = "attentionId"
    
    lazy var attentionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(attentionCollectionView)
        [
            attentionCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            attentionCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            attentionCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            attentionCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ].forEach { $0.isActive = true}
        
        attentionCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: attentionId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -UICollectionViewDelegate,UICollectionViewDataSource
extension AttentionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = attentionCollectionView.dequeueReusableCell(withReuseIdentifier: attentionId, for: indexPath)
        cell.backgroundColor = .yellow
        
        return cell
    }
}
