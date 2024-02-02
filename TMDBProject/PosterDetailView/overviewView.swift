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
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(8)
            make.leading.equalTo(self).inset(8)
            make.height.equalTo(32)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.height.equalTo(24)
            make.leading.equalTo(nameLabel.snp.trailing).inset(4)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        overViewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nameLabel)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.top.equalTo(nameLabel.snp.bottom)
        }
    }
    override func designView() {
        
    }
    
    
}
