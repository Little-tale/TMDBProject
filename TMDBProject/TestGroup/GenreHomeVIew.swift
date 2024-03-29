//
//  GenreHomeVIew.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/6/24.
//

import UIKit
import SnapKit

class GenreHomeVIew: BaseView {
    // let genreTabelView = UITableView()
    lazy var genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: colletionViewLayout())
    
    override func configureHierarchy() {
        self.addSubview(genreCollectionView)
    }
    override func configureLayout() {
        genreCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        genreCollectionView.register(GenreCollectionViewCells.self, forCellWithReuseIdentifier: GenreCollectionViewCells.reuseableIdentiFier)
        genreCollectionView.register(StartViewCollectIonvIewCell.self, forCellWithReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier)
    }
    
    override func designView() {
        genreCollectionView.backgroundColor = .black
        genreCollectionView.clipsToBounds = true
    }
    
    private func colletionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width / 2.6
        
        layout.itemSize = CGSize(width: width, height: width * 1.5 )
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        
        layout.scrollDirection = .vertical
        
        return layout
    }

    
    
}
