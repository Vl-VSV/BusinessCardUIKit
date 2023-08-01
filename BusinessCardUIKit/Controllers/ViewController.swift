//
//  ViewController.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var skillsArray = ["Swift", "iOS Development", "UI/UX Design", "C++", "Teamwork", "Unreal Engine", "SwiftUI/UIKit"]
    private var skillsCollectionViewHeightConstraint: NSLayoutConstraint!
    
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
        
        static let skillsStackTopPadding: CGFloat = 20
        static let skillsStackLeadingPadding: CGFloat = 16
        static let skillsStackTrailingPadding: CGFloat = -16
        static let skillsStackHeight: CGFloat = 24
        
        static let skillsCollectionViewTopPadding: CGFloat = 20
        static let skillsCollectionViewLeadingPadding: CGFloat = 16
        static let skillsCollectionViewTrailingPadding: CGFloat = -16
        
        static let aboutStackTopPadding: CGFloat = 24
        static let aboutStackLeadingPadding: CGFloat = 16
        static let aboutStackTrailingPadding: CGFloat = -16
        static let aboutStackBottomPadding: CGFloat = -358
        
        static let bottomViewTopPadding: CGFloat = 20
        static let bottomViewBottomPadding: CGFloat = 300
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPallete.background
        title = "Профиль"
        
        setupSubviews()
        
        skillsCollectionViewHeightConstraint = skillsCollectionView.heightAnchor.constraint(equalToConstant: calculateSkillsCollectionViewHeight())
        skillsCollectionViewHeightConstraint.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update skillsCollectionView height when the view layout changes
        skillsCollectionViewHeightConstraint.constant = calculateSkillsCollectionViewHeight()
    }
    
    // MARK: - View Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView(image: ImageAssets.profile)
        image.layer.cornerRadius = UIConstants.imageHeight / 2.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Воронин Владислав\nСергеевич"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let sloganLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14)
        label.textColor = ColorPallete.tertiary
        label.text = "IOS-developer, опыт более 1-го года"
        return label
    }()
    
    private let locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let locationImage: UIImageView = {
        let image = UIImageView(image: ImageAssets.mappin)
        return image
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Москва"
        label.textColor = ColorPallete.tertiary
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let skillsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Мои навыки"
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(ImageAssets.pencil, for: .normal)
        button.addTarget(self, action: #selector(editSkills), for: .touchUpInside)
        return button
    }()
    
    private lazy var skillsCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SkillCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AddButtonCell")

        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let aboutStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let aboutTitleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "О себе"
        return label
    }()
    
    private let aboutTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = """
                Я учусь на втором курсе РТУ МИРЭА на факультете “Программная инженерия”.
            
                Я - начинающий разработчик, интересующийся созданием мобильных приложений на платформе iOS, а также в разработкой игр в Unreal Engine.
            
                Я имею знания и опыт в языках программирования, таких как Python, Swift и С++, и стремлюсь к изучению новых технологий и развитию своих навыков. Я также увлекаюсь 3D-моделированием и имею опыт работы с программными пакетами, такими как Blender, Fusion 360 и 3D Studio Max. В свободное время я продолжаю изучать новые технологии и техники, а также увлекаюсь спортом, в частности я состою в сборной РТУ МИРЭА по бадминтону.
            """
        return textView
    }()
    
    
    // MARK: - Setup Functions
    // MARK: - Setup Functions
    private func setupSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(profileImage)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(sloganLabel)
        scrollView.addSubview(locationStack)
        
        bottomView.addSubview(skillsStack)
        bottomView.addSubview(skillsCollectionView)
        bottomView.addSubview(aboutStack)
        
        aboutStack.addArrangedSubview(aboutTitleView)
        aboutStack.addArrangedSubview(aboutTextView)
        
        locationStack.addArrangedSubview(locationImage)
        locationStack.addArrangedSubview(locationLabel)
        
        skillsStack.addArrangedSubview(skillsLabel)
        skillsStack.addArrangedSubview(editButton)
        
        scrollView.addSubview(bottomView)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        locationStack.translatesAutoresizingMaskIntoConstraints = false
        skillsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        skillsStack.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        aboutStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileImage.widthAnchor.constraint(equalToConstant: UIConstants.imageWidth),
            profileImage.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),
            profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: UIConstants.profileImageTopPadding),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: UIConstants.nameLabelTopPadding),
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            sloganLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIConstants.sloganLabelTopPadding),
            sloganLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            locationStack.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor),
            locationStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            bottomView.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: UIConstants.bottomViewTopPadding),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: UIConstants.bottomViewBottomPadding),
            
            skillsStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: UIConstants.skillsStackTopPadding),
            skillsStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: UIConstants.skillsStackLeadingPadding),
            skillsStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: UIConstants.skillsStackTrailingPadding),
            skillsStack.heightAnchor.constraint(equalToConstant: UIConstants.skillsStackHeight),
            
            skillsCollectionView.topAnchor.constraint(equalTo: skillsStack.bottomAnchor, constant: UIConstants.skillsCollectionViewTopPadding),
            skillsCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: UIConstants.skillsCollectionViewLeadingPadding),
            skillsCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: UIConstants.skillsCollectionViewTrailingPadding),
            
            aboutStack.topAnchor.constraint(equalTo: skillsCollectionView.bottomAnchor, constant: UIConstants.aboutStackTopPadding),
            aboutStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: UIConstants.aboutStackLeadingPadding),
            aboutStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: UIConstants.aboutStackTrailingPadding),
            aboutStack.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: UIConstants.aboutStackBottomPadding)
            
        ])
        
        skillsCollectionView.reloadData()
    }
    
    private func calculateSkillsCollectionViewHeight() -> CGFloat {
        let collectionViewHeight = skillsCollectionView.collectionViewLayout.collectionViewContentSize.height
        return collectionViewHeight + 20
    }

    // MARK: - Actions
    @objc private func editSkills() {
        skillsCollectionView.isEditing.toggle()
        editButton.setImage(skillsCollectionView.isEditing ? ImageAssets.checkmark : ImageAssets.pencil, for: .normal)
        skillsCollectionView.reloadData()
        skillsCollectionViewHeightConstraint.constant = calculateSkillsCollectionViewHeight()
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview as? UICollectionViewCell, let indexPath = skillsCollectionView.indexPath(for: cell) {
            skillsArray.remove(at: indexPath.item)
            skillsCollectionView.deleteItems(at: [indexPath])
            skillsCollectionViewHeightConstraint.constant = calculateSkillsCollectionViewHeight()
        }
    }
    
    private func addButtonTapped() {
        let alert = UIAlertController(title: "Добавление Навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            self.skillsArray.append(textField.text ?? "New Skill")
            self.skillsCollectionView.reloadData()
            self.skillsCollectionViewHeightConstraint.constant = self.calculateSkillsCollectionViewHeight()
        }
        let secondAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите название"
            textField = alertTextField
        }
        
        alert.addAction(secondAction)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == skillsArray.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddButtonCell", for: indexPath)
            cell.backgroundColor = ColorPallete.background

            let imageView = UIImageView(image: UIImage(systemName: "plus"))
            imageView.tintColor = .black
            
            cell.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
            ])
            
            cell.layer.cornerRadius = UIConstants.cellCornerRadius
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath)
        
        cell.backgroundColor = ColorPallete.background
        cell.layer.cornerRadius = UIConstants.cellCornerRadius
        
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        let skillLabel = UILabel(frame: cell.bounds)
        skillLabel.text = skillsArray[indexPath.item]
        skillLabel.textColor = .black
        skillLabel.font = .systemFont(ofSize: 14)
        skillLabel.numberOfLines = 1
        skillLabel.textAlignment = .center
        
        cell.addSubview(skillLabel)
        
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skillLabel.topAnchor.constraint(equalTo: cell.topAnchor),
            skillLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 24),
            skillLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: !skillsCollectionView.isEditing ? -24 : -48)
        ])
        
        if skillsCollectionView.isEditing {
            let deleteButton = UIButton(type: .system)
            deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            deleteButton.tintColor = .black
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
            cell.addSubview(deleteButton)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                deleteButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                deleteButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -24),
                deleteButton.widthAnchor.constraint(equalToConstant: UIConstants.deleteButtonSize),
                deleteButton.heightAnchor.constraint(equalToConstant: UIConstants.deleteButtonSize)
            ])
        }
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if skillsArray.count == indexPath.row {
            return CGSize(width: UIConstants.addButtonSize, height: UIConstants.addButtonSize)
        }
        let skill = skillsArray[indexPath.item]
        let font = UIFont.systemFont(ofSize: 14)
        let textWidth = skillsCollectionView.isEditing ? skill.size(withAttributes: [.font: font]).width + 72 : skill.size(withAttributes: [.font: font]).width + 50
        let cellWidth = min(textWidth, view.frame.width - 48)
        return CGSize(width: cellWidth, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == skillsArray.count {
            addButtonTapped()
        }
    }
}
