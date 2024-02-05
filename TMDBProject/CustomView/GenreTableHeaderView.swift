//
//  GenreTableHeaderView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit
import SnapKit
class GenreTableHeaderView: BaseView{
    
    lazy var buttonsColletionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
       
        self.addSubview(buttonsColletionView)
    }
    override func configureLayout() {
        buttonsColletionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    override func designView() {
        
        buttonsColletionView.register(HeaderButtonCell.self, forCellWithReuseIdentifier: HeaderButtonCell.reuseableIdentiFier)
        
    }
    
}

extension GenreTableHeaderView {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 80, height: 40)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.scrollDirection = .horizontal
            return layout
        }
}
