//
//  CycleThreeViewController.h
//  Mr Wakeling's Science Year 7
//
//  Created by robert wakeling on 25/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tester.h"

@interface CycleThreeViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    int theScore;
}
-(IBAction)checkAnswers;

@property (weak, nonatomic) IBOutlet UITextField *twentyEight;
@property (weak, nonatomic) IBOutlet UITextField *menstrual;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
