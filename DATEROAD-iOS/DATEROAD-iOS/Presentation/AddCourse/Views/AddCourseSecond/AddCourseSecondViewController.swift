import UIKit

import SnapKit
import Then

final class AddCourseSecondViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private var addCourseSecondView = AddCourseSecondView()
    
    private let viewModel: AddCourseViewModel
    
    private var alertVC: AddSheetViewController?
    
    
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
        setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addCourseTitle, alignment: .center)
        setLeftBackButton()
        setAddTarget()
        setDelegate()
        registerCell()
        bindViewModel()
        pastDateBindViewModel()
        setupKeyboardDismissRecognizer()
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


// MARK: - Extension Methods

private extension AddCourseSecondViewController {
    
    func registerCell() {
        addCourseSecondView.collectionView.do {
            $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
        }
        
        addCourseSecondView.addPlaceCollectionView.do {
            $0.register(AddSecondViewCollectionViewCell.self, forCellWithReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier)
        }
    }
    
    func setDelegate() {
        addCourseSecondView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        
        addCourseSecondView.addPlaceCollectionView.do {
            $0.delegate = self
            $0.dragDelegate = self
            $0.dropDelegate = self
            $0.dataSource = self
        }
        
        [addCourseSecondView.addSecondView.datePlaceTextField,
         addCourseSecondView.addSecondView.timeRequireTextField].forEach { i in
            i.delegate = self
        }
    }
    
    //TODO: - 추후 데이트코스 공유 코스 등록 기능 살아날 시 수정해야함.
    // isBroughtData 변수 생성하여 AddSchedule과 동일하게 수행하도록 수정
    func pastDateBindViewModel() {
        if viewModel.pastDatePlaces.count > 0  {
            for i in viewModel.pastDatePlaces {
                if let doubleValue = Double(String(i.duration)) {
                    let text = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ?
                    String(Int(doubleValue)) : String(doubleValue)
                    viewModel.tapAddBtn(datePlace: i.name, timeRequire: "\(text) 시간")
                } else {
                    viewModel.tapAddBtn(datePlace: i.name, timeRequire: "\(String(i.duration)) 시간")
                }
            }
        }
    }
    
    func bindViewModel() {
        viewModel.isDataSourceNotEmpty()
        
        viewModel.editBtnEnableState.bind { [weak self] date in
            guard let date else {return}
            self?.addCourseSecondView.editBtnState(isAble: date)
        }
        
        viewModel.datePlace.bind { [weak self] date in
            guard let text = date else {return}
            self?.addCourseSecondView.addSecondView.updateDatePlace(text: text)
            self?.viewModel.dateLocation = true
            if let flag = self?.viewModel.isAbleAddBtn() {
                self?.addCourseSecondView.addSecondView.changeAddPlaceButtonState(flag: flag)
            }
        }
        
        viewModel.timeRequire.bind { [weak self] date in
            guard let date else {return}
            self?.addCourseSecondView.addSecondView.updatetimeRequire(text: date)
            self?.viewModel.dateSpendTime = true
            if let flag = self?.viewModel.isAbleAddBtn() {
                self?.addCourseSecondView.addSecondView.changeAddPlaceButtonState(flag: flag)
            }
        }
        
        self.viewModel.isChange = { [weak self] in
            self?.viewModel.isDataSourceNotEmpty()
            
            let state = self?.viewModel.editBtnEnableState.value ?? false
            
            self?.addCourseSecondView.editBtnState(isAble: state)
            
            // 텍스트필드 초기화 및 addPlace버튼 비활성화
            self?.addCourseSecondView.addSecondView.finishAddPlace()
            
            // 다음 버튼 활성화 여부 판별 함수
            self?.viewModel.isSourceMoreThanOne()
            self?.addCourseSecondView.addPlaceCollectionView.reloadData()
        }
        
        self.viewModel.isValidOfSecondNextBtn.bind { [weak self] date in
            self?.addCourseSecondView.addSecondView.changeNextBtnState(flag: date ?? false)
        }
        
    }
    
