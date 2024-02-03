

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
            // print(model)
            // print(model?.count)
            allListHomeView.listCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            return UICollectionViewCell()
        }
        if let image = modelList?[indexPath.item].poster_path {
            let url = ImageManager.getImage(imageCase: .trend, image: image)
            cell.prepare(image: url, title: nil)
        }
        if let name = modelList?[indexPath.item].name {
            cell.prepare(image: nil, title: name)
        }
        
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AllListReusableView.reuseableIdentiFier, for: indexPath) as? AllListReusableView {
            reusableView.collectionView.backgroundColor = .cyan
            return reusableView
        }
        return UICollectionReusableView()
    }

}

extension AllListViewControler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
}


