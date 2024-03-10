//
//  AddCell.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 05.03.2024.
//

import UIKit

class AddCell: UICollectionViewCell {
    // MARK: - UIConstants
    private enum UIConstants {
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 24
        
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Properties
    static let reuseIdentifier: String = String(describing: AddCell.self)
    var onTap: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Properties
    private let addSkillButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    
    // MARK: - Functions
    private func setup() {
        setupLayout()
        setupStyle()
        
        addSkillButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        contentView.addSubview(addSkillButton)
        
        addSkillButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addSkillButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addSkillButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupStyle() {
        contentView.backgroundColor = AppColors.background
        contentView.layer.cornerRadius = UIConstants.cornerRadius
    }
    
    @objc func addButtonTapped() {
        onTap?()
    }
}
