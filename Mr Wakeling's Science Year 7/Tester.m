//
//  Tester.m
//  Mr Wakeling's Science Year 7
//
//  Created by robert wakeling on 09/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tester.h"

@interface Tester ()

@end

@implementation Tester
@synthesize myTableView;
@synthesize allCompletedTopics;
@synthesize levelThreeProgress;
@synthesize levelFourProgress;
@synthesize levelFiveProgress;
@synthesize levelSixProgress;
@synthesize overallProgress;
@synthesize finalOverallLevel;
@synthesize three;
@synthesize four;
@synthesize five;
@synthesize six;
@synthesize overall;

@synthesize levelThree, levelFour, levelFive, levelSix;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

    -(void)receiveNotification:(NSNotification *)notification
    {
  
    
    if (!path) {
        
        
        path = [[NSBundle mainBundle] pathForResource:@"OverallDictionary" ofType:@"plist"];
        theDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    
    NSArray *temporaryArray = [theDictionary allKeys];
    
    for (id key in temporaryArray) {
        if ([[notification name] isEqualToString:key]) {
            if (!allCompletedTopics) {
                allCompletedTopics = [[NSMutableArray alloc] init];
            }
            if (![allCompletedTopics containsObject:[[theDictionary valueForKey:key] valueForKey:@"Title"]]) {
                [allCompletedTopics addObject:[[theDictionary valueForKey:key] valueForKey:@"Title"]];
                defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:allCompletedTopics forKey:@"hi"];
                theFinalScore++;
                [[NSUserDefaults standardUserDefaults] setInteger:theFinalScore forKey:@"theFinalScore"];
                [self updateTheProgressView];
                
            }
        }
    }
    NSLog(@"received %@", allCompletedTopics);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];
        [myTableView reloadData];
        myTableView.backgroundColor = [UIColor orangeColor];
    }

    - (void)viewDidLoad
    {
    
    [super viewDidLoad];
        
        myTableView.backgroundColor = [UIColor redColor];
        
    
	// Do any additional setup after loading the view.
    allCompletedTopics = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hi"] mutableCopy];
    
    [defaults setObject:allCompletedTopics forKey:@"theKey"];
    
    if (!path) {
        path = [[NSBundle mainBundle] pathForResource:@"OverallDictionary" ofType:@"plist"];
        theDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
        //  NSLog(@"Created on view did load");
    }
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"];
    NSArray *theKeys = [[NSArray alloc] initWithContentsOfFile:path1];
    
    for (NSString *theString in theKeys) {
        //  NSLog(@"%@", theString);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:theString object:nil];
        
    }
    theFinalScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"theFinalScore"];
    
    [self updateTheProgressView];
    NSLog(@"%@", allCompletedTopics);
    //   [myTableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"reloadTheTable" object:nil];
    }

- (void)reloadTable
//:(NSNotification *)notification
{
    [myTableView reloadData];
    NSLog(@"hi %@", myTableView.description);
    
}

-(IBAction)pushToFirstView {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


    -(void)creatingTheData
    {
    
    
    if (!levelThree) {
        levelThree = [[NSMutableArray alloc] init];
    }
   
    levelThreeFinal = [[NSMutableArray alloc] initWithCapacity:48];
   
    
    for (NSString *object in allCompletedTopics) {
        if (([object rangeOfString:@"level 3"].location != NSNotFound) && (![levelThree containsObject:object]))
        {
          //  NSLog(@"%@", object);
            
            [levelThree addObject:object];
            NSString *theTemp = [object substringToIndex:object.length - 8];
            [levelThreeFinal addObject:theTemp];
            
            
        }
        levelThreeDict = [NSDictionary dictionaryWithObject:levelThreeFinal forKey:@"Levels"];
            }
 
    
    allLevels = [[NSMutableArray alloc] initWithObjects:levelThreeDict,
                 //levelFourDict,
                 //levelFiveDict,
                 //levelSixDict,
                 nil];
    
    }



-(void)updateTheProgressView
{
    [self creatingTheData];
    
    float temporary = theFinalScore;
    overallProgress.progress = temporary / 192;
  
    float theFloatThree = levelThree.count;
 
    levelThreeProgress.progress = theFloatThree / 48;
        
    three.text = [NSString stringWithFormat:@"%.1f %%", theFloatThree/48 * 100];
         
}


    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        //return [[[allLevels objectAtIndex:section] objectForKey:@"Levels"] count];

        return allCompletedTopics.count;
    }

    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        //return allLevels.count;
        return 1;
    }

    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        
        
          cell.textLabel.text = [allCompletedTopics objectAtIndex:indexPath.row];
        /*
        NSDictionary *dictionary = [allLevels objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Levels"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = cellValue;
        */
        return cell;
    }

    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
       /*
        NSString *theTitle = [[NSString alloc] init];
        
        switch (section) {
            case 0:
                theTitle = @"Level 3";
                break;
            case 1:
                theTitle = @"Level 4";
                break;
            case 2:
                theTitle = @"Level 5";
                break;
            case 3:
                theTitle = @"Level 6";
                break;
            default:
                break;
        }
        //return theTitle;
        */
        return @"Your progress so far!";
    }


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *theCompletedViewController = [theDictionary objectForKey:];
   // NSLog(@"%@", tableView);
   // NSLog(@"%@", [theDictionary allKeysForObject:indexPath]);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.myTableView reloadData];
    NSLog(@"Hello");
}

- (void)viewDidUnload
{
    [self setLevelSixProgress:nil];
    [self setLevelFiveProgress:nil];
    [self setLevelFourProgress:nil];
    [self setLevelThreeProgress:nil];
    [self setFinalOverallLevel:nil];
    [self setThree:nil];
    [self setFour:nil];
    [self setFive:nil];
    [self setSix:nil];
    [self setOverall:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
