/*
 주의사항
 세로가 더길면 안이뻐지니 가로에서 사용하도록 합시다.
 */

import UIKit
import SnapKit

class overviewView: BaseView {
    let overViewLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    
    override func configureHierarchy() {
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
        self.addSubview(overViewLabel)
    
    }
    override func configureLayout() {
        overViewLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(overViewLabel.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide).inset(12)
            make.top.equalTo(safeAreaLayoutGuide)
//            make.width.greaterThanOrEqualTo(80)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.trailing.greaterThanOrEqualTo(safeAreaLayoutGuide)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.bottom.equalTo(overViewLabel.snp.top)
            
        }
    }
    override func designView() {
        overViewLabel.backgroundColor = .brown
        nameLabel.backgroundColor = .cyan
        overViewLabel.backgroundColor = .blue
        overViewLabel.text = "시퍼런색"
        overViewLabel.numberOfLines = 4
        nameLabel.text = "파랑색dpdpdpdpdp"
        dateLabel.text = "깜징"
        dateLabel.backgroundColor = .black
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
}
