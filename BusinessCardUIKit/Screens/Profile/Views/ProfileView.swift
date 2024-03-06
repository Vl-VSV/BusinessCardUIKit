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
    }
    
    // MARK: - Properties
    var presenter: ProfilePresenter!
    
    private var isEditMode: Bool = false
    private var skills: [SkillModel] = Constants.defaultSkills
    
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
        label.font = .boldSystemFont(ofSize: 18)
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
        return stack
    }()
    
    private let skillsHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        let label = UILabel()
        label.text = "skills".localized
        label.font = AppFonts.skills
        
        let image = UIImageView(image: AppImages.pencil)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(image)
        
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
        label.font = AppFonts.skills
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

            aboutMeText.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
            aboutMeText.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            aboutMeText.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            aboutMeText.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor)
        ])
    }
}

extension ProfileView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isEditMode ? skills.count + 1 : skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEditMode, indexPath.row == skills.count {
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
        
        cell.onTap = {}
        
        return cell
    }
    
    private func getSkillCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SkillCell.reuseIdentifier,
            for: indexPath
        ) as? SkillCell else { return UICollectionViewCell() }
        
        cell.configure(skill: skills[indexPath.row], isEditMode: isEditMode)
        cell.onDeleteTapped = {}
        
        return cell
    }
}

extension ProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isEditMode, indexPath.row == skills.count {
            return CGSize(width: UIConstants.addButtonSize, height: UIConstants.addButtonSize)
        }
        let skill = skills[indexPath.item]
        let textWidth = skill.name.size(withAttributes: [.font: AppFonts.skills]).width + (isEditMode ? 72 : 50)
        let cellWidth = min(textWidth, view.frame.width - 48)
        return CGSize(width: cellWidth, height: 44)
    }
}

#Preview {
    ProfileView()
}
