//
//  ViewController.m
//  ARKitTest
//
//  Created by 灰谷科技2 on 2018/7/7.
//  Copyright © 2018年 灰谷科技2. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's delegate
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ARFrame *currentFrame = self.sceneView.session.currentFrame;
    
    SCNPlane *plane = [SCNPlane planeWithWidth:0.6f height:0.4f];
    plane.firstMaterial.diffuse.contents = [UIImage imageNamed:@"Image"];
    plane.firstMaterial.lightingModelName = SCNLightingModelConstant;
    
    simd_float4x4 translation = matrix_identity_float4x4;
    translation.columns[3].z = -2;
    simd_float4x4 transform = matrix_multiply(currentFrame.camera.transform, translation);
    
    
    
    SCNNode *node = [SCNNode nodeWithGeometry:plane];
    node.simdTransform = transform;
    
    [self.sceneView.scene.rootNode addChildNode:node];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
