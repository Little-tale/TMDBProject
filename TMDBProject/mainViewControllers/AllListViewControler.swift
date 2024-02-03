

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        allListHomeView.listCollectionView.dataSource = self
        allListHomeView.listCollectionView.delegate = self
        allListHomeView.reuseableView.collectionView.delegate = self
       
       
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

