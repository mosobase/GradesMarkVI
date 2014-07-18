//
//  omoGradesViewController.m
//  GradesMarkV
//
//  Created by -BASE- on 2014-06-27.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import "omoGradesViewController.h"
#import "omoSyllabusItem.h"
#import "omoSyllabusAdderViewController.h"
#import "omoCalcItem.h"
#include <math.h>

@interface omoGradesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *gradesTableView;
@property (weak, nonatomic) IBOutlet UITextField *targetAvg;
@property (weak, nonatomic) IBOutlet UILabel *currentAvg;

@property (nonatomic) omoSyllabusItem *item;

@property (nonatomic) UITapGestureRecognizer *tapGR;

@property (nonatomic) NSString *temp, *textFieldTemp, *placeholder;

@end

@implementation omoGradesViewController

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
    
    self.placeholder = @"0%";
    
    //NSLog(@"Adder Array: %@", self.adderArray);
    
    if(!self.gradesArray)
        self.gradesArray = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < self.adderArray.count; x++){
        self.item = self.adderArray[x];
        
        int y = [self.item.numberOfItems intValue];
        
        for (int z = 0; z < y; z ++) {
            [self.gradesArray addObject:self.item.nameOfItem];
        }
    }
    
    if(!self.adderArrayLabels)
        self.adderArrayLabels = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < self.adderArray.count; x++) {
        self.item = self.adderArray[x];
        [self.adderArrayLabels addObject: self.item.nameOfItem];
    }
    
    if(!self.scores)
        self.scores = [[NSMutableArray alloc] init];
    
    for(int x = 0; x < self.adderArray.count; x++){
        NSMutableDictionary *subScores = [[NSMutableDictionary alloc] init];
        [self.scores addObject:subScores];
    }
    
    //NSLog(@"Grades Array: %@", self.gradesArray);
    //NSLog(@"Adder Labels: %@", self.adderArrayLabels);
    
    [self.gradesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections. Each element in omoSyllabusAdder's syllabusItems array represents a section.
    return self.adderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    self.item = self.adderArray[section];
    
    return [self.item.numberOfItems intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cell
    UITableViewCell *cell = [self.gradesTableView dequeueReusableCellWithIdentifier:@"Cell"];// forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"Cell"];
    }
    
    if(!self.temp)
        self.temp = [[NSString alloc] init];
    
//    if(indexPath.row+1)
        self.temp = [NSString stringWithFormat:@"%@ %d", self.adderArrayLabels[indexPath.section], indexPath.row+1];
    
    cell.textLabel.text = self.temp;
    
    //TextField in cell
    UITextField *gradeTextField = [[UITextField alloc] initWithFrame:CGRectMake(215, (cell.contentView.bounds.size.height-30)/2, 60, 40)];
    
    [gradeTextField setDelegate: self];
    
    int tag = [[NSString stringWithFormat:@"%d%d", indexPath.section, indexPath.row] intValue];
    gradeTextField.tag = tag;
    
    
    gradeTextField.textAlignment = NSTextAlignmentCenter;
    gradeTextField.placeholder = self.placeholder;
    gradeTextField.backgroundColor = [UIColor clearColor];
    gradeTextField.borderStyle = UITextBorderStyleRoundedRect;
    gradeTextField.keyboardType = UIKeyboardTypeDecimalPad;
    gradeTextField.adjustsFontSizeToFitWidth = YES;
    
    for(NSString *k in self.keysArray){
        NSString *tag = [NSString stringWithFormat:@"%d", gradeTextField.tag];
        if ([k isEqual: tag]) {
            gradeTextField.text = [self.gradesTextFields objectForKey:k];
        }
    }
    
    cell.accessoryView = gradeTextField;
    
    return cell;
}

#pragma mark - TextFields

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //NSLog(@"%@", textField);
    if (textField == self.targetAvg) {
        self.targetAvg.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:self.tapGR];
    self.textFieldTemp = textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([self.textFieldTemp isEqualToString:textField.text])
        return;
    
    else if(textField == self.targetAvg)
        self.targetAvg.text = textField.text;
    
    else {
        [self saveText:textField];
    }
    
    [self average];
}

- (void)saveText:(UITextField *)textField{
    int index = 0;
    
    if (10 - textField.tag > 0)
        index = 0;
    else
        index = [[[NSString stringWithFormat:@"%d", textField.tag] substringToIndex:1] intValue];
    
    
    if(!self.gradesTextFields)
        self.gradesTextFields = [[NSMutableDictionary alloc] init];
    
    if(!self.keysArray)
        self.keysArray = [[NSMutableArray alloc] init];
    
    
    NSString *key = [NSString stringWithFormat:@"%d", textField.tag];
    
    [self.gradesTextFields setValue:textField.text forKey:key];
    
    [self.keysArray addObject:key];
    
    //NSLog(@"%@", self.gradesTextFields);
    
    NSMutableDictionary *temp = self.scores[index];
    
    if ([textField.text isEqual:@""])
        [temp removeObjectForKey:key];
    else
        [temp setValue:textField.text forKey:key];
    
    NSLog(@"SCROES: \n%@", self.scores);
}

- (void)tap:(id)sender {
    [self.view endEditing:YES];
    self.tapGR.enabled = NO;
}

#pragma mark - Other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AverageCalc

- (void)average{
    int index = 0;
    float noAvailableGrades = 0.0;
    float sumOfGrades = 0.0;
    float itemWeight = 0.0;
    float noItems = 0.0;
    float adjustedWeight = 0.0;
    float partialAvg = 0.0;
    float totalAdjustedWeight = 0.0;
    float average = 0.0;
    
    float achieved = 0.0;
    float required = 0.0;
    
    for(NSMutableDictionary *dictionaries in self.scores)
    {
        for(id key in dictionaries)
        {
            noAvailableGrades++;
            sumOfGrades += [[dictionaries valueForKey:key] floatValue];
            
            if (10 - [key intValue] > 0)
                index = 0;
            else
                index = [[[NSString stringWithFormat:@"%@", key] substringToIndex:1] intValue];
            
            for (omoSyllabusItem *x in self.adderArray)
                if ([x.nameOfItem isEqual:self.adderArrayLabels[index]])
                {
                    itemWeight = [x.weightOfItem floatValue];
                    noItems = [x.numberOfItems floatValue];
                }

            adjustedWeight = (itemWeight/noItems) * noAvailableGrades;
        }
        totalAdjustedWeight += adjustedWeight;
        
        if (noAvailableGrades == 0)
            noAvailableGrades = 1.0;
        
        partialAvg += adjustedWeight * (sumOfGrades/(noAvailableGrades*100));

        achieved += (sumOfGrades/noAvailableGrades) * (adjustedWeight/100);

        adjustedWeight = 0.0;
        noAvailableGrades = 0.0;
        sumOfGrades = 0.0;
    }
    
    if([self.targetAvg.text isEqualToString:@""])
    {
        self.placeholder = @"0%";
        [self.gradesTableView reloadData];
    }
    else
    {
        
        required = ceilf(([self.targetAvg.text floatValue] - achieved)*(100/(100-totalAdjustedWeight)));
        
        if (required < 0)
            required = 0;
        
        NSLog(@"%f", required);
        
        self.placeholder = [NSString stringWithFormat:@"%.0f%%", required];
        [self.gradesTableView reloadData];
    }
    
    average = floor(partialAvg*(100/totalAdjustedWeight));
    
    if(isnan(average))
        self.currentAvg.text = @"CUR AVG";
    else
        self.currentAvg.text = [NSString stringWithFormat:@"%.0f", average];
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

@end