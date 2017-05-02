//
//  GitHubNetworkClient.swift
//  SwiftGithubBrowser
//
//  Created by Calo, Ignazio on 02/05/2017.
//
//

import Foundation
import SwiftyJSON

typealias NetworkResponse = (JSON, Error?) -> Void

class GitHubNetworkClient {

    public static let instance = GitHubNetworkClient()

    private let baseURL = "https://api.github.com"

    public func getSwiftProjects(onCompletion: @escaping ([ProjectSummary], Error?) -> Void) {
        let route = baseURL + "/search/repositories?q=language:swift&sort=stars&order=desc"

        makeHTTPGetRequest(path: route, onCompletion: { json, err in


            let projects = json["items"].arrayValue.map({ (json: JSON) -> ProjectSummary? in
                guard let id = json["id"].int,
                    let name = json["name"].string,
                    let stars = json["stargazers_count"].int,
                    let description = json["description"].string
                    else {
                        return nil
                }

                return ProjectSummary(id: id, description: description, name: name, stars: stars)
            }).flatMap(){$0}

            onCompletion(projects, err)
        })
    }

    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: @escaping NetworkResponse) {

        let request =  URLRequest(url: URL(string: path)!)


        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(JSON.null, error)
            }
        })
        task.resume()
    }
}
