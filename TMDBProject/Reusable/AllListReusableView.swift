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
// MARK:  나의 뻘짓으로 시작된 딜리게이트 패턴 이용해보기 2탄
// 1탄은 위에 코드 흔적들이 있을것이다. 증말 왜 안되는지 그래서 2탄~!
/*
 자 다시 어제 블로그에서 본 글처럼 해볼려고 하는데
 딜리게이트 패턴인걸로 보인다.
 좀 ... 이해가 덜되는거 같은데 다시 쳐보겠다.
 */

// 1. 커스텀 프로토콜을 만든다. -> 이때 Anyobject 프로토콜를 채택한다.
protocol headerCellForCollectionView: AnyObject {
    // 2. 컬렉션뷰 컨트롤러 에서 사용하는 메서드처럼 여기서 사용할수 있게 메서드를 구현한다.
    func numberOfItems(for reuseableView: AllListReusableView, numberOfItemsInSection section : Int) -> Int
        
    func cellForItemAt(for reuseableView: AllListReusableView, colletionView : UICollectionView , cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class AllListReusableView : UICollectionReusableView {
    
    // 3. 내가만든 프로토콜 프러퍼티를 생성하여 외부에서 구현한 객체를 박는다.
    // 이게 이해가 덜갔는데 내용이
    // A 가 B의 물건들중에 사용하려고 했는데
    // A 가 짬때리고 싶은거임
    // A 가 C에게 말함 B한테 가서 사용하라고
    
    weak var myProtocol : headerCellForCollectionView? {
        didSet{
            print("마이 프로토콜 변경 감지")
            collectionView.reloadData()
        }
    }
    
    // 영화이름 : -> 기생충
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout() )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        designView()
        // colletionViewSet()
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.reuseableIdentiFier)
        ///아.... 여기에다가 콜렉션뷰 딜리게이트 등록을 안하면 안되지
        // MARK: 7. 딜리게이트, 데이타 소스는 여기서 등록
        collectionView.delegate = self
        collectionView.dataSource = self
        print(#function)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
        configureLayout()
        designView()
        //colletionViewSet()
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.reuseableIdentiFier)
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

// 4. 이제 내가 구현한 프로토콜님을 여기에도 콜렉션뷰가 있으니까 짬때릴 준비를 함
// 4.1 애플 내부 코드는 볼수 없으신 참 경이로운 딜리게이트를 모셔오기
extension AllListReusableView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 4.2 이제 신성하신 애플 딜리게이트님에게 갖다 바쳐야 하는 임무를
    // 다른 이에게 전달할 것이다. 누구에게? 내 프로토콜을 구현하신 분에게
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("신성하신 애플 딜리게이트님에게 받칩니다.🤗🤗🤗🤗🤗🤗🤗🤗🤗")
        return myProtocol?.numberOfItems(for: self, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return myProtocol?.cellForItemAt(for: self, colletionView: collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    // 5.은 이제 이걸 구현할 뷰컨으로 넘어와라 AllListViewCon
    
    
    
}
