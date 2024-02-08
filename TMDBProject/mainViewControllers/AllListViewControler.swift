

import UIKit
/*
 여기는 이제 페이지 네이션을 다시 연습하기 위해서
 page 넘버를 쿼리 파라미터로 요청해야하닌 좀 뭔가 이 페이지를 위한 API METHOD 연기를 해보아야 할것같다.
 */

/*
 자이제 재사용 헤더뷰 님의 조작을 어떻게 해야할지 생각해보아야 한다.
 일단 현재의 심정은 망했다.
 하는법이 딱히 떠오르지 않는다.
 저번처럼 컬렉션뷰 인스턴스가 여기에 있어서 가능했는가?
 아니!
 그렇다면 어떻게 해야 하는가 딜리게이트 패턴을 빠르게 배워서 해볼까?
 아니면 클로저에 담아서 여기서 가져오는가? 난 바보다
 답이 안떠오른다.
 
 */

final class AllListViewControler: AllListBaseViewController {
    
    private let allListHomeView = AllListView()
    
    override func loadView() {
        self.view = allListHomeView
        self.view.backgroundColor = .black
    }
     var pageNum = 2
     var presentItemCount = 0
    /// 이건 트렌드나 pop 등의 페이지별 갯수가 다른 경우가 있을수도 있다고 생각해서 핸들링 시도
     var pageInCount = 0
     var totalPageCount = 0
    
    var modelList: [Searchs]? = [] {
        didSet {
            print("값이 넘어옴")
            // 리로드 할때 모든 이미지들이 킹피셔의 페이드 효과를 다시 함.
            print("리로두 시도!!!!!!!😇😇😇😇😇😇")
            self.allListHomeView.listCollectionView.reloadData()
        }
    }
     var APIStyles : TMDBAPI? {
        didSet{
            print("에이피아이 받았어요!")
            ApiRequest(pageNum: self.pageNum)
        }
    }
    // MARK: overrride 재정의 한것을 private 하지 못하는 이유
    /// 서브클래싱을 통해 오버라이드 되는 경우가 많기 때문이다.
    ///  UIViewController의 생병 주기 메서드 들이 상속 구조내에서 오버라이드 될수 있도록 설계되어 있는데
    ///   이걸 private를 하게 되면 서브 클래스가 접근을 할수가 없게 되어 정상적인 오버라이딩일 불가능해진다.
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        allListHomeView.listCollectionView.dataSource = self
        allListHomeView.listCollectionView.delegate = self
        // 이놈이 범인인가...
        // allListHomeView.reuseableView.collectionView.delegate = self
        allListHomeView.listCollectionView.prefetchDataSource = self
       
    }
//    func ApiRequest(){
////        TMDBAPIManager.shared.fetchSearchView(type: SearchModel.self, api: APIStyles ?? .top(language: .kor)) { searchModel in
////            self.modelList?.append(contentsOf: searchModel.results)
////        }
//
//    }
    private func ApiRequest(pageNum : Int){
//        TMDBAPIManager.shared.fetchOnlyForAllListView(api: APIStyles ?? .top(language: .kor),
//                                                      pageNum: pageNum) { searchModel in
//            modelList?.append(contentsOf: searchModel.results )
//        }
        // 내가 만든 프로토콜로 하게 될경우 타입이 정확이 무엇인지 모르게 되어서 가 아니다.
        // 이유는 간단한데 타입을 이친구가 추론을 하게될때 파라미터로 직접 받지 않는 메서드는
        // 이렇게 타입이 무엇인지를 알려주어야 한다. 왜냐? 이친구는 무슨 특정한 타입이 올지 모르는 상황이 오기 때문이다.
        // 잊어 먹지 않기 위해서 여기에 기록을 남겨 두었다.
//        TMDBAPIManager.shared.fetchOnlyForAllListView(api: APIStyles ?? .top(language: .kor), pageNum: pageNum) { (searchModel: SearchModel) in
//            <#code#>
//        }
        TMDBAPIManager.shared.fetchOnlyForAllListView(type: SearchModel.self, api: APIStyles ?? .top(language: .kor), pageNum: pageNum) { searchModel in
            self.modelList?.append(contentsOf: searchModel.results)
        }
    }
    
}
// MARK: 컬렉션뷰 딜리게이트 데이터 소스
extension AllListViewControler: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presentItemCount = modelList?.count ?? 0
        return modelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseableIdentiFier, for: indexPath) as? StartViewCollectIonvIewCell else {
            print("레지스터 문제")
            return UICollectionViewCell()
        }
        cell.backgroundColor = .brown
        print("일반적인 인덱스 패스 아이템즈 넘버",indexPath.item)
        
        if let image = modelList?[indexPath.item].poster_path {
            let url = ImageManager.getImage(imageCase: .trend, image: image)
            cell.prepare(image: url, title: nil)
            return cell
        }
        if let name = modelList?[indexPath.item].name {
            cell.prepare(image: nil, title: name)
            return cell
        }
        
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AllListReusableView.reuseableIdentiFier, for: indexPath) as? AllListReusableView {
           
            //print("여긴되니?")
            // reusableView.myProtocol = self
            // MARK: 6. 자 여기다 5번 에서 왔을것이다
            // 6.1 딜리게이트 설정한거처럼 여기에다가 내 프로토콜을 설정한다.
            reusableView.myProtocol = self
            print("마이 프로토콜 동작하나요!~~!!~!~!!😡😡😡😡😡😡")
            
            return reusableView
        }
        return UICollectionReusableView()
    }

}
// MARK: 페이지 네이션 구현란
extension AllListViewControler: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //print("프리패칭 인덱스 패스",indexPaths)
        
        for indexPath in indexPaths {
            //print("프리패칭 인덱스 패스 : ",indexPath.row)
            
            if presentItemCount - 10 <= indexPath.row && pageNum <= totalPageCount{
                presentItemCount += pageInCount
                pageNum += 1
                TMDBAPIManager.shared.fetchOnlyForAllListView(type: SearchModel.self, api: APIStyles ?? .top(language: .kor), pageNum: pageNum) { results in
                    self.modelList?.append(contentsOf: results.results)
                }
            }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("불러오기 안할꼬야 ", indexPaths)
        //print("이건 전혀 감이 안온다.")
    }
    
}

extension AllListViewControler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        print("헤더뷰 높이 조절은 될텐데?")
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
    
}

//MARK: 잘 찾아왔다 5번 설명 시작한다.
// 5.1 이제 내가 만든 프로토콜님을 채택해준다...
extension AllListViewControler: headerCellForCollectionView {
    // 5.2 짬맞은 불쌍한 뷰컨이 이것을 구현해 준다.
    func numberOfItems(for reuseableView: AllListReusableView, numberOfItemsInSection section: Int) -> Int {
        print(modelList?.count, "🧐🧐🧐🧐🧐🧐🧐🧐")
        return modelList?.count ?? 0
    }
    
    func cellForItemAt(for reuseableView: AllListReusableView, colletionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = colletionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseableIdentiFier, for: indexPath) as? HeaderCell else {
            fatalError("왜 안될까 진짜 왜 안될까 왜 ㅗ왜 왜오애ㅗ애ㅗ애ㅗ애ㅗ애ㅗ애ㅗㅇ")
        }
        let imageString = modelList?[indexPath.item].backdrop_path
        let url = ImageManager.getImage(imageCase: .trend, image: imageString ?? "")
        
        cell.setImage(image: url)
        
        return cell
    }
    // 5.3 구현이 완료되었다면 이걸 구현하시는분이 야! 내가 구현했다 임마 를 시전해야한다.
    // 위로 올라와 보거라
    
}
