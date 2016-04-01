package com.airgamer.ane.playgameservices.player.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.airgamer.ane.playgameservices.Extension;

public class GetActivePlayerFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {

		String jsonPlayerString = Extension.context.currentPlayer.getActivePlayer();

		FREObject player = null;

		try {
			player = FREObject.newObject(jsonPlayerString);
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		}

		return player;
	}

}
