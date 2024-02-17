//
//  ContentView.swift
//  Model3D App
//
//  Created by Vinoth Vino on 15/02/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var selectedModel: USDZModel = USDZModel.allModels.first!
    
    var body: some View {
        NavigationSplitView {
            List(USDZModel.allModels) { usdz in
                Button(usdz.name) {
                    selectedModel = usdz
                }
            }
            .navigationTitle("Model3D")
        } detail: {
            ModelViewer(usdz: selectedModel)
        }
    }
}

struct USDZModel: Identifiable, Hashable {
    var id: String { self.name }
    let name: String
    let model: String
    
    static var allModels: [USDZModel] {
        [
            USDZModel(name: "Robot", model: "robot_walk_idle"),
            USDZModel(name: "Biplane", model: "toy_biplane_idle"),
            USDZModel(name: "Drummer", model: "toy_drummer_idle")
        ]
    }
}

struct ModelViewer: View {
    let usdz: USDZModel
    
    var body: some View {
        Model3D(named: usdz.model) { phase in
            if let model = phase.model {
                // Display the loaded 3d model
                model
                    .padding(.bottom, 80)
            } else if phase.error != nil {
                // Display error if it failed to load 3d model
                Label("Failed to load 3d model", systemImage: "x.circle")
            } else {
                // Placeholder
                HStack(spacing: 20) {
                    ProgressView()
                    Text("Loading..")
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
