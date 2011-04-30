//
//  iTabViewerAppDelegate.h
//  iTabViewer
//
//  Created by Evan Coleman on 4/30/11.
//  Copyright 2011 Evan Coleman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface iTabViewerAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
