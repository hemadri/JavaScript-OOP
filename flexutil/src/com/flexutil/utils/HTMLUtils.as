package com.flexutil.utils {
	
public class HTMLUtils {
	
	
	public function HTMLUtils() {
	}

	/**
	 * Remove HTML tags
	 * 
	 * @param	s String with HTML tags
	 * @return  String without HTML tags
	 */
	public static function stripTags(s:String):String {
        var i:int;
        while ((i = s.indexOf("<")) != -1) {
            s = s.split(s.substr(i, s.indexOf(">") + 1 - i)).join("");
        }
        return s;
    }	
	

}
}