//
//  ProfilePresenter.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 04.03.2024.
//

import UIKit

protocol ProfilePresenting: AnyObject {
    var skills: [SkillModel] { get }
    var isEditMode: Bool { get }
    func deleteSkill(index: Int)
    func changeEditMode()
    func addNewSkill()
}


class ProfilePresenter: ProfilePresenting {
    // MARK: - Properties
    weak private var view: ProfileView?
    private var skillDataManager: SkillDataManager
    
    private(set) var skills: [SkillModel] = []
    private(set) var isEditMode: Bool = false
    
    // MARK: - Init
    init(view: ProfileView, skillDataManager: SkillDataManager) {
        self.view = view
        self.skillDataManager = skillDataManager
        
        skills = skillDataManager.fetchSkills()
    }
    
    // MARK: - Functions
    func deleteSkill(index: Int) {
        skills.remove(at: index)
        skillDataManager.saveSkills(skills)
        view?.updateCollection()
    }
    
    func addSkill(_ skill: SkillModel) {
        skills.append(skill)
        skillDataManager.saveSkills(skills)
        view?.updateCollection()
    }
    
    func changeEditMode() {
        isEditMode = !isEditMode
        view?.updateCollection()
    }
    
    func addNewSkill() {
        let alert = UIAlertController(title: "adding skill".localized, message: "enter skill".localized, preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "add".localized, style: .default) { action in
            self.addSkill(SkillModel(name: textField.text ?? "new skill".localized))
        }
        let secondAction = UIAlertAction(title: "cancel".localized, style: .destructive)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "enter title".localized
            textField = alertTextField
        }
        
        alert.addAction(secondAction)
        alert.addAction(action)
        
        self.view?.present(alert, animated: true, completion: nil)
    }
}
