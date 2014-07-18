//
//  omoSyllabusItem.m
//  GradesMarkV
//
//  Created by -BASE- on 2014-06-26.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import "omoSyllabusItem.h"

@implementation omoSyllabusItem

- (id)initWithNumberOfItems:(NSString *)numberOfItems NameofItem:(NSString *)nameOfItem
               WeightOfItem:(NSString *)weightOfItem Grade:(int)grade{

    self = [super init];
    
    self.numberOfItems = numberOfItems;
    self.nameOfItem = nameOfItem;
    self.weightOfItem = weightOfItem;
    self.grade = grade;
    
    return self;
    
}

-(NSString *)description{
    /*NSString *plural = [[NSString alloc] init];
    
    if ([self.numberOfItems intValue] > 1)
        plural = @"s";
    else
        plural = @"";*/

    if (!self.grade)
        return [NSString stringWithFormat:@"%@ %@ worth %@%%", self.numberOfItems, self.nameOfItem, self.weightOfItem];
    else
        return [NSString stringWithFormat:@"Got %d in this %@", self.grade, self.nameOfItem];

}

@end
