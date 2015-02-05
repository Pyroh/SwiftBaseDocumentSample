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
    @IBOutlet var textView: NSTextView!

    // Even if super's representedObject is dynamic you must make this one dynamic to.
    override dynamic var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
            println("Document :")
            println("-----------")
            println("\(representedObject)\n")
            if let doc = representedObject as? Document {
                println("Document loaded :")
                println("------------------")
                println("\(doc.myState) - \(doc.myAuthor) - ")
            }
        }
    }
}

