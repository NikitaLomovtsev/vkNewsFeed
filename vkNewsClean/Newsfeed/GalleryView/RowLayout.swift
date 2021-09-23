//
//  RowLayout.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 21.09.2021.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: AnyObject{
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}
class RowLayout: UICollectionViewLayout{
    weak var delegate: RowLayoutDelegate!
    
    static var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    
    //constant
    fileprivate var contentHeight: CGFloat {
        
        guard let collectionView = collectionView else { return 0}
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        //REUSE
        contentWidth = 0
        cache = []
        //
        guard cache.isEmpty == true, let collectionView = collectionView  else { return }
        
        var photos = [CGSize]()
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0 )
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superviewWidth = collectionView.frame.size.width
        
        guard var rowHeight = RowLayout.rowHeightCounter(superviewWidth: superviewWidth, photosArray: photos) else { return }
        
        rowHeight = rowHeight / CGFloat(RowLayout.numbersOfRows)
        let photosRatios = photos.map({$0.height / $0.width})
        
        var yOffset = [CGFloat]()
        for row in 0..<RowLayout.numbersOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        
        var xOffset = [CGFloat](repeating: 0, count: RowLayout.numbersOfRows)
        
        var row = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            
            let ratio = photosRatios[indexPath.row]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            row = row < (RowLayout.numbersOfRows - 1) ? (row + 1) : 0
        }
    }
    
    static func rowHeightCounter(superviewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat?{
        var rowHeight: CGFloat
        
        let photoWithMinRation = photosArray.min(by: {$0.height / $0.width < $1.height / $1.width})
        
        guard let myPhotoWithMinRation = photoWithMinRation else { return nil}
        
        let difference = superviewWidth / myPhotoWithMinRation.width
        
        rowHeight = myPhotoWithMinRation.height * difference
        
        rowHeight = rowHeight * CGFloat(RowLayout.numbersOfRows)
        return rowHeight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache{
            if attribute.frame.intersects(rect){
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
