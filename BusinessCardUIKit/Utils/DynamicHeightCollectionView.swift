//
//  DynamicHeightCollectionView.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 06.03.2024.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()

        guard !CGSizeEqualToSize(bounds.size, intrinsicContentSize)
        else { return }

        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
