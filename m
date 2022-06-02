Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD8CCCA47A
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiFBAbg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiFBAbe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:31:34 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67EF29B2C0
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:31:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2CE2B5EC465
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 10:31:30 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-001b7f-40
        for fstests@vger.kernel.org; Thu, 02 Jun 2022 10:31:29 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-00CBbd-39
        for fstests@vger.kernel.org;
        Thu, 02 Jun 2022 10:31:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 8/8] xfs/189: systemd monitoring of /etc/fstab sucks
Date:   Thu,  2 Jun 2022 10:31:26 +1000
Message-Id: <20220602003126.2903779-9-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602003126.2903779-1-david@fromorbit.com>
References: <20220602003126.2903779-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=629804e2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=2qWbhfOqrkg1V0WdcQQA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

On a recently upgraded system, xfs/189 still works just fine, but
every test run after it now gets spammed from mount/systemd
like so:

xfs/189 [not run] noattr2 mount option not supported on /dev/vdc
xfs/190 1s ... mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
 1s
xfs/192 3s ... mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
 2s
xfs/193 2s ... mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
 2s
xfs/194 1s ... mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.

This is because xfs/189 modifies /etc/fstab during the test, then
restores it to it's original condition so there's nothing to update.
However, systemd is sees that the mtime of /etc/fstab has changed,
and assumes they sky has fallen and so everything must be reloaded
from scratch to silence the unnecessary "hint".

We can avoid this clumsiness by capturing the mtime of /etc/fstab
before we modify it, and restore it afterwards and that means
systemd doesn't even notice that we've being playing around with
/etc/fstab.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/189 | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/189 b/tests/xfs/189
index e601881a..6287a733 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -32,6 +32,27 @@
 #
 # <---- Normal programming is resumed ---->
 #
+# <---- Bbbzzzzzzztttt ---->
+#
+# < systemd enters the chat >
+#
+# xfs/189 [not run] noattr2 mount option not supported on /dev/vdc
+# xfs/190 1s ... mount: (hint) your fstab has been modified, but systemd still uses
+#        the old version; use 'systemctl daemon-reload' to reload.
+#  1s
+#  xfs/192 3s ... mount: (hint) your fstab has been modified, but systemd still uses
+#        the old version; use 'systemctl daemon-reload' to reload.
+#
+# So now mount/systemd sees that /etc/fstab has changed (because mtime changed)
+# and so it now whines that it needs updating on every mount from this point
+# onwards. Yes, that's totally obnoxious behaviour from mount/systemd but we
+# have to work around it.
+#
+# Hence we save/restore the mtime of /etc/fstab around every modification we
+# make so that any time /etc/fstab is checked in future it won't appear to have
+# changed.
+#
+# < systemd leaves the chat >
 #
 . ./common/preamble
 _begin_fstest mount auto quick
@@ -190,31 +211,46 @@ ENDL
 # Example fstab entry
 # /dev/sdb2            /mnt/scratch1        xfs       defaults 0 0
 #
+# Note that to avoid systemd whinging about /etc/fstab being modified, we
+# need to ensure the mtime of /etc/fstab does not change across all these
+# modifications.
+#
 _add_scratch_fstab()
 {
+	local mtime="$(stat -c %y /etc/fstab)"
+
 	# comment out any existing SCRATCH_DEV
 	$SED_PROG -i "s;$SCRATCH_DEV;#$SCRATCH_DEV;" /etc/fstab
 
 	# add our fstab entry
 	echo "$SCRATCH_DEV $SCRATCH_MNT xfs defaults 0 0 # $tag" >> /etc/fstab
+
+	touch -m --date="$mtime" /etc/fstab
 }
 
 _modify_scratch_fstab()
 {
-	opts=$1
+	local opts=$1
+	local mtime="$(stat -c %y /etc/fstab)"
 
 	# modify our fstab entry that we added
 	# modify opts by looking for last word which has non-space chars
 	$SED_PROG -i "s; [^ ]* 0 0 # $tag; $opts 0 0 # $tag;" /etc/fstab
+
+	touch -m --date="$mtime" /etc/fstab
 }
 
 _putback_scratch_fstab()
 {
+	local mtime="$(stat -c %y /etc/fstab)"
+
 	# uncomment out any existing SCRATCH_DEV
 	$SED_PROG -i "s;#$SCRATCH_DEV;$SCRATCH_DEV;" /etc/fstab
 
 	# remove the one we added at the end
 	$SED_PROG -i "/# $tag/d" /etc/fstab
+
+	touch -m --date="$mtime" /etc/fstab
 }
 
 # Import common functions.
-- 
2.35.1

