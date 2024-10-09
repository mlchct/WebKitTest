//
//  WebKitViewController.swift
//  WebKitTest
//
//  Created by Mikhail Kalatsei on 16/05/2024.
//




import UIKit
import WebKit
import Security
import CryptoKit

class WebKitViewController: UIViewController {
    var webView = WKWebView()
    var certificateName = "cert1234"
    var webSiteAdress = "preact-cli.badssl.com"

    var trustedCertificates: [SecCertificate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupWebView()
        setupRefreshControl()
        loadUrlFromString("https://piehost.com/websocket-tester?url=wss%3A%2F%2Ffree.blr2.piesocket.com%2Fv3%2F1%3Fapi_key%3DWpXYSGbMiSYTvOICp48s7e4zv7Ze638HH7RQB6eA%26notify_self%3D1")
    }

    private func setupWebView() {

        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "nativeHandler")
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadWebView(_:)), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
    }

    private func loadUrlFromString(_ passedUrl: String){
        if let url = URL(string: passedUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func reloadWebView(_ sender: UIRefreshControl) {
        webView.reload()
        sender.endRefreshing()
    }
}

extension WebKitViewController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "nativeHandler" {
            // Handle messages sent from JavaScript
            if let messageBody = message.body as? String {
                print("Message from JavaScript: \(messageBody)")
            }
        }
    }
}
