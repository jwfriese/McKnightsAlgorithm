import Quick
import Nimble
import Fleet
@testable import McKnightsAlgorithm

class StepCoordinationViewControllerSpec: QuickSpec {
    override func spec() {
        describe("StepCoordinationViewController") {
            var subject: StepCoordinationViewController!
            var storyboard: UIStoryboard!
            
            beforeEach {
                storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewControllerWithIdentifier("StepCoordinationViewController") as! StepCoordinationViewController
            }
            
            describe("After the view has loaded") {
                var stepOne: StepViewController!
                var stepTwo: StepViewController!
                var stepThree: StepViewController!
                var questionStep: QuestionViewController!
                
                beforeEach {
                    stepOne = StepViewController()
                    stepOne.stepNumber = 1
                    try! storyboard.bindViewController(stepOne, toIdentifier: "StepOne")
                    stepTwo = StepViewController()
                    stepTwo.stepNumber = 2
                    try! storyboard.bindViewController(stepTwo, toIdentifier: "StepTwo")
                    stepThree = StepViewController()
                    stepThree.stepNumber = 3
                    try! storyboard.bindViewController(stepThree, toIdentifier: "StepThree")
                    questionStep = QuestionViewController()
                    questionStep.stepNumber = 4
                    try! storyboard.bindViewController(questionStep, toIdentifier: "Question")
                    
                    Fleet.swapWindowRootViewController(subject)
                }
                
                it("will have presented the step one view controller") {
                    expect(subject.viewControllers?.count).to(equal(1))
                    expect(subject.viewControllers).to(contain(stepOne))
                }
                
                describe("Getting the following step") {
                    context("When on step one") {
                        var nextStep: StepViewController!
                        
                        beforeEach {
                            nextStep = subject.pageViewController(subject, viewControllerAfterViewController: stepOne) as? StepViewController
                        }
                        
                        it("moves to step two") {
                            expect(nextStep).to(beIdenticalTo(stepTwo))
                        }
                        
                        context("When on step two") {
                            beforeEach {
                                nextStep = subject.pageViewController(subject, viewControllerAfterViewController: stepTwo) as? StepViewController
                            }
                            
                            it("moves to step three") {
                                expect(nextStep).to(beIdenticalTo(stepThree))
                            }
                            
                            context("When on step three the first time") {
                                beforeEach {
                                    nextStep = subject.pageViewController(subject, viewControllerAfterViewController: stepThree) as? StepViewController
                                }
                                
                                it("moves back to step one") {
                                    expect(nextStep).to(beIdenticalTo(stepOne))
                                }
                                
                                context("When on step three the second time") {
                                    beforeEach {
                                        nextStep = subject.pageViewController(subject, viewControllerAfterViewController: stepThree) as? StepViewController
                                    }
                                    
                                    it("moves to the question step") {
                                        expect(nextStep).to(beIdenticalTo(questionStep))
                                    }
                                    
                                    context("When on the question step") {
                                        beforeEach {
                                            nextStep = subject.pageViewController(subject, viewControllerAfterViewController: questionStep) as? StepViewController
                                        }
                                        
                                        it("does not advance anymore") {
                                            expect(nextStep).to(beNil())
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}