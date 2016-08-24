import UIKit

class QuestionViewController: StepViewController {
    @IBOutlet weak var yesButton: UIButton?
    @IBOutlet weak var noButton: UIButton?
    
    @IBAction func startBackAtOne() {
        coordinator?.restart()
    }
}
