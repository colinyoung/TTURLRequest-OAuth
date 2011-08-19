/*

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
    TTURLRequestOAuthSignatureMethodPlaintext
    /* @todo Research and add other signature methods */
} TTURLRequestOAuthSignatureMethod;

@interface TTURLRequest (OAuth)

-(void)oauthifyWithConsumerKey:(NSString *)_consumerKey
                         token:(NSString *)_token
               signatureMethod:(TTURLRequestOAuthSignatureMethod)_signatureMethod
                       version:(NSString *)_version;

// @private
+(NSString *)stringForSignatureMethod:(TTURLRequestOAuthSignatureMethod)_signatureMethod;

@end
