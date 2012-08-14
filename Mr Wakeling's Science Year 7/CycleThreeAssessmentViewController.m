//
//  CycleThreeAssessmentViewController.m
//  Mr Wakeling's Science Year 7
//
//  Created by Robert Wakeling on 07/08/2012.
//
//

#import "CycleThreeAssessmentViewController.h"

@interface CycleThreeAssessmentViewController ()

@end

@implementation CycleThreeAssessmentViewController
@synthesize scoreLabel;
@synthesize fertilisation;
@synthesize birth;
@synthesize adolescence;
@synthesize adulthood;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewUpForKeyboard:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewDownAfterKeyboard)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
    
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
    
    
}

- (NSArray *) LowTextFieldsThatNeedTheViewToMove
{
    theTextFieldsThatNeedMoving = [[NSArray alloc] initWithObjects:fertilisation, nil];
    return theTextFieldsThatNeedMoving;
}

- (void) shiftViewUpForKeyboard: (NSNotification*)theNotification;
{
    
    
    NSEnumerator *enumerator = [[self LowTextFieldsThatNeedTheViewToMove] objectEnumerator];
    UITextField *object;
    
    while ((object = [enumerator nextObject])) {
        // do something with object...
        if (object.isEditing) {
            
            CGRect keyboardFrame;
            NSDictionary* userInfo = theNotification.userInfo;
            keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
            keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
            
            UIInterfaceOrientation theStatusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
            
            if UIInterfaceOrientationIsLandscape(theStatusBarOrientation)
                keyboardShiftAmount = keyboardFrame.size.width;
            else
                keyboardShiftAmount = keyboardFrame.size.height;
            
            [UIView beginAnimations: @"ShiftUp" context: nil];
            [UIView setAnimationDuration: keyboardSlideDuration];
            self.view.center = CGPointMake( self.view.center.x, self.view.center.y - keyboardShiftAmount);
            [UIView commitAnimations];
            viewShiftedForKeyboard = TRUE;
            
        }
    }
}



//------------------

- (void) shiftViewDownAfterKeyboard;
{
    if (viewShiftedForKeyboard)
    {
        [UIView beginAnimations: @"ShiftUp" context: nil];
        [UIView setAnimationDuration: keyboardSlideDuration];
        self.view.center = CGPointMake( self.view.center.x, self.view.center.y + keyboardShiftAmount);
        [UIView commitAnimations];
        viewShiftedForKeyboard = FALSE;
    }
}


-(IBAction)checkAnswers
{
    int a, b, c, d;
    
    if ([fertilisation.text isEqualToString:@"Fertilisation"]) {
        a = 1;
    }
    else
    {
        a = 0;
    }
    
    if ([birth.text isEqualToString:@"Birth"]) {
        b = 1;
    }
    else
    {
        b = 0;
    }
    
    if ([adolescence.text isEqualToString:@"Adolescence"]) {
        c = 1;
    }
    else
    {
        c = 0;
    }
    
    if ([adulthood.text isEqualToString:@"Adulthood"]) {
        d = 1;
    }
    else
    {
        d = 0;
    }
    theScore = a + b + c + d;
    scoreLabel.text = [NSString stringWithFormat:@"%i", theScore];
    
    if (theScore < 3) {
        scoreLabel.textColor = [UIColor redColor];
    }
    if (theScore == 3) {
        scoreLabel.textColor = [UIColor orangeColor];
    }
    if (theScore == 4) {
        scoreLabel.textColor = [UIColor greenColor];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You know the stages of the life cycle!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    Tester *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Overall1"];
    [self.navigationController pushViewController:detail animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Baby3" object:self];
    
}


- (void)viewDidUnload
{
    [self setScoreLabel:nil];
    [self setFertilisation:nil];
    [self setBirth:nil];
    [self setAdolescence:nil];
    [self setAdulthood:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
