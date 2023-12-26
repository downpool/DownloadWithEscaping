//
//  ContentView.swift
//  DownloadWithEscaping
//
//  Created by donghyeon choi on 12/12/23.
//

import SwiftUI

struct PostModel: Codable, Identifiable{
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

class DownloadWithEscapingViewModel: ObservableObject {

    @Published var posts: [PostModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
             
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloadint data \(String(describing: error))")
                return
            }
            
            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.posts.append(newPost)
            }
        }.resume()
    }
}

struct DownloadWithEscaping: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    
    }
}

#Preview {
    DownloadWithEscaping()
}
