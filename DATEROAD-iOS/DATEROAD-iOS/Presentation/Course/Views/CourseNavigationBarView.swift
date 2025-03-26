import UIKit

import SnapKit
import Then

protocol CourseNavigationBarViewDelegate: AnyObject {
    
    func didTapAddCourseButton()
    
}

final class CourseNavigationBarView: BaseView {
    
    // MARK: - UI Properties

    private let courseLabel: DRTextLabel = DRTextLabel(title: StringLiterals.Course.course, textLabelType: .clear(.bold20_black))
    
    private let addCourseButton: DRImageButton = DRImageButton(image: UIImage(resource: .plusSchedule), buttonName: .deepPurple_white_15)
    
    
    // MARK: - Properties
    
    weak var delegate: CourseNavigationBarViewDelegate?
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
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
    
}


// MARK: - Methods

extension CourseNavigationBarView {
    
    func setAddTarget() {
        addCourseButton.addTarget(self, action: #selector(didTapAddCourseButton), for: .touchUpInside)
    }

}


// MARK: - @objc Methods {

extension CourseNavigationBarView {
    
    @objc
    func didTapAddCourseButton() {
        delegate?.didTapAddCourseButton()
    }
    
}
