import UIKit

final class DeleteCourseSettingView: BaseView {
    
    // MARK: - UI Properties
        
    let titleLabel: DRTextLabel = DRTextLabel(title: StringLiterals.CourseDetail.settingDateCourse, textLabelType: .clear(.bold18_black))
    
    let optionButton: DRTextButton = DRTextButton(title: "", buttonName: .semi_white_0)
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(titleLabel, optionButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.height.equalTo(25)
            $0.horizontalEdges.equalToSuperview()
        }
        
        optionButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
    }

}

