import UIKit
import WebKit
import RealmSwift

public class Historian: Object {
    dynamic var URL = ""
    dynamic var host = ""
    dynamic var title = ""
    dynamic var timeStamp: Int = 0
    override public class func primaryKey() -> String? {
        return "URL"
    }
    override public static func indexedProperties() -> [String] {
        return ["timeStamp"]
    }
}

public class SwiftHistorian: NSObject, WKNavigationDelegate {
    public var delegate: WKNavigationDelegate?
    
    override public init() {
        super.init()
    }
    func realm() -> Realm {
        let path = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as String
        return (try? Realm(path: "\(path)/SwiftHistorian.realm"))!
    }
    
    public func loadHistorian() -> Results<Historian> {
        return realm().objects(Historian)
    }
    
    func update(URL: NSURL?, title: String?) {
        if let u = URL {
            try! realm().write({[unowned self] in
                let realm = self.realm()
                let result = realm.objects(Historian).filter(NSPredicate(format: "URL == %@", u.absoluteString))
                if let historian = result.first {
                    historian.host = u.host ?? ""
                    historian.title = title ?? ""
                    historian.timeStamp = Int(NSDate().timeIntervalSince1970 * 1000)
                    realm.add(historian)
                } else {
                    let historian = Historian()
                    historian.URL = u.absoluteString
                    historian.host = u.host ?? ""
                    historian.title = title ?? ""
                    historian.timeStamp = Int(NSDate().timeIntervalSince1970 * 1000)
                    realm.add(historian)
                }
            })
        }
    }
    
    public func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        print("webView:decidePolicyForNavigationAction:decisionHandler:")
        if let d = delegate where d.respondsToSelector("webView:decidePolicyForNavigationAction:decisionHandler:") {
            d.webView!(webView, decidePolicyForNavigationAction: navigationAction, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.Allow)
        }
    }
    
    public func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        print("webView:decidePolicyForNavigationResponse:decisionHandler:")
        if let d = delegate where d.respondsToSelector("webView:decidePolicyForNavigationResponse:decisionHandler:") {                d.webView!(webView, decidePolicyForNavigationResponse: navigationResponse, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.Allow)
        }
    }
    public func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webView:didStartProvisionalNavigation:")
        if let d = delegate where d.respondsToSelector("webView:didStartProvisionalNavigation:") {
            d.webView!(webView, didStartProvisionalNavigation: navigation)
        }
    }
    public func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("webView:didReceiveServerRedirectForProvisionalNavigation:")
        if let d = delegate where d.respondsToSelector("webView:didReceiveServerRedirectForProvisionalNavigation:") {
            d.webView!(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
        }
    }
    public func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print("webView:didFailProvisionalNavigation:withError:")
        print(error)
        if let d = delegate where d.respondsToSelector("webView:didFailProvisionalNavigation:withError:") {
            d.webView!(webView, didFailProvisionalNavigation: navigation, withError: error)
        }
    }
    public func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        print("webView:didCommitNavigation:")
        if let d = delegate where d.respondsToSelector("webView:didCommitNavigation:") {
            d.webView!(webView, didCommitNavigation: navigation)
        }
    }
    public func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("webView:didFinishNavigation:")
        update(webView.URL, title: webView.title)
        
        if let d = delegate where d.respondsToSelector("webView:didFinishNavigation:") {
            d.webView!(webView, didFinishNavigation: navigation)
        }
    }
    public func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print("webView:didFailNavigation:withError:")
        print(error)
        if let d = delegate where d.respondsToSelector("webView:didFailNavigation:withError:") {
            d.webView!(webView, didFailNavigation: navigation, withError: error)
        }
    }
    public func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        print("webView:didReceiveAuthenticationChallenge:completionHandler:")
        if let d = delegate where d.respondsToSelector("webView:didReceiveAuthenticationChallenge:completionHandler:") {
            d.webView!(webView, didReceiveAuthenticationChallenge: challenge, completionHandler: completionHandler)
        } else {
            completionHandler(.PerformDefaultHandling, nil)
        }
    }
    public func webViewWebContentProcessDidTerminate(webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate:")
        if let d = delegate where d.respondsToSelector("webViewWebContentProcessDidTerminate:") {
            if #available(iOS 9.0, *) {
                d.webViewWebContentProcessDidTerminate!(webView)
            }
        }
    }
}
