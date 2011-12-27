package com.flexutil.icons
{
	/**
	 * 
	 * Class which holds all the embedded images and icons 
	 * @author Hemadri (hemadri@hemadri.com)
	 *  
	 */
//		TODO: Consider adding all images in one swf, which holds the below png's as symbols
	public class IconFactory
	{
		//Icons
		[Embed(source="assets/icons/externalWindow16.png")	] 	public static const EXTERNAL_WINDOW_ICON:Class;
		
		[Embed(source="assets/icons/attachWindow22.png")	] 	public static const ATTACH_WINDOW_ICON:Class;
		
		[Embed(source="assets/icons/guidelines.png")		] 	public static const GUIDE_LINES_ICON:Class;
		
		[Embed(source="assets/icons/menuItem.png")			]	public static const MENU_ICON:Class;
		
		[Embed(source='assets/icons/close-tab.png')			]	public static const REMOVE_ICON:Class;
		
		[Embed(source='assets/icons/tab-new.png')			]	public static const ADD_ICON:Class;
		
		[Embed(source='assets/icons/arrow.png')				]	public static const ARROW_ICON:Class;
		
	}
}