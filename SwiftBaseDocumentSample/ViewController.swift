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

class ViewController: NSViewController, NSTextDelegate {
    
    // MARK: Interface
    @IBOutlet var myTextView: NSTextView!
    
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
                self.myTextView.string = doc.myText
            }
        }
    }
    
    // MARK: Delegates
    func  textDidChange(notification: NSNotification) {
        // Change var in Document
        println("textDidChange") // Update Document
        if let doc = representedObject as? Document {
            doc.myText = self.myTextView.string!
        }
    }
}

