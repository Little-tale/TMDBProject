/*
 서치바
 테이블뷰
 
 */

import UIKit
import SnapKit

class StartView: BaseView {
    let searchBar = StarViewSearchBar()
    let trendTableView = UITableView()
   
    override func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(trendTableView)
    }
    
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        trendTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    override func designView() {
        // searchBar.backgroundColor = .red
        self.backgroundColor = .black
        trendTableView.backgroundColor = .blue
        register()
    }
   
    func register() {
        trendTableView.register(StartViewControllerTableCell.self,
                                forCellReuseIdentifier: StartViewControllerTableCell.getIdentifier)
        
    }
    
}
