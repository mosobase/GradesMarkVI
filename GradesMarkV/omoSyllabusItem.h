//
//  omoSyllabusItem.h
//  GradesMarkV
//
//  Created by -BASE- on 2014-06-26.
//  Copyright (c) 2014 BASE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface omoSyllabusItem : NSObject

@property (nonatomic) NSString *numberOfItems;
@property (nonatomic) NSString *nameOfItem;
@property (nonatomic) NSString *weightOfItem;

- (id)initWithNumberOfItems:(NSString *)numberOfItems NameofItem:(NSString *)nameOfItem
               WeightOfItem:(NSString *)weightOfItem;

- (NSString *)description;
@end
