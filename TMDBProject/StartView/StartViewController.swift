
/*
 해당 뷰에서 쓸것.
 1. 서치바
 2. 테이블뷰 ->
 
 */

import UIKit

class StartViewController: StartBaseViewController {

    let startView = StartView()
    var data : [Int: [Searchs]] = [:]
    
    override func loadView() {
        self.view = startView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegateDataSource()
        /// 서치 됨. 탑 됨, pop안됨 -> 트렌드 안됨 -> 모두 해결돰
        
        let group = DispatchGroup()
        // MARK: 그니까 즉 여기서 타입을 적는 이유가 나 이거씀 을 명시 하기 위해서다 라는 것이다.
        group.enter()
        TMDBAPIManager.shared.fetchSearchView(type: SearchModel.self, api: .trend(type: .day, language: .kor)) { results in
            self.data[0] = results.results
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchSearchView(type: SearchModel.self, api: .top(language: .kor)) { results in
            self.data[1] = results.results
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchSearchView(type: SearchModel.self, api: .popular(language: .kor)) { results in
            self.data[2] = results.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.startView.trendTableView.reloadData()
        }
    }
    
}



// MARK: TableViewDelegate, DataSource

extension StartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StartViewControllerTableCell.getIdentifier, for: indexPath) as! StartViewControllerTableCell
        
        cell.startCollectionView.dataSource = self
        cell.startCollectionView.delegate = self
        cell.startCollectionView.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 3.7
    }
    
    func registerDelegateDataSource() {
        startView.trendTableView.dataSource = self
        startView.trendTableView.delegate = self
        
    }
    
}

// MARK: CollectionView Delegate, DataSource

extension StartViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[collectionView.tag]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath) as! StartViewCollectIonvIewCell
        
        let datas = data[collectionView.tag]?[indexPath.item]
        
        if let urlString = datas?.poster_path {
            let url = URL(string: ImageManager.baseImageUrl + urlString)
            cell.prepare(image: url , title: nil)
            return cell
        }
        
        cell.prepare(image: nil, title: datas?.name)
        
        // cell.backgroundColor = .red
        return cell
        
    }
    
    
}
