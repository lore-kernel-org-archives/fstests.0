Received: from mx2.suse.de ([195.135.220.15]:39104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936967AbeE2Q4G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:06 -0400
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49797AD69
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/6] dmhugedisk: Allow specifying of chunk size
Date: Tue, 29 May 2018 18:55:56 +0200
Message-Id: <20180529165601.32133-2-jack@suse.cz>
In-Reply-To: <20180529165601.32133-1-jack@suse.cz>
References: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Ext4 will want to use dmhugedisk infrastructure for testing resize bugs.
Ext4 fs images are rather sparse (especially with smaller block sizes) so
the current chunk size of 512 sectors leads to large space consumption.
Allow test to specify chunk size.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/dmhugedisk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/dmhugedisk b/common/dmhugedisk
index 4d3b63fcfcca..733b10cd2292 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -31,6 +31,11 @@ _dmhugedisk_init()
 {
 	test -z "$1" && _fatal "must specify sector count to _dmhugedisk_init"
 	local dm_backing_dev=$SCRATCH_DEV
+	local chunk_size="$2"
+
+	if [ -z "$chunk_size" ]; then
+		chunk_size=512
+	fi
 
 	$DMSETUP_PROG remove huge-test > /dev/null 2>&1
 	$DMSETUP_PROG remove huge-test-zero > /dev/null 2>&1
@@ -41,7 +46,7 @@ _dmhugedisk_init()
 	DMHUGEDISK_DEV='/dev/mapper/huge-test'
 
 	DMHUGEDISK_ZERO_TABLE="0 $blk_dev_size zero"
-	DMHUGEDISK_DEV_TABLE="0 $blk_dev_size snapshot $DMHUGEDISK_ZERO $SCRATCH_DEV N 512"
+	DMHUGEDISK_DEV_TABLE="0 $blk_dev_size snapshot $DMHUGEDISK_ZERO $SCRATCH_DEV N $chunk_size"
 
 	$DMSETUP_PROG create huge-test-zero --table "$DMHUGEDISK_ZERO_TABLE" || \
 		_fatal "failed to create dm huge zero device"
-- 
2.13.6

