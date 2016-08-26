import UIKit

class StepCoordinationViewController: UIPageViewController {
    private var shouldRepeatStepsOneThroughThree: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let stepOne = storyboard?.instantiateViewControllerWithIdentifier("StepOne")
        self.setViewControllers([stepOne!],
                                direction: .Forward,
                                animated: false,
                                completion: nil)
    }
}

extension StepCoordinationViewController: StepCoordinator {
    func restart() {
        let stepOne = storyboard?.instantiateViewControllerWithIdentifier("StepOne")
        self.setViewControllers([stepOne!],
                                direction: .Forward,
                                animated: false,
                                completion: nil)
    }
}

extension StepCoordinationViewController: UIPageViewControllerDelegate {
    
}

extension StepCoordinationViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let stepViewController = viewController as? StepViewController else {
            return nil
        }
        
        var newStep: StepViewController?
        if stepViewController.stepNumber == 1 {
            newStep = storyboard?.instantiateViewControllerWithIdentifier("StepTwo") as? StepViewController
            newStep?.coordinator = self
        } else if stepViewController.stepNumber == 2 {
            newStep = storyboard?.instantiateViewControllerWithIdentifier("StepThree") as? StepViewController
            newStep?.coordinator = self
        } else if stepViewController.stepNumber == 3 {
            if shouldRepeatStepsOneThroughThree {
                shouldRepeatStepsOneThroughThree = false
                newStep = storyboard?.instantiateViewControllerWithIdentifier("StepOne") as? StepViewController
                newStep?.coordinator = self
            } else {
                newStep = storyboard?.instantiateViewControllerWithIdentifier("Question") as? QuestionViewController
                newStep?.coordinator = self
            }
        }
        
        return newStep
    }
}
