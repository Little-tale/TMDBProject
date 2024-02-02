
/*
 해당 뷰에서 쓸것.
 1. 서치바
 2. 테이블뷰 ->
 
 */

import UIKit

class StartViewController: StartBaseViewController {

    let startView = StartView()
    var data : [Int: Searchs] = [:]
    
    override func loadView() {
        self.view = startView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegateDataSource()
        /// 서치 됨. 탑 됨, pop안됨 -> 트렌드 안됨 -> 모두 해결돰
        
        let group = DispatchGroup()
        
        TMDBAPIManager.shared.fetchSearchView(api: .popular(language: .kor))
    }
    
}



// MARK: TableViewDelegate, DataSource

extension StartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StartViewControllerTableCell.getIdentifier, for: indexPath) as! StartViewControllerTableCell
        
        cell.startCollectionView.dataSource = self
        cell.startCollectionView.delegate = self
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCollectIonvIewCell.reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = .red
        return cell
        
    }
    
    
}
