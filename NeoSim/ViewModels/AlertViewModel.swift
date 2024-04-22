//
//  AlertViewModel.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import Foundation
class AlertViewModel {
    func makeAlert(with error: Error, message: inout String, alert: inout Bool ) {
        message = error.localizedDescription
        alert.toggle()
    }
}
