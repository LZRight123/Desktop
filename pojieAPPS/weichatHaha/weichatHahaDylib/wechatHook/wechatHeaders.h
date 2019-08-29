//
//  wechatHeaders.h
//  wechatHook
//
//  Created by antion on 2017/5/5.
//
//

#ifndef wechatHeaders_h
#define wechatHeaders_h


@class BaseResponse, NSString;

@interface WXPBGeneratedMessage : NSObject
{
    int _has_bits_[3];
    int _serializedSize;
    struct PBClassInfo *_classInfo;
    id *_ivarValueDict;
}

+ (id)parseFromData:(id)arg1;
- (id)baseResponse;
- (int)computeValueSize:(id)arg1 fieldNumber:(int)arg2 fieldType:(unsigned char)arg3;
- (int)computeValueSizeNoTag:(id)arg1 fieldType:(unsigned char)arg2;
- (unsigned int)continueFlag;
- (void)dealloc;
- (_Bool)hasProperty:(int)arg1;
- (int)indexOfPropertyWithGetter:(const char *)arg1;
- (int)indexOfPropertyWithSetter:(const char *)arg1;
- (id)init;
- (_Bool)isInitialized;
- (_Bool)isMessageInitialized:(id)arg1;
- (id)mergeFromCodedInputData:(struct CodedInputData *)arg1;
- (id)mergeFromData:(id)arg1;
- (id)readValueFromCodedInputData:(struct CodedInputData *)arg1 fieldType:(unsigned char)arg2;
- (id)serializedData;
- (int)serializedSize;
- (void)setBaseRequest:(id)arg1;
- (void)setValue:(id)arg1 atIndex:(int)arg2;
- (id)valueAtIndex:(int)arg1;
- (void)writeToCodedOutputData:(struct CodedOutputData *)arg1;
- (void)writeValueToCodedOutputData:(struct CodedOutputData *)arg1 value:(id)arg2 fieldNumber:(int)arg3 fieldType:(unsigned char)arg4;
- (void)writeValueToCodedOutputDataNoTag:(struct CodedOutputData *)arg1 value:(id)arg2 fieldType:(unsigned char)arg3;

@end

@interface SKBuiltinBuffer_t : WXPBGeneratedMessage
{
}

+ (void)initialize;
+ (id)skBufferWithData:(id)arg1;

// Remaining properties
@property(retain, nonatomic) NSData *buffer; // @dynamic buffer;
@property(nonatomic) unsigned int iLen; // @dynamic iLen;

@end

@interface HongBaoRes : WXPBGeneratedMessage
{
}

+ (void)initialize;

// Remaining properties
@property(retain, nonatomic) BaseResponse *baseResponse; // @dynamic baseResponse;
@property(nonatomic) int cgiCmdid; // @dynamic cgiCmdid;
@property(retain, nonatomic) NSString *errorMsg; // @dynamic errorMsg;
@property(nonatomic) int errorType; // @dynamic errorType;
@property(retain, nonatomic) NSString *platMsg; // @dynamic platMsg;
@property(nonatomic) int platRet; // @dynamic platRet;
@property(retain, nonatomic) SKBuiltinBuffer_t *retText; // @dynamic retText;

@end

#endif /* wechatHeaders_h */
