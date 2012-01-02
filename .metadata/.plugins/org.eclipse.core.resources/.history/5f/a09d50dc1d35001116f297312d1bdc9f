package com.flexutil.utils
{
	import flash.display.Graphics;
	
	import mx.core.FlexVersion;
	import mx.graphics.IStroke;
	
	import qs.utils.GraphicsUtils;

	public class GraphicsUtil
	{
		// ========================================
		// Public methods
		// ========================================
		
		/**
		 * Draw lines connecting the specified iterable set (Array, IList, etc.) of coordinates (Point, etc.) with the specified stroke and dash pattern (optional).
		 */
		public static function drawPolyLine( graphics:Graphics, coordinates:*, stroke:IStroke, pattern:Array = null ):void
		{
			if ( pattern != null )
			{
				GraphicsUtils.drawDashedPolyLine( graphics, stroke, pattern, coordinates );
			}
			else
			{
				if ( coordinates.length == 0 )
					return;

				if(FlexVersion.CURRENT_VERSION == FlexVersion.VERSION_3_0) {
					stroke.apply( graphics );
				}
				if(FlexVersion.CURRENT_VERSION == FlexVersion.VERSION_4_0) {
					stroke.apply( graphics, null, null );
				}
				
				var coordinate:Object = coordinates[ 0 ];
				graphics.moveTo( coordinate.x, coordinate.y );
				for ( var coordinateIndex:int = 1; coordinateIndex < coordinates.length; coordinateIndex++ )
				{
					coordinate = coordinates[ coordinateIndex ];
					graphics.lineTo( coordinate.x, coordinate.y );
				}	
			}
		}
	}
}