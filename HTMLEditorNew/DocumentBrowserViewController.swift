//
//  DocumentBrowserViewController.swift
//  HTMLEditorNew
//
//  Created by VyacheslavKrivoi on 5/11/19.
//  Copyright © 2019 VyacheslavKrivoi. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    var tempUrl: URL?
    
    var htmlTemplate: String = """
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Моя тестова сторінка</title>
  </head>
  <body>
<Img src="https://ktonanovenkogo.ru/image/finik.jpg" Width="200" Height="150">
   <p> First Paragraf  </p>
  </body>
</html>
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
        
        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        tempUrl = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("myFirstWeb.html")
        if tempUrl != nil {
            
            
            allowsDocumentCreation = FileManager.default.createFile(atPath: tempUrl!.path, contents: htmlTemplate.data(using: .utf8))
        }
        
        importHandler(tempUrl, .copy)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "NavigationController")
        
        if let editorViewController = controller.contents as? ViewController {
            editorViewController.document = HtmlDocument(fileURL: documentURL)
        }
        present(controller, animated: true, completion: nil)
    }
}

