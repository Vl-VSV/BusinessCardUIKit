//
//  ProfilePresenter.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 04.03.2024.
//

import Foundation

class ProfilePresenter {
    weak private var view: ProfileView?
    private var skillDataManager: SkillDataManager
    
    init(view: ProfileView, skillDataManager: SkillDataManager) {
        self.view = view
        self.skillDataManager = skillDataManager
    }
}
