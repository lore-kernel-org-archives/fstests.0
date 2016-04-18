Received: from mx2.suse.de ([195.135.220.15]:54905 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbcDRTco (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Apr 2016 15:32:44 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 10224AB5D
	for <fstests@vger.kernel.org>; Mon, 18 Apr 2016 19:32:41 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/5] More page fault stress tests and generic/038 fix
Date: Mon, 18 Apr 2016 21:32:30 +0200
Message-Id: <1461007955-7921-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Hello,

I'm sending couple of changes that I have accumulated locally. The first
patch slightly simplifies the current page fault stress test generic/340.
Another three patches add more page fault stress tests. The last patch
fixes unrelated issue with generic/038 test which didn't properly wait for
the run processes and thus occasionally umount failed with EBUSY.

								Honza
