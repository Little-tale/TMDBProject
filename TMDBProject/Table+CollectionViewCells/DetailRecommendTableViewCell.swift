//
//  DetailRecommendTableViewCell.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit
import SnapKit

// 겹치는 부분이 많다고 보여저 StartViewControllerTableCell과 통합되었습니다.
// 이용해 주셔서 감사합니다. 

// 였는데요 그래도 연습이니까 계속 다시 만들어 봅니다

class DetailRecommendTableViewCell : BaseTableViewCell {
    
    
    lazy var recommendColletionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout )
    
    override func configureHierarchy() {
        contentView.addSubview(recommendColletionView)
    }
    override func configureLayout() {
        recommendColletionView.snp.makeConstraints { make in
            make.height.equalTo(160).priority(600)
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
}

extension DetailRecommendTableViewCell {
    var collectionViewLayout : UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100 , height: 150)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        layout.scrollDirection = .horizontal
        return layout
    }
}
