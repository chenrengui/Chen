//
//  Note.swift
//  Chen
//
//  Created by iOS on 2023/11/4.
//

import Foundation

/**
 
 1:  Autoreleasepool
 
 ①自动释放池的本质是一个autoreleasepoolPage结构体对象,是一个栈结构的存储页,每一个autoreleasepoolPage都是以双向链表的形式连接,每一页的大小为4096字节;
 ②自动释放池的压栈和出栈主要是通过结构体的构造函数和析构函数调用底层的objc_autoreleasepoolPush和objc_autoreleasepoolPop,实际是调用autoreleasepoolPage的push和pop方法;
 ③调用push操作其实就是创建一个新的autoreleasepoolPage,而autoreleasepoolPage的具体操作就是插入一个哨兵pool_boundary,并返回插入的哨兵pool_boundary的内存地址.而push内部调用autoreleaseFast方法处理,主要有以下三种情况:
 -a:当page存在,且不满时,调用add方法将对象添加至page的next指针处,并将next指向下一位
 -b:当page存在,且满了时,调用autoreleaseFullPage初始化一个新的page,然后调用add方法将对象添加至page栈中;
 -c:当page不存在时,调用autoreleaseNoPage创建一个hotPage,然后调用add方法将对象添加至page栈中;
 ④调用pop操作时,会传入一个值,这个值就是push操作的返回值,即哨兵pool_boundary的内存地址token.所以pop的内部实现就是根据token找到哨兵对象所处的page,然后使用objc_release释放token之前的对象,并把next指向正确的位置.
 
 
 2: KVO的底层实现原理
 
 假如我们对Person的实例对象的name(nsstring类型)属性进行kvo监测,Person类会利用runtime机制动态的生成该类的派生子类
 NSKVONotifying_Person的类,该类继承于Person类,并把实例对象的isa指针指向该派生类.
 当修改name属性时,会调用Foundation的_NSSetObjectValueAndNotify函数,在这个函数内部实际调用了以下方法:
 1:调用willChangeValueForKey:
 2:父类原来的setter方法,_name=name
 3:didChangeValueForKey
 内部触发监听方法observeValueForKeyPath:ofObject:change:context:
 
 
 3:weak指针原理
 
 
 runtime维护了一个weak表,用于存储指向某个对象的所有weak指针.weak表其实是一个hash表以对象的地址为key,value是weak指针的地址的数组.
 当一个对象的引用计数为0时,假如该对象的地址为a,则以a为key,搜索weak表中所有a为键的weak对象,从而置为nil.
  
 */
