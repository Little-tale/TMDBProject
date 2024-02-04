

import UIKit
/*
 여기는 이제 페이지 네이션을 다시 연습하기 위해서
 page 넘버를 쿼리 파라미터로 요청해야하닌 좀 뭔가 이 페이지를 위한 API METHOD 연기를 해보아야 할것같다.
 */

class AllListViewControler: AllListBaseViewController {
    
    let allListHomeView = AllListView()
    
    override func loadView() {
        self.view = allListHomeView
        self.view.backgroundColor = .black
    }
    var modelList: [Searchs]? = [] {
        didSet {
            print("값이 넘어옴")
            self.allListHomeView.listCollectionView.reloadData()
        }
    }
    var APIStyles : TMDBAPI? {
        didSet{
            print("에이피아이 받았어요!")
            ApiRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        allListHomeView.listCollectionView.dataSource = self
        allListHomeView.listCollectionView.delegate = self
        allListHomeView.reuseableView.collectionView.delegate = self
       
       
    }
    func ApiRequest(){
        TMDBAPIManager.shared.fetchSearchView(type: SearchModel.self, api: APIStyles ?? .top(language: .kor)) { searchModel in
            self.modelList?.append(contentsOf: searchModel.results)
        }
    }
}

extension AllListViewControler: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return modelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseableIdentiFier, for: indexPath) as? StartViewCollectIonvIewCell else {
            print("레지스터 문제")
            return UICollectionViewCell()
        }
        cell.backgroundColor = .brown
        
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
           
            print("여긴되니?")
            // reusableView.myProtocol = self
            
            return reusableView
        }
        return UICollectionReusableView()
    }

}

extension AllListViewControler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
    
}





//extension AllListViewControler: collectionReuseProtocl {
//    func numberOfSectionForReuse(reusableView: AllListReusableView, section: Int) -> Int {
//        print(modelList?.count)
//        return modelList?.count ?? 0
//    }
//    
//    func whereIndexOf(reusalveView: AllListReusableView, colletionView: UICollectionView, index: IndexPath) -> UICollectionViewCell {
//        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseableIdentiFier, for: index) as! HeaderCell
//        
//        let urlString = modelList?[index.row].backdrop_path
//        let url = ImageManager.getImage(imageCase: .trend, image: urlString ?? "")
//        cell.setImage(image: url)
//        print("동작 되는가?")
//        return cell
//    }
//    
//    
//}

