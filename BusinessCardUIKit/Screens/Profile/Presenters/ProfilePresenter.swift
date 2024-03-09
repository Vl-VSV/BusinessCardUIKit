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
    func addSkill(_ skill: SkillModel)
    func changeEditMode()
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
}
