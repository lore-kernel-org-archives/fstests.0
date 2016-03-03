Received: from mx2.suse.de ([195.135.220.15]:47620 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbcCCSQp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 3 Mar 2016 13:16:45 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8A286ADCF
	for <fstests@vger.kernel.org>; Thu,  3 Mar 2016 18:16:43 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] fstests: fix btrfs/048 failure with newer btrfs-progs
Date: Thu,  3 Mar 2016 19:16:27 +0100
Message-Id: <cover.1457028701.git.dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

David Sterba (2):
  filter.btrfs: new filter for property messages
  btrfs/048: user filter for property error messages

 common/filter.btrfs | 12 ++++++++++++
 tests/btrfs/048     |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
1.8.4.5

