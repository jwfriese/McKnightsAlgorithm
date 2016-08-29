import Quick
import Nimble
import Fleet
@testable import McKnightsAlgorithm

class QuestionViewControllerSpec: QuickSpec {
    class MockStepCoordinator: StepCoordinator {
        var didRestart: Bool = false
        
        @objc func restart() {
            didRestart = true
        }
        
        @objc func restartWithAdmonition() {
            didRestart = true
        }
    }
    
    override func spec() {
        describe("QuestionViewController") {
            var subject: QuestionViewController!
            var mockStepCoordinator: MockStepCoordinator!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewControllerWithIdentifier("Question") as! QuestionViewController
                mockStepCoordinator = MockStepCoordinator()
                subject.coordinator = mockStepCoordinator
                Fleet.swapWindowRootViewController(subject)
            }
            
            describe("Hitting the 'No' button") {
                beforeEach {
                    subject.noButton?.tap()
                }
                
                it("tells the coordinator to restart") {
                    expect(mockStepCoordinator.didRestart).to(beTrue())
                }
            }
            
            describe("Hitting the 'Yes' button") {
                beforeEach {
                    subject.yesButton?.tap()
                }
                
                it("also tells the coordinator to restart") {
                    expect(mockStepCoordinator.didRestart).to(beTrue())
                }
            }
        }
    }
}
