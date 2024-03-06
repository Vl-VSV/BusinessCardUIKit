//
//  SkillDataManager.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 04.03.2024.
//

import Foundation

class SkillDataManager {
    private let userDefaults = UserDefaults.standard

    func fetchSkills() -> [SkillModel] {
        guard let data = userDefaults.object(forKey: Constants.skillKey) as? Data else {
            return Constants.defaultSkills
        }
        
        let skills = (try? JSONDecoder().decode([SkillModel].self, from: data)) ?? []
        return skills.isEmpty ? Constants.defaultSkills : skills
    }
    
    func saveSkills(_ skills: [SkillModel]) {
        guard let data = try? JSONEncoder().encode(skills) else { return }
        userDefaults.setValue(data, forKey: Constants.skillKey)
    }
}
