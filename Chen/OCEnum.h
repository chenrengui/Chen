//
//  OCEnum.h
//  Chen
//
//  Created by iOS on 2023/11/6.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WeaksMon,
    WeaksTue,
    WeaksWed,
    WeaksThu,
    WeaksFri,
    WeaksSat,
    WeaksSun,
} Weaks;

NS_ASSUME_NONNULL_BEGIN

@interface OCEnum : NSObject

@end

NS_ASSUME_NONNULL_END
