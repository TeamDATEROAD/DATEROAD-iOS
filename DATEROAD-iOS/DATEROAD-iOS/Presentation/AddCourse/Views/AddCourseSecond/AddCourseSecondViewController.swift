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
      registerCell()
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

extension AddCourseSecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   private func registerCell() {
      addCourseSecondView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
         $0.delegate = self
         $0.dataSource = self
      }
      addCourseSecondView.collectionView2.do {
         $0.register(AddSecondViewCollectionViewCell.self, forCellWithReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier)
         $0.delegate = self
         $0.dragDelegate = self
         $0.dropDelegate = self
         $0.dataSource = self
         $0.dragInteractionEnabled = true
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
      collectionView == addCourseSecondView.collectionView ? false : true
   }
       
   func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if collectionView == addCourseSecondView.collectionView {
         return viewModel.getSampleImages() ? 1 : viewModel.dataSource.count
      } else {
         return viewModel.tableViewDataSource.count
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == addCourseSecondView.collectionView {
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
            for: indexPath
         ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
         
         let isImageEmpty = viewModel.isImageEmpty.value ?? true
         isImageEmpty ? cell.updateImageCellUI(isImageEmpty: isImageEmpty, image: nil)
         : cell.updateImageCellUI(isImageEmpty: isImageEmpty, image: self.viewModel.dataSource[indexPath.item])
         
         return cell
      } else {
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddSecondViewCollectionViewCell.cellIdentifier,
            for: indexPath
         ) as? AddSecondViewCollectionViewCell else { return UICollectionViewCell() }
         
         cell.configure(model: viewModel.tableViewDataSource[indexPath.item])
         
         return cell
      }
   }
}

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
         if
            let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates({
               let temp = viewModel.tableViewDataSource[sourceIndexPath.item]
               viewModel.tableViewDataSource.remove(at: sourceIndexPath.item)
               viewModel.tableViewDataSource.insert(temp, at: destinationIndexPath.item)
               collectionView.deleteItems(at: [sourceIndexPath])
               collectionView.insertItems(at: [destinationIndexPath])
            }) { done in
               //
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
         }
      }
   }
}

extension AddCourseSecondViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
}
