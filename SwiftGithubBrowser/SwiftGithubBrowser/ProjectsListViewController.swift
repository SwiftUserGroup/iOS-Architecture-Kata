//
//  ViewController.swift
//  SwiftGithubBrowser
//
//  Created by Calo, Ignazio on 02/05/2017.
//
//

import UIKit
import SwiftyJSON

class ProjectsListViewController: UITableViewController {



    private var datasource: [ProjectSummary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Fetch items
        GitHubNetworkClient.instance.getSwiftProjects { (projects: [ProjectSummary], error: Error?) in

            self.datasource = projects
            self.tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

