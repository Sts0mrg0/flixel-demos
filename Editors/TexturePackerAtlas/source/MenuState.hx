package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.AtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.util.FlxSpriteUtil;
import openfl.Assets;

class MenuState extends FlxState
{
	override public function create():Void
	{
		// TexturePackerData is a helper class to store links to atlas image and atlas data files
		var tex1:AtlasFrames = AtlasFrames.texturePackerJSON("assets/test-trim-rotation.png", Assets.getText("assets/test-trim-rotation.json"));
		// Create some sprite
		var x1 = new FlxSprite(20, 20);
		// and loading atlas in it finally
		x1.frames = tex1;
		x1.animation.frameName = "100px-1,202,0,200-Scythescraper.png";
		x1.resetSizeFromFrame();
		x1.angularVelocity = 50;
		x1.flipX = true;
		add(x1);
		
		// Let's create some more atlases (just for testing of rotation and trim support)
		var tex2:AtlasFrames = AtlasFrames.texturePackerJSON("assets/test-rotation.png", Assets.getText("assets/test-rotation.json"));
		var tex3:AtlasFrames = AtlasFrames.texturePackerJSON("assets/test-trim.png", Assets.getText("assets/test-trim.json"));
		var tex4:AtlasFrames = AtlasFrames.texturePackerJSON("assets/test.png", Assets.getText("assets/test.json"));
		var tex5:AtlasFrames = AtlasFrames.texturePackerJSON("assets/anim-trim.png", Assets.getText("assets/anim-trim.json"));
		
		// You can provide first frame to show (see last parameter in loadImageFromTexture() method)
		// Plus you can generate reversed sprites which is useful for animating character in games
		var x1 = new FlxSprite(20, 20);
		x1.frames = tex2;
		x1.animation.frameName = "100px-1,202,0,200-Scythescraper.png";
		x1.resetSizeFromFrame();
		x1.angularVelocity = 50;
		add(x1);
		
		// You can load rotated image from atlas. It is very useful for flash target where drawing rotated graphics is very expensive
		var x2 = new FlxSprite(20, 200);
		var frameToPrerotate:FlxFrame = tex2.getByName("100px-1,202,0,200-Scythescraper.png");
		FlxSpriteUtil.loadRotatedFrame(x2, frameToPrerotate, 72, true, true);
		x2.color = 0xff0000;
		x2.angularVelocity = 50;
		add(x2);
		
		// You can set sprite's frame by using image name in atlas
		var x3 = new FlxSprite(200, 20);
		x3.frames = tex3;
		x3.animation.frameName = "super_element_50px_0.png";
		x3.resetSizeFromFrame();
		x3.centerOrigin();
		x3.facing = FlxObject.LEFT;
		add(x3);
		
		// Animation samples:
		// There are new three methods for adding animation in sprite with TexturePackerData 
		// The old one is still working also
		
		// 1. The first one requires array with names of images from the atlas:
		var x5 = new FlxSprite(300, 20);
		x5.frames = tex5;
		// Array with frame names in animation
		var names:Array<String> = new Array<String>();
		for (i in 0...20)
		{
			names.push("tiles-" + i + ".png");
		}
		
		x5.animation.addByNames("Animation", names, 8);
		x5.animation.play("Animation");
		add(x5);
		
		// 2. The second one requires three additional parameters: image name prefix, array of frame indices and image name postfix
		var x6 = new FlxSprite(300, 200);
		x6.frames = tex5;
		// Array with frame indices in animation
		var indices:Array<Int> = new Array<Int>();
		for (i in 0...20)
		{
			indices.push(i);
		}
		
		x6.animation.addByIndices("Animation", "tiles-", indices, ".png", 8);
		x6.animation.play("Animation", false, false, 1);
		add(x6);
		
		// And the third one requires only image name prefix and it will sort and add all frames with it to animation
		var x7 = new FlxSprite(120, 200);
		x7.frames = tex5;
		x7.animation.addByPrefix("ani", "tiles-", 8);
		x7.animation.play("ani");
		x7.angle = 45;
		add(x7);
		
		var tex6:AtlasFrames = AtlasFrames.sparrow("assets/sparrow/atlas.png", Assets.getText("assets/sparrow/atlas.xml"));
		
		var x8 = new FlxSprite(500, 200);
		x8.frames = tex6;
		x8.animation.addByPrefix("walk", "walk_", 12);
		x8.animation.play("walk");
		add(x8);
		
		var tex7:AtlasFrames = AtlasFrames.libGDX("assets/libgdx/test-me.png", Assets.getText("assets/libgdx/test-me.pack"));
		
		var x9 = new FlxSprite(400, -50);
		x9.frames = tex7;
		x9.animation.frameName = "test01";
		x9.scale.set(0.5, 0.5);
		add(x9);
		
		// Remove atlas bitmaps from memory (useful for targets with hardware acceleration: cpp only atm).
		FlxG.bitmap.dumpCache();
	}
}