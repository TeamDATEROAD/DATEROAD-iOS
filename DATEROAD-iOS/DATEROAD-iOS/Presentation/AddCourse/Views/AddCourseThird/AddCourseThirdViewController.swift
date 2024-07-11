//
//  AddCourseThirdViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class AddCourseThirdViewController: BaseNavBarViewController {
   
   // MARK: - UI Properties
   
   private var addCourseThirdView = AddCourseThirdView()
   
   private let viewModel: AddCourseViewModel
   
   
   // MARK: - Initializer
   
   init(viewModel: AddCourseViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK: - LifeCycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedul.addCourseTitle, alignment: .center)
      setLeftBackButton()
//      setAddTarget()
      setDelegate()
      registerCell()
//      bindViewModel()
      setupKeyboardDismissRecognizer()
   }
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      super.setHierarchy()
      
      self.view.addSubview(contentView)
      contentView.addSubview(addCourseThirdView)
   }
   
   override func setLayout() {
      super.setLayout()
      
      addCourseThirdView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.equalToSuperview()
         $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
      }
   }
   
   override func setStyle() {
      super.setStyle()
      
      //3으로 변경 예정
      addCourseThirdView.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
}


// MARK: - ViewController Methods

extension AddCourseThirdViewController {
   
   private func registerCell() {
      addCourseThirdView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
      }
   }
   
   private func setDelegate() {
      addCourseThirdView.collectionView.do {
         $0.delegate = self
         $0.dataSource = self
      }
   }
   
}


// MARK: - UITextFieldDelegate Methods

extension AddCourseThirdViewController: UITextFieldDelegate {
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      textField.tintColor = UIColor.clear
      return true
   }
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return true
   }
   
   func textFieldDidEndEditing(_ textField: UITextField) {
//      viewModel.datePlace.value = textField.text
      print(textField.text)
   }
   
   
   
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate Methods

extension AddCourseThirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel.getSampleImages() ? 1 : viewModel.dataSource.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
            for: indexPath
         ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
         
         let isImageEmpty = viewModel.isImageEmpty.value ?? true
         isImageEmpty ? cell.updateImageCellUI(isImageEmpty: isImageEmpty, image: nil)
         : cell.updateImageCellUI(isImageEmpty: isImageEmpty, image: self.viewModel.dataSource[indexPath.item])
         
         return cell
   }
}
