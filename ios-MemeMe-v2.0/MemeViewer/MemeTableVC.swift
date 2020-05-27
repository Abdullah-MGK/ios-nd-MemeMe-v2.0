//
//  MemeTableViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeTableVC: UITableViewController, MemeEditorDelegate {
    
    let memeCellId = "MemeCell"
    let memeDetailId = "MemeDetailVC"
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: memeCellId, for: indexPath)
        
        let meme = memes[indexPath.row]
        cell.textLabel?.text = "\(meme.topTxt), \(meme.bottomTxt)"
        // cell.detailTextLabel?.text = meme.bottomTxt
        cell.imageView?.image = meme.memedImg
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailId) as! MemeDetailVC
        
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (deleteAction, view, completion) in
            
            (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // self.updateView()
            
        })
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let shareAction = UIContextualAction(style: .normal, title: "Share", handler: { (shareAction, view, completion) in
            
            self.shareImage(image: self.memes[indexPath.row].memedImg)
            
            })
        
        let swipeActions = UISwipeActionsConfiguration(actions: [shareAction])
        
        return swipeActions
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
            updateView()
        }
        
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assign self as delgate for MemeEditorVC in order to update the tableView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
        
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
    func shareImage(image: UIImage) {
        
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
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
