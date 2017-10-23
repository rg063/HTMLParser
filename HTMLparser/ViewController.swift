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

class ViewController: UIViewController {

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
//        var shows: Array<String> = []
        do {
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
                
//            // Search for nodes by CSS selector
//            for show in doc.css("td[id^='Text']") {
//
//                // Strip the string of surrounding whitespace.
//                let showString = show.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//
//                // All text involving shows on this page currently start with the weekday.
//                // Weekday formatting is inconsistent, but the first three letters are always there.
//                let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
//
//                if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
//                    shows.append(showString)
//                    print("\(showString)\n")
//                }
//            }
            
            var num = 0
            for show in doc.css("a, link") {
                if num == 3 {
                    let result = show.text!
                    print(show.text!)
                    print(result[result.index(result.startIndex, offsetBy: 2)..<result.endIndex])
                }
                num += 1
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

