//
//  ViewController.swift
//  HTMLparser
//
//  Created by Goto on 2017/10/21.
//  Copyright © 2017年 Goto. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.scrapeNYCMetalScene()
    }

    // Grabs the HTML from askillers.com for parsing.
    func scrapeNYCMetalScene() -> Void {
        Alamofire.request("http://askillers.com/jan/?index=1&word=4901330502881").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) -> Void {
        do {
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)

            let result:String = doc.xpath("/html/body/div[@id='main']/ol/div[@class='item'][1]/div[2]/a").first!.text!
            print(result[result.index(result.startIndex, offsetBy: 2)..<result.endIndex])

            if let imageURL:String = doc.xpath("/html/body/div[@id='main']/ol/div[@class='item'][1]/div[1]/a/img/@src").first!.text {
                self.dlImage(imageURL: imageURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func dlImage(imageURL: String) -> Void {
//        Alamofire.request(imageURL).responseImage { response in
//            debugPrint(response)
//            print(response.request!)
//            print(response.response!)
//            debugPrint(response.result)
//            
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                self.imageView.image = image
                if let snackImageURL = URL(string: imageURL) {
                    self.imageView.af_setImage(withURL: snackImageURL)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

