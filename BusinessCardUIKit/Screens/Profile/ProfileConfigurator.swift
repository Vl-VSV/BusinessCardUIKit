//
//  ProfileConfigurator.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 04.03.2024.
//

import UIKit

final class ProfileConfigurator {
    static func configure() -> UIViewController {
        let view = ProfileView()
        let skillDataManager = SkillDataManager()
        
        let presenter = ProfilePresenter(view: view, skillDataManager: skillDataManager)
        view.presenter = presenter
        
        return view
    }
}
