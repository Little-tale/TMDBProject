//
//  AllListReusableView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit
import SnapKit

class AllListReusableView : UICollectionReusableView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout() )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        designView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    func configureHierarchy(){
        self.addSubview(collectionView)
    }
    func configureLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    func designView(){
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 4, left: 4, bottom: 4, right: 4)
        // 스태키 하게 하는법
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    
}
