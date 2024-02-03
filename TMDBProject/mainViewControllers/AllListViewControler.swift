

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
            print(modelList?.count)
            DispatchQueue.main.async {
                self.allListHomeView.listCollectionView.reloadData()
                print("디스페치 시점 ",self.modelList?.count)
                print("리로드 시도")
                self.testList = self.modelList!
            }
        }
    }
    var testList: [Searchs] = [] {
        didSet {
            print("값 받아옴")
            self.allListHomeView.listCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        allListHomeView.listCollectionView.dataSource = self
        allListHomeView.listCollectionView.delegate = self
        allListHomeView.reuseableView.collectionView.delegate = self
        print("뷰 디드 로드 시점", modelList?.count)
//        DispatchQueue.main.async {
//            self.allListHomeView.listCollectionView.reloadData()
//        }
        
        
    }
}

extension AllListViewControler: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // print("리로드 문제",modelList)
        // modelList?.count
        // fatalError("추적해야겠음")
        print(testList)
        return testList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row )
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseableIdentiFier, for: indexPath) as? StartViewCollectIonvIewCell else {
            print("레지스터 문제")
            return UICollectionViewCell()
        }
        print("레지스터 등록 되서 넘어온거지? ")
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


