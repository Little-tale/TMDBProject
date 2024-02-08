//
//  ProfileInfoTableCell.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import UIKit
import SnapKit
class ProfileInfoTableCell: BaseTableViewCell {
    
    let titlelabel = UILabel()
    let textField = UITextField()
    
    var inputTextField: ((String) -> Void)?
    
    override func configureHierarchy() {
        contentView.addSubview(titlelabel)
        contentView.addSubview(textField)
    }
    override func configureLayout() {
        titlelabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(120)
        }
        textField.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(titlelabel.snp.trailing)
        }
    }
    override func designView() {
        titlelabel.textColor = .white
        titlelabel.backgroundColor = .black
        textField.backgroundColor = .lightGray
        textField.textColor = .white
    }
    
    
}
