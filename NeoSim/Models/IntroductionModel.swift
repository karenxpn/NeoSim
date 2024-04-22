//
//  IntroductionModel.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import Foundation
import FirebaseFirestoreSwift

struct IntroductionModel: Identifiable, Codable {
    @DocumentID var id: String?
    var image: String
    var title: String
    var description: String
}
