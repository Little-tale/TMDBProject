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

final class DetailRecommendTableViewCell : BaseTableViewCell {
    let headerLabel = DefaultHeaderLabel()
    
    lazy var recommendColletionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout )
    
    override func configureHierarchy() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(recommendColletionView)
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        recommendColletionView.snp.makeConstraints { make in
            make.height.equalTo(160).priority(600)
            make.top.equalTo(headerLabel.snp.bottom).inset( -4 )
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    //MARK: View Design Method
    override func designView() {
        headerLabel.backgroundColor = .black
        recommendColletionView.backgroundColor = .black
        self.backgroundColor = .black
        self.contentView.backgroundColor = .black
        register()
    }
    
    //MARK: 레지스터
    private func register() {
        recommendColletionView.register(StartViewCollectIonvIewCell.self, forCellWithReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier)
    }
}

extension DetailRecommendTableViewCell {
    private var collectionViewLayout : UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100 , height: 150)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        layout.scrollDirection = .horizontal
        return layout
    }
}
