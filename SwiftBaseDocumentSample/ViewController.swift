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


    
 

    // MARK: Controllers Variables
    var aCheck : Bool = false {
        didSet {
            println("didSet aCheck : \(self.aCheck)")
            if let doc = representedObject as? Document {
                doc.myState = self.aCheck
            }
        }
    }
    
    var anAuthor : String? = "" {
        didSet {
            println("didSet anAuthor : \(self.anAuthor)")
            if let doc = representedObject as? Document {
                doc.myAuthor = self.anAuthor
            }
        }
    }
    
    var aText : NSAttributedString? = nil {
        didSet {
           println("didSet aText : \(self.self.aText?.string)")
            if let doc = representedObject as? Document {
                doc.myText = self.aText?.string
            }
        }
    }



    


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
                // KVO : Will Change notifications
                self.willChangeValueForKey(ACHECK_KEY)
                self.willChangeValueForKey(ANAUTHOR_KEY)
                self.willChangeValueForKey(ATEXT_KEY)
                
                self.aCheck     = doc.myState
                self.anAuthor   = doc.myAuthor!
                self.aText      = NSAttributedString (string:doc.myText!)
                
                // KVO : Did Change notifications
                self.didChangeValueForKey(ACHECK_KEY)
                self.didChangeValueForKey(ANAUTHOR_KEY)
                self.didChangeValueForKey(ATEXT_KEY)
                
                println("Document loaded :")
                println("------------------")
                println("\(self.aCheck) -  \(self.anAuthor) - \(self.aText)")
                
            }
        }
    }
}

