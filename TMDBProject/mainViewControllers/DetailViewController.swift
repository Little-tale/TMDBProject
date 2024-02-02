//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

class DetailViewController : DetailBaseView {
    
    let homeView = DetailView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }
}