    func setAddTarget() {
        addCourseSecondView.editButton.addTarget(self, action: #selector(toggleEditMode), for: .touchUpInside)
        addCourseSecondView.addSecondView.addPlaceButton.addTarget(self, action: #selector(tapAddPlaceBtn), for: .touchUpInside)
        addCourseSecondView.addSecondView.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
    }
    
    
    // MARK: - @objc Methods
    
    @objc
    func textFieldTapped(_ textField: UITextField) {
        let alertVC = AddSheetViewController(viewModel: viewModel)
        alertVC.addSheetView = AddSheetView(isCustomPicker: true)
        
        self.alertVC = alertVC // alertVC를 인스턴스 변수에 저장
        addCourseSecondView.addSecondView.datePlaceTextField.resignFirstResponder()
        
        DispatchQueue.main.async {
            alertVC.presentBottomSheet(in: self)
        }
    }
    
    @objc
    func tapAddPlaceBtn() {
        viewModel.tapAddBtn(datePlace: viewModel.datePlace.value ?? "", timeRequire: viewModel.timeRequire.value ?? "")
    }
    
    @objc
    func didTapNextBtn() {
        print("지금 장소 등록된 값 : ", viewModel.addPlaceCollectionViewDataSource)
        
        let thirdVC = AddCourseThirdViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(thirdVC, animated: false)
    }
    
    @objc
    func removeCell(sender: UIButton) {
        guard let cell = sender.superview?.superview as? AddSecondViewCollectionViewCell,
              let indexPath = addCourseSecondView.addPlaceCollectionView.indexPath(for: cell) else { return }
        
        viewModel.addPlaceCollectionViewDataSource.remove(at: indexPath.item)
        addCourseSecondView.addPlaceCollectionView.deleteItems(at: [indexPath])
        viewModel.isSourceMoreThanOne()
        
        //여기서 datasource가 1개 미만이면
        let dataSourceCnt = viewModel.addPlaceCollectionViewDataSource.count
        if dataSourceCnt < 1 {
            cell.updateEditMode(flag: false)
            addCourseSecondView.updateEditBtnText(flag: false)
            addCourseSecondView.editBtnState(isAble: false)
            viewModel.isEditMode = false
        }
    }
    
    @objc
    func moveCell(sender: UIButton) {
        // Move cell logic here
    }
    
    @objc
    func toggleEditMode() {
        print("EditButton 눌림")
        viewModel.isEditMode.toggle()
        let collectionView = addCourseSecondView.addPlaceCollectionView
        
        let flag = viewModel.isEditMode
        print("현재 editButton editBtnEnableState.value 값 ::: \(flag)")
        
        collectionView.visibleCells.forEach { cell in
            if let customCell = cell as? AddSecondViewCollectionViewCell {
                customCell.updateEditMode(flag: flag)
                customCell.moveAbleButton.removeTarget(nil, action: nil, for: .allEvents)
                if flag {
                    customCell.moveAbleButton.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
                } else {
                    customCell.moveAbleButton.addTarget(self, action: #selector(moveCell(sender:)), for: .touchUpInside)
                }
            }
        }
        
        addCourseSecondView.updateEditBtnText(flag: flag)
        
        Dispatch.DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
}

extension AddCourseSecondViewController {
    
    @objc
    override func backButtonTapped() {
        viewModel.course2BackAmplitude()
        super.backButtonTapped()
    }
    
}


// MARK: - UITextFieldDelegate Methods

extension AddCourseSecondViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField != addCourseSecondView.addSecondView.timeRequireTextField {
            return true
        } else {
            textFieldTapped(textField)
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let trimmedText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let text = trimmedText, !text.isEmpty {
            viewModel.datePlace.value = text
            print(text)
        } else {
            viewModel.datePlace.value = ""
            print("공란")
        }
    }
    
}


// MARK: - UICollectionViewDelegate Methods

extension AddCourseSecondViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        collectionView == addCourseSecondView.collectionView ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
}


// MARK: - UICollectionViewDataSource Methods

extension AddCourseSecondViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == addCourseSecondView.collectionView {
            return viewModel.pickedImageArr.count
        } else {
            _ = (viewModel.addPlaceCollectionViewDataSource.count) < 1 ? true : false
            return viewModel.addPlaceCollectionViewDataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addCourseSecondView.collectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
            
            cell.updateImageCellUI(isImageEmpty: false, vcCnt: 2)
            cell.configurePickedImage(pickedImage: viewModel.pickedImageArr[indexPath.item])
            cell.prepare(image: viewModel.pickedImageArr[indexPath.item])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? AddSecondViewCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(model: viewModel.addPlaceCollectionViewDataSource[indexPath.item])
            cell.updateEditMode(flag: viewModel.isEditMode)
            cell.moveAbleButton.removeTarget(nil, action: nil, for: .allEvents)
            if viewModel.isEditMode {
                cell.moveAbleButton.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
            } else {
                cell.moveAbleButton.addTarget(self, action: #selector(moveCell(sender:)), for: .touchUpInside)
            }
            
            return cell
        }
    }
    
}


// MARK: - UICollectionViewDropDelegate Methods

extension AddCourseSecondViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if collectionView != addCourseSecondView.collectionView {
            var destinationIndexPath: IndexPath
            if let indexPath = coordinator.destinationIndexPath {
                destinationIndexPath = indexPath
            } else {
                let row = collectionView.numberOfItems(inSection: 0)
                destinationIndexPath = IndexPath(item: row - 1, section: 0)
            }
            
            if coordinator.proposal.operation == .move {
                reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView != addCourseSecondView.collectionView {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if collectionView != addCourseSecondView.collectionView {
            if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates({
                    let temp = viewModel.addPlaceCollectionViewDataSource[sourceIndexPath.item]
                    viewModel.addPlaceCollectionViewDataSource.remove(at: sourceIndexPath.item)
                    viewModel.addPlaceCollectionViewDataSource.insert(temp, at: destinationIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }) { done in
                    //
                }
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
            viewModel.updatePlaceCollectionView()
        }
    }
    
}


// MARK: - UICollectionViewDragDelegate Methods

extension AddCourseSecondViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
    
}



