//
//  WXKMultiDelegateManager.m
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import "WXKMultiDelegateManager.h"
#import "WXKToken.h"
#import "NSObject+WXKDisposeBag.h"

@interface WeakObject ()

@property (nonatomic, copy) NSString *key;
@property (nonatomic, weak) NSObject<DelegateManagerDelegate>*delegate;
@property (nonatomic, weak) WeakObject *next;
@property (nonatomic, weak) WeakObject *prev;

@end

@implementation WeakObject

- (instancetype)initWithDelegate:(NSObject<DelegateManagerDelegate>*)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        self.key = NSStringFromClass([delegate class]);
    }
    return self;
}

@end


@interface WeakObjectList ()

@property (nonatomic, weak) WeakObject *head;
@property (nonatomic, weak) WeakObject *tail;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation WeakObjectList

- (instancetype)init {
    if (self = [super init]) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)appendWeakObject:(WeakObject *)weakObject {
    [self.dict setObject:weakObject forKey:weakObject.key];
    if (_head) {
        _tail.next = weakObject;
        weakObject.prev = _tail;
        _tail = weakObject;
    } else {
        _head = _tail = weakObject;
    }
}

- (void)removeWeakObjectWithKey:(NSString *)key {
    WeakObject *weakObject = [self.dict objectForKey:key];
    if (weakObject.next) weakObject.next.prev = weakObject.prev;
    if (weakObject.prev) weakObject.prev.next = weakObject.next;
    if (_head == weakObject) _head = weakObject.next;
    if (_tail == weakObject) _tail = weakObject.prev;
    [self.dict removeObjectForKey:key];
}

@end


@interface WXKMultiDelegateManager ()

@property (nonatomic, strong) WeakObjectList *weakObjectList;

@end

@implementation WXKMultiDelegateManager

+ (WXKMultiDelegateManager *)shared {
    static WXKMultiDelegateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WXKMultiDelegateManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.weakObjectList = [[WeakObjectList alloc] init];
    }
    return self;
}

- (void)addDelegate:(NSObject<DelegateManagerDelegate>*)delegate {
    NSString *key = NSStringFromClass([delegate class]);
    WeakObject *weakObject = [self.weakObjectList.dict objectForKey:key];
    if (!weakObject) {
        WeakObject *newWeakObject = [[WeakObject alloc] initWithDelegate:delegate];
        [self.weakObjectList appendWeakObject:newWeakObject];
        
        WXKToken *token = [[WXKToken alloc] init];
        token.key = key;
        __weak typeof(self) weakSelf = self;
        token.onDispose = ^(NSString * _Nonnull key) {
            [weakSelf.weakObjectList removeWeakObjectWithKey:key];
        };
        if (delegate) {
            [delegate.wxk_disposeBag addToken:token];
        }
    }
}

- (void)testAction {
    WeakObject *head = self.weakObjectList.head;
    while (head != nil) {
        if (head.delegate) {
            [head.delegate testAction];
        }
        head = head.next;
    }
}


@end
