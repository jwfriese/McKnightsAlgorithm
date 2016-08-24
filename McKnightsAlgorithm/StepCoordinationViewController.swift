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
        
        if stepViewController.stepNumber == 1 {
            return storyboard?.instantiateViewControllerWithIdentifier("StepTwo")
        } else if stepViewController.stepNumber == 2 {
            return storyboard?.instantiateViewControllerWithIdentifier("StepThree")
        } else if stepViewController.stepNumber == 3 {
            if shouldRepeatStepsOneThroughThree {
                shouldRepeatStepsOneThroughThree = false
                return storyboard?.instantiateViewControllerWithIdentifier("StepOne")
            } else {
                return storyboard?.instantiateViewControllerWithIdentifier("Question")
            }
        }
        
        return nil
    }
}
