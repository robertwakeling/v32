//
//  CycleThreeAssessmentViewController.h
//  Mr Wakeling's Science Year 7
//
//  Created by Robert Wakeling on 07/08/2012.
//
//

#import <UIKit/UIKit.h>
#import "Tester.h"

@interface CycleThreeAssessmentViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>
{
    int theScore;
    
    // To move the view up and down for text fields
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    
    // An array to hold the text fields near the bottom of the screen
    NSArray *theTextFieldsThatNeedMoving;
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UITextField *fertilisation;
@property (weak, nonatomic) IBOutlet UITextField *birth;
@property (weak, nonatomic) IBOutlet UITextField *adolescence;
@property (weak, nonatomic) IBOutlet UITextField *adulthood;

@end
