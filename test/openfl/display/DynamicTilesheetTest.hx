package openfl.display;
import flash.Lib;
import flash.utils.ByteArray;
import flash.display.Sprite;
import org.hamcrest.core.IsEqual;
import org.hamcrest.MatcherAssert;
import flash.geom.Rectangle;
import openfl.display.Tilesheet;
import flash.display.BitmapData;
import openfl.gl.GL;
class DynamicTilesheetTest {

    var inImage:BitmapData;
    var tileSheet:Tilesheet;
    var sprite:Sprite;
    var output:BitmapData;

    @Setup
    public function setupRedPixel():Void {
        sprite = new Sprite();
        Lib.current.stage.addChild(sprite);
        inImage = new BitmapData(1,1, true, 0xFFFF0000);
        tileSheet = new Tilesheet(inImage);
        var rect:Rectangle = new Rectangle(0,0,1,1);
        tileSheet.addTileRect(rect);
        draw();
    }

//    @Test
//    public function establishRedPixelWithTilesBitmapData():Void {
//        setupRedPixel();
//        draw();
////        var pixels:ByteArray = new ByteArray();
////        pixels.writeInt(5);
////        pixels.position = 0;
////        trace(pixels.readInt());
////        GL.clear(0);
//        var pixels:ByteArray = new ByteArray();
//        pixels.writeInt(0);
//        pixels.position = 0;
//        GL.readPixels(0,0,1,1,GL.RGBA, GL.INT, pixels);
//        pixels.position = 0;
//        trace(pixels.readInt());
////        MatcherAssert.assertThat(pixels.readInt(), IsEqual.equalTo(0xFF0000));
//

	@Test
	public function establishRedPixel():Void {
        setupRedPixel();
        draw();
        MatcherAssert.assertThat(output.getPixel(0,0), IsEqual.equalTo(0xFF0000));
	}

    @Test
    public function testGreenPixelBeforeDraw():Void {
        setupRedPixel();
        inImage.setPixel(0,0, 0x00FF00);
        draw();
        MatcherAssert.assertThat(output.getPixel(0,0), IsEqual.equalTo(0x00FF00));
    }
//
//    @Test
//    public function testGreenPixelAfterDraw():Void {
//        setupRedPixel();
//        draw();
//        inImage.setPixel(0,0, 0x00FF00);
//        draw();
//        MatcherAssert.assertThat(output.getPixel(0,0), IsEqual.equalTo(0x00FF00));
//    }

    function draw():Void {
        tileSheet.drawTiles(sprite.graphics, [0,0,0]);
        output = new BitmapData(1,1);
        output.draw(sprite);
    }
}