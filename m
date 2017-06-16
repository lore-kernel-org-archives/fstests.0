Received: from mx1.redhat.com ([209.132.183.28]:49268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbdFPTkr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Jun 2017 15:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 823E5C0467C3
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 19:40:47 +0000 (UTC)
Received: from tleilax.poochiereds.net (ovpn-120-225.rdu2.redhat.com [10.10.120.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EA7A189E9
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 19:40:47 +0000 (UTC)
From: Jeff Layton <jlayton@redhat.com>
Subject: [xfstests PATCH v5 1/5] ext4: allow ext4 to use $SCRATCH_LOGDEV
Date: Fri, 16 Jun 2017 15:40:42 -0400
Message-Id: <20170616194046.15923-2-jlayton@redhat.com>
In-Reply-To: <20170616194046.15923-1-jlayton@redhat.com>
References: <20170616194046.15923-1-jlayton@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The writeback error handling test requires that you put the journal on a
separate device. This allows us to use dmerror to simulate data
writeback failure, without affecting the journal.

xfs already has infrastructure for this (a'la $SCRATCH_LOGDEV), so wire
up the ext4 code so that it can do the same thing when _scratch_mkfs is
called.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index ff1b75c9cd25..57001b47a8b7 100644
--- a/common/rc
+++ b/common/rc
@@ -679,6 +679,9 @@ _scratch_mkfs_ext4()
 	local tmp=`mktemp`
 	local mkfs_status
 
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+	    $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
+	    mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
 
 	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
 	mkfs_status=$?
-- 
2.13.0

