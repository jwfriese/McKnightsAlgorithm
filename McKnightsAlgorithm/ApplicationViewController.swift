import UIKit

struct NoStepCoordinatorError: ErrorType { }

class ApplicationViewController: UIViewController {
    @IBOutlet weak var mysteriousButton: UIButton?
    @IBOutlet weak var containerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onUserMightThinkTheirWorkIsDone() {
        let alert = UIAlertController(title: nil, message: "I believe that my work is done", preferredStyle: .Alert)
        let agreeAction = UIAlertAction(title: "Agree", style: .Default) { action in
            guard let stepCoordinator = self.childViewControllers.first as? StepCoordinator else {
                print("ERROR: No step coordinator set")
                return
            }
            
            stepCoordinator.restartWithAdmonition()
        }
        
        alert.addAction(agreeAction)
        
        let disagreeAction = UIAlertAction(title: "Disagree", style: .Cancel, handler: nil)
        alert.addAction(disagreeAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}