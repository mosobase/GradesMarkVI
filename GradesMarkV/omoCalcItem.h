//
//  omoCalcItem.h
//  GradesMarkV
//
//  Created by -BASE- on 2014-07-01.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface omoCalcItem : NSObject

@property (nonatomic) NSString *calcItemName;
@property (nonatomic) int grade;
@property (nonatomic) unsigned long tag;

- (id)initWithNameOfItem:(NSString *)name ItemGrade:(int)grade TextFieldTag:(unsigned long)tag;

- (NSString *)description;


@end
