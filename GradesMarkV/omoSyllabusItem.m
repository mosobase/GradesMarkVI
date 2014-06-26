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
               WeightOfItem:(NSString *)weightOfItem{

    self = [super init];
    
    self.numberOfItems = numberOfItems;
    self.nameOfItem = nameOfItem;
    self.weightOfItem = weightOfItem;
    
    return self;
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@ %@ worth %@%%", self.numberOfItems, self.nameOfItem, self.weightOfItem];
}

@end
