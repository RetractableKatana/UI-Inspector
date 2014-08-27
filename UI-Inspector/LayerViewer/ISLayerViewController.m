//
//  ISLayerViewController.m
//  UI-Inspector
//
//  Created by James Thompson on 8/26/14.
//  Copyright (c) 2014 IntelligentSprite. All rights reserved.
//

#import "ISLayerViewController.h"
typedef NS_ENUM(NSUInteger, ASCLightName) {
    ASCLightMain = 0,
    ASCLightFront,
    ASCLightSpot,
    ASCLightLeft,
    ASCLightRight,
    ASCLightAmbient,
    ASCLightCount
};

@interface ISLayerViewController ()
{
    SCNNode *_lights[ASCLightCount];

    SCNScene *_scene;
    
    SCNFloor *_floor;
    NSImage  *_floorImage;
    
    SCNNode *_cameraNode;
    SCNNode *_cameraPitch;
    SCNNode *_cameraHandle;
}

@end

@implementation ISLayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        _scene = [SCNScene scene];
        
        _cameraHandle = [SCNNode node];
        _cameraHandle.name = @"cameraHandle";
        [_scene.rootNode addChildNode:_cameraHandle];
        
        _cameraPitch = [SCNNode node];
        _cameraPitch.name = @"cameraPitch";
        [_cameraHandle addChildNode:_cameraPitch];
        
        _cameraNode = [SCNNode node];
        _cameraNode.name = @"cameraNode";
        _cameraNode.camera = [SCNCamera camera];
        
        // Set the default field of view to 70 degrees (a relatively strong perspective)
        _cameraNode.camera.xFov = 70.0;
        _cameraNode.camera.yFov = 42.0;
        [_cameraPitch addChildNode:_cameraNode];
        
        _cameraHandle.position = SCNVector3Make(_cameraHandle.position.x, _cameraHandle.position.y, _cameraHandle.position.z + 5);
        
        // Omni light (main light of the scene)
        _lights[ASCLightMain] = [SCNNode node];
        _lights[ASCLightMain].name = @"omni";
        _lights[ASCLightMain].position = SCNVector3Make(0, 3, -13);
        _lights[ASCLightMain].light = [SCNLight light];
        _lights[ASCLightMain].light.type = SCNLightTypeOmni;
        [_lights[ASCLightMain].light setAttribute:@10 forKey:SCNLightAttenuationStartKey];
        [_lights[ASCLightMain].light setAttribute:@50 forKey:SCNLightAttenuationEndKey];
        [_cameraHandle addChildNode:_lights[ASCLightMain]]; //make all lights relative to the camera node
       
        // Ambient light
        _lights[ASCLightAmbient] = [SCNNode node];
        _lights[ASCLightAmbient].name = @"ambient light";
        _lights[ASCLightAmbient].light = [SCNLight light];
        _lights[ASCLightAmbient].light.type = SCNLightTypeAmbient;
        [_scene.rootNode addChildNode:_lights[ASCLightAmbient]];

        // Create and add a reflective floor to the scene
        SCNMaterial *floorMaterial = [SCNMaterial material];
        floorMaterial.ambient.contents = [NSColor blackColor];
        floorMaterial.diffuse.contents = @"/Library/Desktop Pictures/Circles.jpg";
        floorMaterial.diffuse.contentsTransform = CATransform3DScale(CATransform3DMakeRotation(M_PI / 4, 0, 0, 1), 2.0, 2.0, 1.0);
        floorMaterial.specular.wrapS =
        floorMaterial.specular.wrapT =
        floorMaterial.diffuse.wrapS  =
        floorMaterial.diffuse.wrapT  = SCNWrapModeMirror;
        
        _floor = [SCNFloor floor];
        _floor.reflectionFalloffEnd = 3.0;
        _floor.firstMaterial = floorMaterial;
        
        SCNNode *floorNode = [SCNNode node];
        floorNode.geometry = _floor;
        [_scene.rootNode addChildNode:floorNode];
        
        NSImage *img = [NSImage imageNamed:@"kitten"];
        SCNNode *kitten = [self planeNodeWithImage:img size:1 isLit:NO];
        
        [_scene.rootNode addChildNode:kitten];
        
        kitten.rotation = SCNVector4Make(0, 1, 0, M_PI * 2);
        
        // Set the scene to the view
        self.view = [[SCNView alloc] init];
        self.view.scene = _scene;
        self.view.backgroundColor = [NSColor blackColor];
        
        // Turn on jittering for better anti-aliasing when the scene is still
        self.view.jitteringEnabled = YES;
    }
    
    return self;
}

- (SCNNode *)planeNodeWithImage:(NSImage *)image size:(CGFloat)size isLit:(BOOL)isLit {
    SCNNode *node = [SCNNode node];
    
    float factor = size / (MAX(image.size.width, image.size.height));
    
    node.geometry = [SCNPlane planeWithWidth:image.size.width*factor height:image.size.height*factor];
    node.geometry.firstMaterial.diffuse.contents = image;
    
    //if we don't want the image to be lit, set the lighting model to "constant"
    if (!isLit)
        node.geometry.firstMaterial.lightingModelName = SCNLightingModelConstant;
    
    return node;
}

- (SCNView *)view
{
    return (SCNView *)super.view;
}

@end
