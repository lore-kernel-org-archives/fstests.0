Received: from mx2.suse.de ([195.135.220.15]:43689 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbeENRD6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 13:03:58 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C8BAAC7F
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 17:03:57 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] Fix various small quota tests issues for ext[234]
Date: Mon, 14 May 2018 19:03:48 +0200
Message-Id: <20180514170351.13737-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Hello,

these patches fix various smaller issues with quota tests with older kernels
and other not so common configurations.

								Honza
