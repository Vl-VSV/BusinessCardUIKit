//
//  ProfileView.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 04.03.2024.
//

import UIKit

final class ProfileView: UIViewController {
    // MARK: - UIConstants
    private enum UIConstants {
        static let imageHeight: CGFloat = 120
        static let imageWidth: CGFloat = 120
        
        static let cellCornerRadius: CGFloat = 12
        static let addButtonSize: CGFloat = 44
        static let deleteButtonSize: CGFloat = 14
        
        static let profileImageTopPadding: CGFloat = 24
        static let nameLabelTopPadding: CGFloat = 16
        static let sloganLabelTopPadding: CGFloat = 4
        
        static let skillsHeaderTopPadding: CGFloat = 40
        static let skillsHeaderHorizontalPadding: CGFloat = 16
        static let skillsHeaderHeight: CGFloat = 24
        
        static let skillsCollectionTopPadding: CGFloat = 20
        static let skillsCollectionHorizontalPadding: CGFloat = 16
        
        static let aboutMeLabelTopPadding: CGFloat = 24
        static let aboutStackHorizontalPadding: CGFloat = 16
        
        static let aboutMeTextTopPadding: CGFloat = 8
        static let aboutMeTextHorizontalPadding: CGFloat = 16
    }
    
    // MARK: - Properties
    var presenter: ProfilePresenting!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupSubviews()
    }
    
    // MARK: - View Properties
    private let scrollContainerView = UIView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.text = "profile".localized
        label.font = AppFonts.title2
        return label
    }()
    
    private let profileBGView: UIView  = {
        let uiView = UIView()
        uiView.backgroundColor = AppColors.background
        return uiView
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView(image: AppImages.profile)
        image.layer.cornerRadius = UIConstants.imageHeight / 2.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.title
        label.text = "name".localized
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let sloganLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = AppFonts.subtitle
        label.textColor = AppColors.tertiary
        label.text = "experience".localized
        return label
    }()
    
    private let locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        let label = UILabel()
        let image = UIImageView(image: AppImages.mapPin)
        
        label.text = "town".localized
        label.textColor = AppColors.tertiary
        label.numberOfLines = 1
        label.font = AppFonts.subtitle
        
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(label)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 16),
            image.heightAnchor.constraint(equalToConstant: 16),
            image.centerYAnchor.constraint(equalTo: stack.centerYAnchor)
        ])
        return stack
    }()
    
    private lazy var skillsHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        let label = UILabel()
        label.text = "skills".localized
        label.font = AppFonts.title2
        
        let button = UIButton()
        button.setImage(AppImages.pencil, for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        return stack
    }()
    
    private lazy var skillsCollection: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SkillCell.self, forCellWithReuseIdentifier: SkillCell.reuseIdentifier)
        collectionView.register(AddCell.self, forCellWithReuseIdentifier: AddCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.title2
        label.text = "about me".localized
        
        return label
    }()
    
    private let aboutMeText: UILabel = {
        let textView = UILabel()
        textView.font = AppFonts.subtitle
        textView.numberOfLines = 0
        textView.text = "about".localized
        
        return textView
    }()
    
    // MARK: - Functions
    func updateCollection() {
        skillsCollection.reloadData()
    }
    
    @objc private func editButtonTapped() {
        presenter.changeEditMode()
    }
    
    private func addButtonTapped() {
        showNewSkillAlert()
    }
    
    private func showNewSkillAlert() {
        let alert = UIAlertController(title: "adding skill".localized, message: "enter skill".localized, preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "add".localized, style: .default) { action in
            self.presenter.addSkill(SkillModel(name: textField.text ?? "new skill".localized))
        }
        let secondAction = UIAlertAction(title: "cancel".localized, style: .destructive)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "enter title".localized
            textField = alertTextField
        }
        
        alert.addAction(secondAction)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    private func setupSubviews() {
        scrollContainerView.addSubview(profileBGView)
        scrollContainerView.addSubview(titleView)
        scrollContainerView.addSubview(profileImage)
        scrollContainerView.addSubview(nameLabel)
        scrollContainerView.addSubview(sloganLabel)
        scrollContainerView.addSubview(locationStack)
        scrollContainerView.addSubview(skillsCollection)
        scrollContainerView.addSubview(skillsHeader)
        scrollContainerView.addSubview(aboutMeLabel)
        scrollContainerView.addSubview(aboutMeText)
        
        scrollView.addSubview(scrollContainerView)
        
        view.addSubview(scrollView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        locationStack.translatesAutoresizingMaskIntoConstraints = false
        skillsCollection.translatesAutoresizingMaskIntoConstraints = false
        skillsHeader.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeText.translatesAutoresizingMaskIntoConstraints = false
        profileBGView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollContainerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileBGView.topAnchor.constraint(equalTo: view.topAnchor),
            profileBGView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor),
            profileBGView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor),
            profileBGView.bottomAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 20),
            
            titleView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 24),
            titleView.centerXAnchor.constraint(equalTo: scrollContainerView.centerXAnchor),
            
            profileImage.widthAnchor.constraint(equalToConstant: UIConstants.imageWidth),
            profileImage.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),
            profileImage.centerXAnchor.constraint(equalTo: scrollContainerView.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: UIConstants.profileImageTopPadding),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: UIConstants.nameLabelTopPadding),
            nameLabel.centerXAnchor.constraint(equalTo: scrollContainerView.centerXAnchor),
            
            sloganLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIConstants.sloganLabelTopPadding),
            sloganLabel.centerXAnchor.constraint(equalTo: scrollContainerView.centerXAnchor),
            
            locationStack.centerXAnchor.constraint(equalTo: scrollContainerView.centerXAnchor),
            locationStack.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor),
            
            skillsHeader.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: UIConstants.skillsHeaderTopPadding),
            skillsHeader.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: UIConstants.skillsHeaderHorizontalPadding),
            skillsHeader.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -UIConstants.skillsHeaderHorizontalPadding),
            skillsHeader.heightAnchor.constraint(equalToConstant: UIConstants.skillsHeaderHeight),
            
            skillsCollection.topAnchor.constraint(equalTo: skillsHeader.bottomAnchor, constant: UIConstants.skillsCollectionTopPadding),
            skillsCollection.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: UIConstants.skillsCollectionHorizontalPadding),
            skillsCollection.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -UIConstants.skillsCollectionHorizontalPadding),
            
            aboutMeLabel.topAnchor.constraint(equalTo: skillsCollection.bottomAnchor, constant: UIConstants.aboutMeLabelTopPadding),
            aboutMeLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),

            aboutMeText.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: UIConstants.aboutMeTextTopPadding),
            aboutMeText.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: UIConstants.aboutMeTextHorizontalPadding),
            aboutMeText.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -UIConstants.aboutMeTextHorizontalPadding),
            aboutMeText.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor)
        ])
    }
}

