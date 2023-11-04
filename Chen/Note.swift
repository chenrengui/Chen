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
  
 */
