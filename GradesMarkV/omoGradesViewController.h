//
//  omoGradesViewController.h
//  GradesMarkV
//
//  Created by -BASE- on 2014-06-27.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface omoGradesViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) NSMutableArray *adderArray, *gradesArray, *adderArrayLabels, *keysArray, *scores;

@property (nonatomic) NSMutableDictionary *gradesTextFields;

@end
