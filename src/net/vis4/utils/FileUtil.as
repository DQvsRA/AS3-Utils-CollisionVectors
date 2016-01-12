package net.vis4.utils 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import net.vis4.Utils;
	/**
	 * ...
	 * @author gka
	 */
	public class FileUtil
	{
		
		public static function write(filename:String, content:String):void
		{
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var req:URLRequest = new URLRequest('http://localhost/fileUtil.php?name='+filename);
			req.requestHeaders.push(header);
			req.method = URLRequestMethod.POST;
			req.data = content;
			new URLLoader(req);
		}
		
	}

}