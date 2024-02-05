/*
 이미지 뷰 하나ㅗ만 여길 처리할까 말까일단 다쓰고 안쓰면 안보이게 하면 될것 같긴한데
 */
import UIKit
import SnapKit
import Kingfisher

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
            make.center.equalTo(imageView)
            make.horizontalEdges.equalTo(imageView).inset(8)
            make.height.equalTo(40)
        }
    }
    func designView(){
        imageView.tintColor = .darkGray
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.layer.cornerRadius = 8
        titleLabel.clipsToBounds = true
    }
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.cornerRadius = (self.frame.width + self.frame.height) / 16
        self.clipsToBounds = true
    }
    
    // 재사용 이슈 막기
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.backgroundColor = .clear
        prepare(image: nil, title: nil)
        prepareCrewPoster(image: nil, title: nil)
    }
    func prepare(image : URL?, title: String?) {
        layoutOne()
        
        guard let image = image else {
            titleLabel.text = title
            self.backgroundColor = .darkGray
            imageView.image = nil
            return
        }
        // .forceTransition 때문에 이미지가 자꾸 깜빡인거임 할필요 없었을때도 ㅠㅠ
        
        imageView.kf.setImage(with: image,
                              placeholder:.none ,
                              options:[
                                .transition(.fade(0.5))//,
                                //.forceTransition
                              ])
        
    }
    
    func prepareCrewPoster(image : URL?, title: String?) {
        layoutTwo()
        if let image = image {

            imageView.kf.setImage(with: image,
                                  placeholder:.none ,
                                  options:[
                                    .transition(.fade(0.5))])
        } else {
            imageView.image = UIImage(systemName: "person.fill")
            imageView.tintColor = .gray
        }
        titleLabel.text = title
        titleLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
    }
    // MARK: 특정상황에서 유동적으로 레이아웃 잡을때는 remakeConstraints 를 이용해야함 기억하도록
    func layoutOne() {
        titleLabel.snp.remakeConstraints { make in
            make.center.equalTo(imageView)
            make.horizontalEdges.equalTo(imageView).inset(8)
            make.height.equalTo(40)
        }
        self.titleLabel.textColor = .white
        self.titleLabel.backgroundColor = .clear

    }
    
    func layoutTwo() {
        titleLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom)
            make.horizontalEdges.equalTo(imageView).inset(8)
            make.height.equalTo(24)
        }
        self.titleLabel.textColor = .black
    }
}


