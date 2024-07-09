//
//  AddCourseSecondViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

class AddCourseSecondViewController: BaseNavBarViewController {
   private var addCourseSecondView = AddCourseSecondView()
   private let viewModel: AddCourseViewModel
   
   init(viewModel: AddCourseViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedul.addCourseTitle)
      setLeftBackButton()
//      setAddTarget()
      registerCell()
//      bindViewModel()
   }
   
   // MARK: - Methods
   
   override func setHierarchy() {
      super.setHierarchy()
      
      self.view.addSubview(contentView)
      contentView.addSubview(addCourseSecondView)
   }
   
   override func setLayout() {
      super.setLayout()
      
      addCourseSecondView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.equalToSuperview()
         $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
      }
   }
   
   override func setStyle() {
      super.setStyle()
      
      addCourseSecondView.do {
         $0.isUserInteractionEnabled = true
      }
   }
}

extension AddCourseSecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   private func registerCell() {
      addCourseSecondView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
         $0.delegate = self
         $0.dataSource = self
      }
   }
   
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
