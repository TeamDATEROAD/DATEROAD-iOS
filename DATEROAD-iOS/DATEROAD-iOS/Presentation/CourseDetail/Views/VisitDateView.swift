//
//  VisitDateView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class VisitDateView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let dateLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_gray400))
    
    
    // MARK: - Properties
    
    static let elementKinds: String = "visitDate"
    
    static let identifier: String = "VisitDateView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubview(dateLabel)
    }
    
    func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }
}

extension VisitDateView {
    
    func bindDate(titleHeaderData: TitleHeaderModel) {
        let dateString = titleHeaderData.date
        if let formattedDate = dateString.formatDateFromString(inputFormat: "yyyy.MM.dd", outputFormat: "yyyy년 M월 d일 방문") {
            dateLabel.text = formattedDate
        } else {
            print("날짜 포맷 변환에 실패했습니다.")
        }
    }
    
}
