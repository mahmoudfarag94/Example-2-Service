import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import SVProgressHUD
class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    let url = "https://api.androidhive.info/contacts/"
    var arr = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        getData(url: url)
        // to download image
      //  let url = URL(string: "https://codewithchris.com/img/logo.png")
         //.sd_setImage(with: url, completed: nil)
    
        // to get json data
        //let x ="https://codewithchris.com/code/afsample.json"
//        Alamofire.request("https://api.androidhive.info/contacts/", method:.get).responseJSON { (response) in
//            switch response.result{
//            case.success:
//                if let  value = response.result.value{
//                  let js = JSON(value)
//                  let contacts = js["contacts"].arrayObject
//                    let arr = contacts as! [[String:Any]]
//                     print(arr)
        
//               // let x = json as! [String:Any]
//              // print(x)
////                print(x["firstkey"] as! String )
////                print(x["secondkey"] as! NSArray)
//                }
//            case.failure(let error):
//                print("plz error \(error)")
//                }
//        }

    }
    func getData(url:String)  {
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result{
            case.success:
                if let val = response.result.value{
                    let swiftyjson = JSON(val)
                    let arrdata = swiftyjson["contacts"].arrayObject
                    self.arr = arrdata as! [[String:Any]]
                    if self.arr.count > 0{
                        self.table.reloadData()
                    }
                }
            case.failure(let error):
                print(error)
            }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
            }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cl", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = arr[indexPath.row]["name"] as! String
        //cell.imageView?.image = UIImage(sd_setImage(with: url, completed: nil)) as! UIImage
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

