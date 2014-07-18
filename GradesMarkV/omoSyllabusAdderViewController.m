//
//  omoSyllabusAdderViewController.m
//  GradesMarkIV
//
//  Created by -BASE- on 2014-06-26.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import "omoSyllabusAdderViewController.h"
#import "omoSyllabusItem.h"
#import "omoGradesViewController.h"

@interface omoSyllabusAdderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addSyllabusItem;

@property (nonatomic) IBOutlet UIPickerView *syllabusPicker;

@property (weak, nonatomic) IBOutlet UITableView *overviewTable;

@property (nonatomic) NSArray *presetSyllabusItems;
@property (nonatomic) NSArray *presetSyllabusWeights;
@property (nonatomic) NSArray *presetNumberofItems;

@property (nonatomic) NSString *setSyllabusItems;
@property (nonatomic) NSString *setSyllabusWeights;
@property (nonatomic) NSString *setNumberofItems;

@property (nonatomic) UITapGestureRecognizer *tapGR;

@end

@implementation omoSyllabusAdderViewController

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

    self.presetSyllabusItems = @[@"Assignment", @"Lab", @"Quiz", @"Tutorial", @"Midterm", @"Final"];
    self.presetSyllabusWeights = @[@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60", @"65",
                                   @"70", @"75", @"80", @"85", @"90", @"95"];
    self.presetNumberofItems = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    [self.addSyllabusItem setDelegate:self];
    
    if(!self.syllabusItems)
        self.syllabusItems = [[NSMutableArray alloc] init];
    
    [self.overviewTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}

# pragma mark - Picker

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.syllabusPicker = [[UIPickerView alloc] init];
    [self.syllabusPicker setDataSource: self];
    [self.syllabusPicker setDelegate: self];
    
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
    action:@selector(saved)];
    
    [self.view addGestureRecognizer:self.tapGR];

    textField.inputView = self.syllabusPicker;
    
    //NSLog(@"Number of Items: %@", [self.presetNumberofItems objectAtIndex:0]);
    self.setNumberofItems = [self.presetNumberofItems objectAtIndex:0];
    
    //NSLog(@"Syllabus Item: %@", [self.presetSyllabusItems objectAtIndex:0]);
    self.setSyllabusItems = [self.presetSyllabusItems objectAtIndex:0];
    
    //NSLog(@"Syllabus weights: %@", [self.presetSyllabusWeights objectAtIndex:0]);
    self.setSyllabusWeights = [self.presetSyllabusWeights objectAtIndex:0];
}

- (void)saved {
    [self.addSyllabusItem resignFirstResponder];
    
    omoSyllabusItem *newItem = [[omoSyllabusItem alloc] init];
    newItem.numberOfItems = self.setNumberofItems;
    newItem.nameOfItem = self.setSyllabusItems;
    newItem.weightOfItem = self.setSyllabusWeights;
    
    [self.syllabusItems addObject:newItem];
  
    [self.overviewTable reloadData];
    
    self.tapGR.enabled = NO;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    switch (component) {
        case 0:
            return self.presetNumberofItems.count;
            break;
        case 1:
            return self.presetSyllabusItems.count;
            break;
        case 2:
            return self.presetSyllabusWeights.count;
            break;
        
        default:
            return 0;
            break;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            return [self.presetNumberofItems objectAtIndex:row];
            break;
        case 1:
            return [self.presetSyllabusItems objectAtIndex:row];
            break;
        case 2:
            return [self.presetSyllabusWeights objectAtIndex:row];
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            //NSLog(@"Number of Items: %@", [self.presetNumberofItems objectAtIndex:row]);
            self.setNumberofItems = [self.presetNumberofItems objectAtIndex:row];
            break;
        case 1:
            //NSLog(@"Syllabus Item: %@", [self.presetSyllabusItems objectAtIndex:row]);
            self.setSyllabusItems = [self.presetSyllabusItems objectAtIndex:row];
            break;
        case 2:
            //NSLog(@"Syllabus weights: %@", [self.presetSyllabusWeights objectAtIndex:row]);
            self.setSyllabusWeights = [self.presetSyllabusWeights objectAtIndex:row];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%d rows in section", self.syllabusItems.count);
    return self.syllabusItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    omoSyllabusItem *items = self.syllabusItems[indexPath.row];
    cell.textLabel.text = [items description];
    return cell;
}

# pragma mark - Nav

- (IBAction)done:(id)sender
{
    omoGradesViewController *gvc = [[omoGradesViewController alloc] init];
    gvc.adderArray = self.syllabusItems;
    [self presentViewController:gvc animated:YES completion:nil];
}

@end
