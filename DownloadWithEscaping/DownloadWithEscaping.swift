//
//  ContentView.swift
//  DownloadWithEscaping
//
//  Created by donghyeon choi on 12/12/23.
//

import SwiftUI

struct PostModel: Codable {
    
}

class DownloadWithEscapingViewModel: ObservableObject {

    @Published var posts: [PostModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        guard let url = URL(string: "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
             
        }
    }
}

struct DownloadWithEscaping: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
    
    }
}

#Preview {
    DownloadWithEscaping()
}
