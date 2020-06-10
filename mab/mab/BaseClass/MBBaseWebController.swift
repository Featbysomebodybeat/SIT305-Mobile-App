//
//  MBBaseWebController.swift
//  mab
//
//  Created by Shuo Wang on 10/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import WebKit

class MBBaseWebController: MBBaseController {

    var url: URL?
    var urlString: String = ""
    var path: String = "" {
        willSet {
            DPrint("htmlPath == \(newValue)")
        }
    }
    var htmlString: String = "" {
        willSet {
            DPrint("htmlString == \(newValue)")
        }
    }
    
    private lazy var webView: WKWebView = {
        let web = WKWebView(frame: .zero)
        return web
    }()
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.progressTintColor = MBColor.mainTint
        progress.trackTintColor = MBColor.grayBackground
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        guard htmlString.isEmpty else {
            webView.loadHTMLString(htmlString, baseURL: nil)
            return
        }
        
        var urlReq: URLRequest?
        
        if let tmpUrl0 = url {
            urlReq = URLRequest(url: tmpUrl0)
        }else if urlString.isNotEmpty, let tmpUrl1 = URL(string: urlString) {
            urlReq = URLRequest(url: tmpUrl1)
        }else if path.isNotEmpty {
             let tmpUrl2 = URL(fileURLWithPath: path)
            urlReq = URLRequest(url: tmpUrl2)
        }
        
        if let tmpReq = urlReq {
            webView.load(tmpReq)
        }
    }
    
    override func setup() {
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
        progressView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 2)
    }

    // KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

}
