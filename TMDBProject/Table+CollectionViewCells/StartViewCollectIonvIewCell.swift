/*
 이미지 뷰 하나ㅗ만 여길 처리할까 말까일단 다쓰고 안쓰면 안보이게 하면 될것 같긴한데
 */
import UIKit
import SnapKit

class StartViewCollectIonvIewCell : UICollectionViewCell {
    
    static var reuseIdentifier : String {
        return String(describing: self)
    }
    
    let imageView = UIImageView()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    func configureLayout(){
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(imageView)
            make.height.equalTo(24)
        }
    }
    func designView(){
        
    }
    
}


