//
//  SkillCell.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 05.03.2024.
//

import UIKit

class SkillCell: UICollectionViewCell {
    // MARK: - UIConstants
    private enum UIConstants {
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 24
        
        static let cornerRadius: CGFloat = 12
        
        static let buttonWidth: CGFloat = 16
    }
    // MARK: - Properties
    static let reuseIdentifier: String = String(describing: SkillCell.self)
    var onDeleteTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = AppFonts.skills
//                label.adjustsFontSizeToFitWidth = true
//                label.minimumScaleFactor = 0.8
//                label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    // MARK: - Functions
    func configure(skill: SkillModel, isEditMode: Bool) {
        contentView.layoutIfNeeded()

        titleLabel.text = skill.name
        titleLabel.invalidateIntrinsicContentSize()

        deleteButton.isHidden = !isEditMode
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.verticalPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.horizontalPadding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIConstants.verticalPadding),
            
            deleteButton.widthAnchor.constraint(equalToConstant: UIConstants.buttonWidth),
            deleteButton.heightAnchor.constraint(equalToConstant: UIConstants.buttonWidth),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.verticalPadding),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.horizontalPadding)
        ])
    }
    
    private func setupStyle() {
        contentView.backgroundColor = AppColors.background
        contentView.layer.cornerRadius = UIConstants.cornerRadius
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deleteButtonTapped() {
        
    }
}
