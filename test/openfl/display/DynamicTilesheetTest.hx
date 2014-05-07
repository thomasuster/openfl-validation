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

	@Test
	public function establishRedPixel():Void {
        setupRedPixel();
        MatcherAssert.assertThat(tileSheet.__bitmap.getPixel(0,0), IsEqual.equalTo(0xFF0000));
	}

    @Test
    public function testSetBitmapData():Void {
        setupRedPixel();
        inImage.setPixel(0,0, 0x00FF00);
        MatcherAssert.assertThat(tileSheet.__bitmap.getPixel(0,0), IsEqual.equalTo(0x00FF00));
    }

    function setupRedPixel():Void {
        inImage = new BitmapData(1,1, true, 0xFFFF0000);
        tileSheet = new Tilesheet(inImage);
        var rect:Rectangle = new Rectangle(0,0,1,1);
        tileSheet.addTileRect(rect);
        var sprite = new Sprite();
        tileSheet.drawTiles(sprite.graphics, [0]);
    }
	
	
}