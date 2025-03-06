import UIKit

import SnapKit
import Then

protocol CourseNavigationBarViewDelegate: AnyObject {
    
    func didTapAddCourseButton()
    
}

final class CourseNavigationBarView: BaseView {
    
    // MARK: - UI Properties

    private let courseLabel = UILabel()
    
    private let addCourseButton: DRImageButton = DRImageButton(image: UIImage(resource: .plusSchedule), buttonName: .med_purple_15)
    
    
    // MARK: - Properties
    
    weak var delegate: CourseNavigationBarViewDelegate?
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(courseLabel, addCourseButton)
    }
    
    override func setLayout() {
        courseLabel.snp.makeConstraints {
            $0.centerY.equalTo(addCourseButton)
            $0.leading.equalToSuperview().inset(16)
        }
        
        addCourseButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(44)
            $0.height.equalTo(30)
        }
    }
    
    override func setStyle() {
        courseLabel.setLabel(text: StringLiterals.Course.course,
                             textColor: UIColor(resource: .drBlack),
                             font: UIFont.suit(.title_bold_20))
        
        addCourseButton.addTarget(self, action: #selector(didTapAddCourseButton), for: .touchUpInside)
    }
    
    @objc
    func didTapAddCourseButton() {
        delegate?.didTapAddCourseButton()
    }
    
}

