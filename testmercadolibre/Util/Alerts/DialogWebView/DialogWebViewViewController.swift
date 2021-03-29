//
//  DialogWebViewViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 29/03/21.
//

import UIKit
import WebKit
class DialogWebViewViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var titleText = ""
    var urlRecibed = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    

    func initComponent(){
        titleLabel.text = titleText
        if let url = URL(string: urlRecibed) {
            let request = NSURLRequest(url: url )
            webView.load(request as URLRequest)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: -Show
extension DialogWebViewViewController {
    static func show(controller: UIViewController, titleText: String, url: String) {
        let storyBoard = UIStoryboard(name: "DialogWebView", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "DialogWebViewViewController") as? DialogWebViewViewController {
            
            vc.modalPresentationStyle = .popover
            vc.titleText = titleText
            vc.urlRecibed = url
            
            controller.present(vc, animated: true, completion: nil)
            
        }
    }
}
