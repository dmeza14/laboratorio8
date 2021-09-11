//
//  ContentView.swift
//  api
//
//  Created by David Meza on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    @State var results = [DogFact]()
    
    var body: some View {
        List(results, id: \.id) { item in
        VStack(alignment: .leading) {
        Text(item.fact)
        }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
    guard let url = URL(string: "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs/all") else {
    print("Your API end point is Invalid")
    return
    }
    let request = URLRequest(url: url)
    // The shared singleton session object.
    URLSession.shared.dataTask(with: request) { data, response, error in
    if let data = data {
    if let response = try? JSONDecoder().decode([DogFact].self, from: data) {
    DispatchQueue.main.async {
    self.results = response
    
    }
    return
    }
    }
    }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
