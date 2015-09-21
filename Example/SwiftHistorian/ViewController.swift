//
//  ViewController.swift
//  SwiftHistorian
//
//  Created by akuraru on 09/17/2015.
//  Copyright (c) 2015 akuraru. All rights reserved.
//

import UIKit
import WebKit
import SwiftHistorian

class ViewController: UIViewController {
    var webView: WKWebView!
    var historian: SwiftHistorian!

    override func viewDidLoad() {
        super.viewDidLoad()
        historian = SwiftHistorian()
        
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = historian
        view.addSubview(webView)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://github.com/")!))
        
        print(historian.loadHistorian())
    }
}
