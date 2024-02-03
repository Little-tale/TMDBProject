

import UIKit
import SnapKit

class AllListView: UIView {
    
    var navigationTitle = ""
    let listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
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
        listCollectionView.register(AllListReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AllListReusableView.reuseableIdentiFier)
        
        listCollectionView.register(StartViewCollectIonvIewCell.self, forCellWithReuseIdentifier: StartViewCollectIonvIewCell.reuseableIdentiFier)
        
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        layout.sectionInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        layout.scrollDirection = .vertical
        
        // MARK: 여기서 헤더를 고정해야 고정됨  ㅠㅠㅠ
        layout.sectionHeadersPinToVisibleBounds = true 
        
        return layout
    }
    
}
