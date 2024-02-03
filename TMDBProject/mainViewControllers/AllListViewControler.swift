//
//  SearchListViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit

class AllListViewControler: AllListBaseViewController {
    
    let allListHomeView = AllListView()
    
    override func loadView() {
        self.view = allListHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}
