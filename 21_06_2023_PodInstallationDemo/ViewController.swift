//
//  ViewController.swift
//  21_06_2023_PodInstallationDemo
//
//  Created by Vishal Jagtap on 31/07/23.
//

import UIKit

class ViewController: UIViewController {

    //access specifiers / control
    //open - 5 - least restrictive access
    //public - 4 - least
    //internal - 3 ---> default internal gets applied
    //fileprivate - 2
    //private - 1 - most resctrictive access
    
    @IBOutlet weak var postTableView: UITableView!
    private let reuseIdentifierForPostTableViewCell = "PostTableViewCell"
    var posts : [Post] = []    //empty array decalaration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        registerXIBWithTableView()
        jsonParsing()
    }
    
    func initViews(){
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: reuseIdentifierForPostTableViewCell, bundle: nil)
        postTableView.register(uiNib, forCellReuseIdentifier: reuseIdentifierForPostTableViewCell)
    }
    
    func jsonParsing(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
         
        let url = URL(string: urlString)
       
        var urlResuest = URLRequest(url: url!)
        urlResuest.httpMethod = "GET"
     
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        var dataTask = urlSession.dataTask(with: urlResuest) { data, response, error in
            //function - last argument as closure, then that could be taken out from the argument list and it is called as trailing closure
            
            print(data)
            print(response)
            print(error)
            
            let jsonResponse = try!  JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for eachJSONObject in jsonResponse{
                let eachPost = eachJSONObject
                let eachPostUserId = eachPost["userId"] as! Int
                let eachPostId = eachPost["id"] as! Int
                let eachPostTitle = eachPost["title"] as! String
                let eachPostDescription = eachPost["body"] as! String
                let postObject = Post(userId: eachPostUserId,
                                  id: eachPostId,
                                  title: eachPostTitle,
                                  description: eachPostDescription)
                
                self.posts.append(postObject)
            }
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
        dataTask.resume()
    }

}

//MARK : UITableViewDataSource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: reuseIdentifierForPostTableViewCell, for: indexPath) as! PostTableViewCell
        let eachPostFetchedFromArray = posts[indexPath.row]
        
        postTableViewCell.postUserIdLabel.text = String(eachPostFetchedFromArray.userId)
        postTableViewCell.postIdLabel.text = String(eachPostFetchedFromArray.id)
        postTableViewCell.postTitleLabel.text = eachPostFetchedFromArray.title
        
        return postTableViewCell
    }
}

//MARK : UITableViewDelegate
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
