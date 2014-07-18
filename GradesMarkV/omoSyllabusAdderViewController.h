//
//  omoSyllabusAdderViewController.h
//  GradesMarkIV
//
//  Created by -BASE- on 2014-06-26.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface omoSyllabusAdderViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>


@property (nonatomic) NSMutableArray *syllabusItems;

@end
