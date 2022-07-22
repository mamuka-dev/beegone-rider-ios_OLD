 
import UIKit

extension UICollectionView {
    
    func returnVisibleCellsIndexes() -> [IndexPath] {
        var indexes = [IndexPath]()
        for cell in self.visibleCells {
            if let indexpath = self.returnIndexPath(cell: cell) {
                indexes.append(indexpath)
            }
        }
        return indexes
    }
    
    func returnIndexPath(cell: UICollectionViewCell) -> IndexPath?{
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }
        return indexPath
    }
    
    func returnVisibleCells() -> [UICollectionViewCell]{
        let visiblecell = self.visibleCells
        return visiblecell
    }
    
}

