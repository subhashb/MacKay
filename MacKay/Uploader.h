//
//  Uploader.h
//  MacKay
//
//  Created by Subhash Bhushan on 17/04/15.
//  Copyright (c) 2015 Subhash Bhushan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Uploader : NSObject {
    NSURL *serverURL;
    NSString *filePath;
    NSString *fileName;
    id delegate;
    SEL doneSelector;
    SEL errorSelector;

    BOOL uploadDidSucceed;
}

-   (id)initWithURL: (NSURL *)serverURL
           filePath: (NSString *)filePath
           fileName: (NSString *)fileName
           delegate: (id)delegate
       doneSelector: (SEL)doneSelector
      errorSelector: (SEL)errorSelector;

-   (NSString *)filePath;
@end
