//
//  GenreTableViewCell.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit
import SnapKit
// 뷰컨에선 이미 딜리게이트 채택함으로 어제 학습했던 딜리게이트 패턴 시이이이작

protocol GenreTableViewDelegate: AnyObject {
    func numberOfItemsAt(_for genreCell : GenreTableViewCell, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func cellForItemAt(_for genreCell : GenreTableViewCell, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class GenreTableViewCell : BaseTableViewCell {
    
    weak var delegate: GenreTableViewDelegate?
    
    lazy var GenreCollecitonview = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        contentView.addSubview(GenreCollecitonview)
    }
    
    override func configureLayout() {
        GenreCollecitonview.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func designView() {
        
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}

extension GenreTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfItemsAt(_for: self, collectionView: collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return delegate?.cellForItemAt(_for: self, collectionView: collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    
}
