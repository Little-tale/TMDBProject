//
//  AllListReusableView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit
import SnapKit

// 이거를 뷰컨이 하게끔 유도하는게 포인트다.
//protocol collectionReuseProtocol: UIView {
//    // 1. 필요한 메서드 만들기
//
//
//}
// 이게 핵심이 가이드 인줄알았는데
// 계약에 더 가깝게 느껴진다.
//protocol collectionReuseProtocl : AnyObject {
//    // 아이템 총 몇개?
//    func numberOfSectionForReuse(reusableView : AllListReusableView, section : Int) -> Int
//    // 어느 인덱스에 ?
//    func whereIndexOf(reusalveView: AllListReusableView, colletionView: UICollectionView, index: IndexPath) -> UICollectionViewCell
//    
//}

//extension AllListReusableView : UICollectionViewDelegate, UICollectionViewDataSource {
//    // 컬렉션뷰 딜리게이트에있는 메서드를 내 프로토콜에 있는 메서드에 넣음
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return myProtocol?.numberOfSectionForReuse(reusableView: self, section: section) ?? 0
//    }
//    // 이것도 마찬가지
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return myProtocol?.whereIndexOf(reusalveView: self, colletionView: collectionView, index: indexPath) ?? UICollectionViewCell()
//        
//    }
//    
//    
//}

class AllListReusableView : UICollectionReusableView {
    
//    //약한 참조를 통해 프로토콜 연결
//    weak var myProtocol: collectionReuseProtocl?
//    
//    func colletionViewSet() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    }
    
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout() )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        designView()
        // colletionViewSet()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
        configureLayout()
        designView()
        //colletionViewSet()
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
        self.collectionView.backgroundColor = UIColor(red: 15 / 255, green: 15 / 255, blue: 15 / 255, alpha: 1)
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 36)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 4, left: 4, bottom: 4, right: 4)
        // 스태키 하게 하는법
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    
}
