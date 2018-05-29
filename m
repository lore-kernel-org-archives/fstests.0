Received: from mx2.suse.de ([195.135.220.15]:39098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936975AbeE2Q4G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:06 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F179AD0E
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/6] ext4: Test for resize overflow
Date: Tue, 29 May 2018 18:55:55 +0200
Message-Id: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Hello,

this series add a test for ext4 resize oveflow bug. It also contains a few
other cleanups that Eryu wanted.

								Honza
