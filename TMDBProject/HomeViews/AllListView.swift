//
//  SearchListView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit
import SnapKit

class AllListView: UIView {
    
    var navigationTitle = ""
    lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let reuseableView = AllListReusableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        designView()
        register()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
        configureLayout()
        designView()
        register()
    }
    
    func configureHierarchy(){
        self.addSubview(listCollectionView)
    }
    func configureLayout(){
        listCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    func designView(){
        
    }
    func register() {
        
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 120)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 4
        
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
}
