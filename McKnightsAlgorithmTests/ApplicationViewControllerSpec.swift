import Quick
import Nimble
import Fleet
@testable import McKnightsAlgorithm

class ApplicationViewControllerSpec: QuickSpec {
    override func spec() {
        class MockStepCoordinationViewController: StepCoordinationViewController {
            var didRestart: Bool = false
            
            private override func viewDidLoad() { }
            
            private override func restart() {
                didRestart = true
            }
        }
        
        describe("ApplicationViewController") {
            var subject: ApplicationViewController!
            var storyboard: UIStoryboard!
            var coordinationViewController: MockStepCoordinationViewController!
            
            beforeEach {
                storyboard = UIStoryboard(name: "Main", bundle: nil)
                coordinationViewController = MockStepCoordinationViewController()
                
                try! storyboard.bindViewController(coordinationViewController, toIdentifier: "StepCoordination")
                
                subject = storyboard.instantiateViewControllerWithIdentifier("Application") as! ApplicationViewController
            }
            
            describe("After the view has loaded") {
                beforeEach {
                    Fleet.swapWindowRootViewController(subject)
                }
                
                describe("Tapping the button") {
                    beforeEach {
                        subject.mysteriousButton?.tap()
                    }
                    
                    it("brings up an alert") {
                        expect(Fleet.getCurrentScreen()?.topmostPresentedViewController).to(beAnInstanceOf(UIAlertController.self))
                    }
                    
                    // given("brings up an alert")
                    describe("The alert") {
                        var alert: UIAlertController!
                        
                        beforeEach {
                            alert = Fleet.getCurrentScreen()?.topmostPresentedViewController as! UIAlertController
                        }
                        
                        it("has a message") {
                            expect(alert.message).to(equal("I believe that my work is done"))
                        }
                        
                        describe("Tapping 'Agree'") {
                            beforeEach {
                                alert.tapAlertActionWithTitle("Agree")
                            }
                            
                            it("starts you back at one") {
                                expect(coordinationViewController.didRestart).to(beTrue())
                            }
                        }
                        
                        describe("Tapping 'Disagree'") {
                            beforeEach {
                                alert.tapAlertActionWithTitle("Disagree")
                            }
                            
                            it("dismisses the alert") {
                                expect(Fleet.getCurrentScreen()?.topmostPresentedViewController).toNot(beIdenticalTo(alert))
                            }
                            
                            it("does not start you back at one") {
                                expect(coordinationViewController.didRestart).to(beFalse())
                            }
                        }
                    }
                }
            }
        }
    }
}
