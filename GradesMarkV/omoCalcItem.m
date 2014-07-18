//
//  omoCalcItem.m
//  GradesMarkV
//
//  Created by -BASE- on 2014-07-01.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import "omoCalcItem.h"

@implementation omoCalcItem

- (id)initWithNameOfItem:(NSString *)name ItemGrade:(int)grade TextFieldTag:(unsigned long)tag{
    
    self = [super init];
    
    self.calcItemName = name;
    self.grade = grade;
    self.tag = tag;
    
    return self;
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"Name:%@ Grade:%d%% TextFieldTag:%lu", self.calcItemName, self.grade, self.tag];
}

@end
