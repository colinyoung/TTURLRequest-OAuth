/*
 
 // 2012 Colin Young

 Purpose
 =======
 
 - Simplifies adding OAuth request headers to a TTURLRequest.
 
 Usage
 =====
 
 1. Set up a TTURLRequest normally
 
    TTURLRequest* request = [TTURLRequest
        requestWithURL: url
        delegate: self];
 
 2. Add the OAuth headers
 
    [request oauthifyWithConsumerKey:token:signatureMethod:version:]
 
*/
#import "Three20/Three20.h"

typedef enum {
    TTURLRequestOAuthSignatureMethodPlaintext,
    TTURLRequestOAuthSignatureMethodHMAC,
    TTURLRequestOAuthSignatureMethodRSA
} TTURLRequestOAuthSignatureMethod;

@interface TTURLRequest (OAuth)

-(void)oauthifyWithConsumerKey:(NSString *)consumerKey
                         token:(NSString *)token
               signatureMethod:(TTURLRequestOAuthSignatureMethod)signatureMethod
                       version:(NSString *)version;

// @private
+(NSString *)stringForSignatureMethod:(TTURLRequestOAuthSignatureMethod)signatureMethod;
+(NSString *)nonce:(int)length;

@end