extension ProfileView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.isEditMode ? presenter.skills.count + 1 : presenter.skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if presenter.isEditMode, indexPath.row == presenter.skills.count {
            return getAddCell(collectionView: self.skillsCollection, indexPath: indexPath)
        } else {
            return getSkillCell(collectionView: self.skillsCollection, indexPath: indexPath)
        }
    }
    
    private func getAddCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCell.reuseIdentifier,
            for: indexPath
        ) as? AddCell else { return UICollectionViewCell() }
        
        cell.onTap = { [weak self] in
            self?.addButtonTapped()
        }
        
        return cell
    }
    
    private func getSkillCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SkillCell.reuseIdentifier,
            for: indexPath
        ) as? SkillCell else { return UICollectionViewCell() }
        
        cell.configure(skill: presenter.skills[indexPath.row], isEditMode: presenter.isEditMode)
        cell.onDeleteTapped = { [weak self] in
            self?.presenter.deleteSkill(index: indexPath.row)
        }
        
        return cell
    }
}

extension ProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if presenter.isEditMode, indexPath.row == presenter.skills.count {
            return CGSize(width: UIConstants.addButtonSize, height: UIConstants.addButtonSize)
        }
        let skill = presenter.skills[indexPath.item]
        let textWidth = skill.name.size(withAttributes: [.font: AppFonts.subtitle]).width + (presenter.isEditMode ? 72 : 50)
        let cellWidth = min(textWidth, view.frame.width - 48)
        return CGSize(width: cellWidth, height: 44)
    }
}
