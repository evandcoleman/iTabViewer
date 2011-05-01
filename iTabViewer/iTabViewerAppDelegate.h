//
//  iTabViewerAppDelegate.h
//  iTabViewer
//
//  Created by Evan Coleman on 4/30/11.
//  Copyright 2011 Evan Coleman. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface iTabViewerAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    IBOutlet WebView *webView;
    NSInteger thisTrack;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)loadTabs:(id)sender;
- (void)updateTab;
- (IBAction)openInBrowser:(id)sender;

@end
