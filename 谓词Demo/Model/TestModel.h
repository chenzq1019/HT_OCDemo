//
//  TestModel.h
//  谓词Demo
//
//  Created by 陈竹青 on 2021/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * groupId;
@end

@interface TestModel : NSObject
@property (nonatomic, strong) DataModel * data;
@property (nonatomic, copy) NSString * groupId;
@property (nonatomic, copy) NSString * groupName;
@end

NS_ASSUME_NONNULL_END
