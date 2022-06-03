Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5437C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jun 2022 01:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiFCByU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFCByR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jun 2022 21:54:17 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D303017062
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 18:54:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F31FA10E6DF7
        for <fstests@vger.kernel.org>; Fri,  3 Jun 2022 11:54:14 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwwVx-0020tn-R0
        for fstests@vger.kernel.org; Fri, 03 Jun 2022 11:54:13 +1000
Date:   Fri, 3 Jun 2022 11:54:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 8/8 v2] xfs/189: systemd monitoring of /etc/fstab sucks
Message-ID: <20220603015413.GP227878@dread.disaster.area>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-9-david@fromorbit.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=629969c7
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=2qWbhfOqrkg1V0WdcQQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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
V2:
- use systemctl daemon-reload instead of mtime futzing as Darrick
  suggested.

 tests/xfs/189 | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/189 b/tests/xfs/189
index e601881a..bc7ccca5 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -32,6 +32,23 @@
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
+# mount/systemd sees that /etc/fstab has changed (because mtime changed)
+# and so it whines that systemd needs updating on every mount from this point
+# onwards. Yes, that's totally obnoxious behaviour from mount/systemd but we
+# have to work around it.
+#
+# < systemd leaves the chat >
 #
 . ./common/preamble
 _begin_fstest mount auto quick
@@ -190,6 +207,10 @@ ENDL
 # Example fstab entry
 # /dev/sdb2            /mnt/scratch1        xfs       defaults 0 0
 #
+# Note that to avoid mnt/systemd whining about /etc/fstab being modified, we
+# need to ensure that it reloads it's state once we restore the fstab to
+# original.
+#
 _add_scratch_fstab()
 {
 	# comment out any existing SCRATCH_DEV
@@ -201,7 +222,7 @@ _add_scratch_fstab()
 
 _modify_scratch_fstab()
 {
-	opts=$1
+	local opts=$1
 
 	# modify our fstab entry that we added
 	# modify opts by looking for last word which has non-space chars
@@ -215,6 +236,9 @@ _putback_scratch_fstab()
 
 	# remove the one we added at the end
 	$SED_PROG -i "/# $tag/d" /etc/fstab
+
+	# stop mount/systemd whining that /etcfstab was changed.
+	command -v systemctl > /dev/null 2>&1 && systemctl daemon-reload
 }
 
 # Import common functions.
-- 
Dave Chinner
david@fromorbit.com
