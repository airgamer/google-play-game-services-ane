package com.airgamer.ane.playgameservices.leaderboards.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.airgamer.ane.playgameservices.Extension;

public class ShowAllLeaderboardsFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {

		Extension.context.leaderboards.showAllLeaderboards();
		return null;
	}

}
