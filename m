Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B3AC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 01:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BA260234
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 01:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhJ0BlK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Oct 2021 21:41:10 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:53691 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235525AbhJ0BlK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Oct 2021 21:41:10 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id E5CAAE0BADC;
        Wed, 27 Oct 2021 12:38:43 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mfXtq-001Rpf-7T; Wed, 27 Oct 2021 12:38:42 +1100
Date:   Wed, 27 Oct 2021 12:38:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: [PATCH V2] fstests: _require_dm_target should not always skip DAX
 capable devices
Message-ID: <20211027013842.GC4821@dread.disaster.area>
References: <20211026023622.914273-1-david@fromorbit.com>
 <20211026154240.GN24282@magnolia>
 <20211026235058.GB4821@dread.disaster.area>
 <20211027002650.GF24333@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027002650.GF24333@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6178ada4
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=20KFwNOVAAAA:8
        a=4YiegNFFP4TfRq9GAAkA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Recent changes have turned off all dm-error, dm-thin and dm-flakey
tests on pmem devices even when we are not explicitly testing DAX.
This is a regression resulting in a large number of log recovery
tests no longer running on my pmem-based test VMs. I added the "-o
dax=never" mount options to these test configs, only to find it
still would not run the dm tests even though the filesystem will
never use DAX.

Fix this so that the dm target DAX test explicitly ignores the
the block device DAX capability when the filesystem is mounted with
dax=never and hence we can use all the dm targets when the tests are
being run with FSDAX disabled.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
Version 2:
-use -w for grep command to do exact word matching for options.

 common/rc | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 7f693d39..75197453 100644
--- a/common/rc
+++ b/common/rc
@@ -1965,12 +1965,19 @@ _require_sane_bdev_flush()
 }
 
 # Decide if the scratch filesystem is likely to be mounted in fsdax mode.
-# If there's a dax clause in the mount options we assume the test runner
-# wants us to test DAX; or if the scratch device itself advertises dax mode
-# in sysfs.
-__detect_scratch_fsdax()
+# It goes 3 ways based on mount options::
+#	1. "dax" or "dax=always" means always test using DAX
+#	2. "dax=never" means we'll never use DAX
+#	3. "dax=inode" or nothing means "use scratch dev capability" to
+#	    determine whether DAX is going to be used.
+#
+# Returns 0 if DAX will be used, 1 if DAX is not going to be used.
+__scratch_uses_fsdax()
 {
-	_normalize_mount_options | egrep -q "dax(=always| |$)" && return 0
+	local ops=$(_normalize_mount_options)
+
+	echo $ops | egrep -qw "dax(=always| |$)" && return 0
+	echo $ops | grep -qw "dax=never" && return 1
 
 	local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
 	test -e "${sysfs}/dax" && return 0
@@ -1982,6 +1989,8 @@ __detect_scratch_fsdax()
 _require_dm_target()
 {
 	local target=$1
+	local fsdax
+	local bdevdax
 
 	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
 	# behaviour
@@ -1989,7 +1998,7 @@ _require_dm_target()
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
 
-	if __detect_scratch_fsdax; then
+	if __scratch_uses_fsdax; then
 		case $target in
 		stripe|linear|log-writes)
 			;;
