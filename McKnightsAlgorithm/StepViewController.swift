import UIKit

class StepViewController: UIViewController {
    @IBInspectable var stepNumber: UInt = 0
    weak var coordinator: StepCoordinator?
}
