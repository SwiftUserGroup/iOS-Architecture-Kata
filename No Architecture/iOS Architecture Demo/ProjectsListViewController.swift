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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC: ProjectDetailViewController = segue.destination as! ProjectDetailViewController

        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            let selectedProject = self.datasource[selectedIndexPath.row]
            detailVC.urlToFetch = selectedProject.publicURL
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProjectSummaryCell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath) as! ProjectSummaryCell

        let project = self.datasource[indexPath.row]

        cell.projectName.text = "\(project.name)"
        cell.projectDescription.text = "\(project.description)"
        cell.projectStars.text = "Star count: \(project.stars)"

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

