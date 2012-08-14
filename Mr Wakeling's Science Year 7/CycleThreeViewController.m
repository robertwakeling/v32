//
//  CycleThreeViewController.m
//  Mr Wakeling's Science Year 7
//
//  Created by robert wakeling on 25/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CycleThreeViewController.h"

@interface CycleThreeViewController ()

@end

@implementation CycleThreeViewController
@synthesize twentyEight;
@synthesize menstrual;
@synthesize scoreLabel;

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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(IBAction)checkAnswers
{
    int a, b;
    if ([twentyEight.text isEqualToString:@"28"]) {
        a = 1;
    }
    else
    {
        a = 0;
    }
    if ([menstrual.text isEqualToString:@"menstrual"]) {
        b = 1;
    }
    else
    {
        b = 0;
    }
    theScore = a + b;
    scoreLabel.text = [NSString stringWithFormat:@"%i/2", theScore];
    if (theScore == 0) {
        scoreLabel.textColor = [UIColor redColor];
    }
    if (theScore == 1) {
        scoreLabel.textColor = [UIColor orangeColor];
    }
    if (theScore == 2) {
        scoreLabel.textColor = [UIColor greenColor];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You now know about the menstrual cycle!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    Tester *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Overall1"];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Cycle3" object:self];
}

- (void)viewDidUnload
{
    [self setScoreLabel:nil];
    [self setTwentyEight:nil];
    [self setMenstrual:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
