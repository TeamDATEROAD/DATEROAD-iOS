//
//  SearchPlaceView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import UIKit

protocol SearchPlaceDelegate: AnyObject {
    
    func didTapBackground()
    
    func didTapCloseButton()
    
    func didTapClearButton()
    
    func editSearchPlaceTextField()
    
}

final class SearchPlaceView: BaseView {
    
    // MARK: - UI Properties
    
    private let titleLabel: DRTextLabel = DRTextLabel(title: StringLiterals.SearchPlace.title, textLabelType: .clear(.bold17_black))
    
    private let closeButton: DRImageButton = DRImageButton(image: UIImage(resource: .btnClose), buttonName: .white_gray600_0)
    
    let searchPlaceTextField: DRTextField = DRTextField(type: .searchPlace)
    
    lazy var placeTableView: UITableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var placeEmptyView: CustomEmptyView = CustomEmptyView(height: 341)
    
    
    // MARK: - UI Properties
    
    weak var delegate: SearchPlaceDelegate?
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerCell()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            titleLabel,
            closeButton,
            searchPlaceTextField,
            placeTableView,
            placeEmptyView
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.height.equalTo(40)
            $0.leading.equalToSuperview().inset(25)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(40)
        }
        
        searchPlaceTextField.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        placeTableView.snp.makeConstraints {
            $0.top.equalTo(searchPlaceTextField.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        placeEmptyView.snp.makeConstraints {
            $0.top.equalTo(searchPlaceTextField.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        }
        
        placeTableView.do {
            $0.separatorStyle = .singleLine
            $0.rowHeight = 75
            $0.separatorColor = UIColor.gray100
        }
        
        placeEmptyView.do {
            $0.setEmptyView(emptyImage: .emptySearchPlace, emptyTitle: StringLiterals.EmptyView.emptySearchPlace)
            $0.isHidden = true
        }
    }
    
}


// MARK: - Update UI Methods

extension SearchPlaceView {

    func updatePlaceView(_ isEmpty: Bool) {
        placeTableView.isHidden = isEmpty
        placeEmptyView.isHidden = !isEmpty
    }
    
}


// MARK: - Private Methods

private extension SearchPlaceView {

    func registerCell() {
        placeTableView.register(SearchPlaceTableViewCell.self, forCellReuseIdentifier: SearchPlaceTableViewCell.cellIdentifier)
    }
    
    func setAddTarget() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        self.addGestureRecognizer(gesture)
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        if let button = searchPlaceTextField.rightView {
            print("rightView")
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapClearButton))
            button.addGestureRecognizer(gesture)
        }
        
        searchPlaceTextField.addTarget(self, action: #selector(editSearchPlaceTextField), for: .editingChanged)
    }
    
}


// MARK: - @objc Methods

private extension SearchPlaceView {

    @objc
    func didTapBackground() {
        delegate?.didTapBackground()
    }
    
    @objc
    func didTapCloseButton() {
        delegate?.didTapCloseButton()
    }
    
    @objc
    func didTapClearButton() {
        print("didTapClearButton")
        delegate?.didTapClearButton()
    }
 
    @objc
    func editSearchPlaceTextField() {
        delegate?.editSearchPlaceTextField()
    }
    
}
