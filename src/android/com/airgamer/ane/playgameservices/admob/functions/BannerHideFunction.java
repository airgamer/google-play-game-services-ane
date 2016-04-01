package com.airgamer.ane.playgameservices.admob.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.airgamer.ane.playgameservices.Extension;

public class BannerHideFunction implements FREFunction {


	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		Extension.context.banner.hide();
		return null;

	}
}