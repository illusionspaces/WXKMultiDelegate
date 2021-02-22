//
//  WXKMultiDelegateManager.h
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DelegateManagerDelegate <NSObject>

- (void)testAction;

@end

@interface WeakObject : NSObject

@end

@interface WeakObjectList : NSObject

@end

@interface WXKMultiDelegateManager : NSObject

+ (WXKMultiDelegateManager *)shared;

- (void)addDelegate:(NSObject<DelegateManagerDelegate>*)delegate;

- (void)testAction;

@end

NS_ASSUME_NONNULL_END
