//
//  ProjectDetailViewController.swift
//  SwiftGithubBrowser
//
//  Created by Calo, Ignazio on 02/05/2017.
//
//

import UIKit

class ProjectDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    public var urlToFetch: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = urlToFetch {
            self.webView.loadRequest(URLRequest(url: url))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
