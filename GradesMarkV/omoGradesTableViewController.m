//
//  omoGradesTableViewController.m
//  GradesMarkV
//
//  Created by -BASE- on 2014-06-26.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import "omoGradesTableViewController.h"
#import "omoSyllabusItem.h"
#import "omoSyllabusAdderViewController.h"

@interface omoGradesTableViewController ()

@property (nonatomic) omoSyllabusItem *item;

@property (nonatomic) NSMutableArray *gradesArray;
@property (nonatomic) NSMutableArray *adderArrayLabels;

@property (nonatomic) UITextField *tf;

@end

@implementation omoGradesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Adder Array: %@", self.adderArray);
    
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
    
    NSLog(@"Grades Array: %@", self.gradesArray);
    NSLog(@"Adder Labels: %@", self.adderArrayLabels);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections. Each element in omoSyllabusAdder's syllabusItems array represents a section.
    return self.adderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    self.item = self.adderArray[section];
    
    NSLog(@"%d rows for section %d", [self.item.numberOfItems intValue], section);
    

    return [self.item.numberOfItems intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake( cell.contentView.bounds.size.width - 70, (cell.contentView.bounds.size.height-30)/2, 50, 30)];
    
    //[cell.contentView addSubview:self.tv];
    
    [self.tf setDelegate: self];
    self.tf.tag = indexPath.row;
    
    self.tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tf.placeholder = @"0";
    self.tf.backgroundColor = [UIColor grayColor];
    self.tf.borderStyle = UITextBorderStyleRoundedRect;
    
    [cell addSubview:self.tf];
    //[cell setIndentationWidth:-405];
    //[cell setIndentationLevel:1];
    
    cell.textLabel.text =  [self.adderArrayLabels objectAtIndex:indexPath.section];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
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
