package openfl.display;
import flash.display.Sprite;
import org.hamcrest.core.IsEqual;
import org.hamcrest.MatcherAssert;
import flash.geom.Rectangle;
import openfl.display.Tilesheet;
import flash.display.BitmapData;
class DynamicTilesheetTest {

    var inImage:BitmapData;
    var tileSheet:Tilesheet;
    var sprite:Sprite;

    @Setup
    public function setupRedPixel():Void {
        inImage = new BitmapData(1,1, false, 0xFFFF0000);
        tileSheet = new Tilesheet(inImage);
        var rect:Rectangle = new Rectangle(0,0,1,1);
        tileSheet.addTileRect(rect);
        sprite = new Sprite();
        draw();
    }

	@Test
	public function establishRedPixel():Void {
        setupRedPixel();
        draw();
        MatcherAssert.assertThat(tileSheet.__bitmap.getPixel(0,0), IsEqual.equalTo(0xFF0000));
	}

    @Test
    public function testGreenPixelBeforeDraw():Void {
        setupRedPixel();
        inImage.setPixel(0,0, 0x00FF00);
        draw();
        MatcherAssert.assertThat(tileSheet.__bitmap.getPixel(0,0), IsEqual.equalTo(0x00FF00));
    }

    @Test
    public function testGreenPixelAfterDraw():Void {
        setupRedPixel();
        draw();
        inImage.setPixel(0,0, 0x00FF00);
        draw();
        MatcherAssert.assertThat(tileSheet.__bitmap.getPixel(0,0), IsEqual.equalTo(0x00FF00));
    }



    function draw():Void {
        tileSheet.drawTiles(sprite.graphics, [0]);
    }
}