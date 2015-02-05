//
//  ViewController.swift
//  SwiftBaseDocumentSample
//
//  This sample code was create by CocoaCafe Forum communauty in MIT Licence
//
//  Refered topic :
//  http://forum.cocoacafe.fr/topic/13410-disparition-de-fileowners-de-xib-à-storyboard/
//

import Cocoa

let ACHECK_KEY   = "aCheck"
let ANAUTHOR_KEY = "anAuthor"
let ATEXT_KEY    = "aText"


class ViewController: NSViewController {

    // MARK: ViewController func
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
            println("Document :")
            println("-----------")
            println("\(representedObject)")
            println ()
            
            if let doc = representedObject as? Document {
                println("Document loaded :")
                println("------------------")
                println("\(doc.myState) -  \(doc.myAuthor) - \(doc.myText)")
                
            }
        }
    }
}

