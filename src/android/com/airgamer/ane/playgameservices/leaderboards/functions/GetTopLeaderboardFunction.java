package com.airgamer.ane.playgameservices.leaderboards.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.airgamer.ane.playgameservices.Extension;

public class GetTopLeaderboardFunction implements FREFunction {

    @Override
    public FREObject call(FREContext arg0, FREObject[] arg1) {

        String leaderboardId = null;
        int span;
        int leaderboardCollection;
        int maxResults;

        try
        {
            leaderboardId = arg1[0].getAsString();
            span = arg1[1].getAsInt();
            leaderboardCollection = arg1[2].getAsInt();
            maxResults = arg1[3].getAsInt();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }

        if( leaderboardId != null )
            Extension.context.leaderboards.getTopLeaderboard( leaderboardId, span, leaderboardCollection,maxResults);

		return null;

    }

}