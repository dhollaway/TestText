package {

import starling.core.Starling;
import starling.display.Sprite;

import flash.filesystem.File;

import starling.display.Image;
import starling.events.Event;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.AssetManager;

[SWF(frameRate = "60", width = "960", height = "640", backgroundColor = "0x000000")]

public class Game extends Sprite
{

    private var screenWidthDetermined:int = Starling.current.nativeStage.stageWidth;
    private var assets:AssetManager = new AssetManager ();
    private var appDir:File = File.applicationDirectory;
    private var gameFont:starling.text.TextField;
    //private var bitMapFont:BitmapFont;
    private var background:Image;

    public function Game() {
        trace ("we're in Starling Land!");
        this.addEventListener (starling.events.Event.ADDED_TO_STAGE, loadScreen);
    }


    private function loadScreen(e:starling.events.Event):void {
        this.removeEventListener (starling.events.Event.ADDED_TO_STAGE, loadScreen);
        onAddedToStage ();
    }

    private function onAddedToStage():void {
        trace ("Assets are loading now!!!!!!!!!");
        assets.enqueue(appDir.resolvePath("font/"));
        assets.loadQueue (function (ratio2:Number):void {
            if (ratio2 == 1.0)
            {
                drawScreen ();
            }
        });
    }


    //Draws the assets onto the screen.
    private function drawScreen():void
    {
        trace ("drawScreen is loaded!");

        background = new Image(assets.getTexture("background"));
        addChild(background);

        //http://forum.starling-framework.org/topic/bad-quality-using-distancefieldstyle-in-bitmapfonttextrenderer
        //"Beirut"
        var texture:Texture = assets.getTexture("gameFont");
        var xml:XML = XML (assets.getXml ("gameFont.fnt"));
        trace("texture is null? " + (texture==null));
        trace("font xml is null? " + (xml == null));
        var bf:BitmapFont = new BitmapFont (texture, xml);

        var textField:starling.text.TextField = new starling.text.TextField (200, 100, "HELLO");
        textField.format.font = "Beirut";
        BitmapFont.NATIVE_SIZE;
        textField.format.size = -1;
        textField.x = 50;
        textField.y = 100;

        textField.border = true;

        addChild (textField);
        trace (textField);


    }

}

}

