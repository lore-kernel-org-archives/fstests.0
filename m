Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95145C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiEXHeR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiEXHeQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:16 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 454C76A431
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 705B910E6A8A
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVC-EC
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A5r-Cu
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/8] fstests: _cleanup overrides are messy
Date:   Tue, 24 May 2022 17:34:05 +1000
Message-Id: <20220524073411.1943480-3-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628c8a76
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=9dcxUXK1SNDWFtc7YjUA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Most _cleanup() function overrides look like:

_cleanup()
{
	# do something test specific
	cd /
	rm -rf $tmp.*
}

But they often get the last two lines either wrong or omit them.
These are the lines the common/preamble::_cleanup() define.

The problem here is that we are just overriding the generic _cleanup
function by redeclaring it after calling _begin_fstest. What we
should be doing is registering a new local cleanup function that
calls the generic cleanup function when we have finished the local
cleanup. i.e.:

_local_cleanup()
{
	# do something test specific

	_cleanup
}

Make _register_cleanup() function to cancel the existing
cleanup trap and register the new trap function so that local
cleanups can be done cleanly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/preamble | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/preamble b/common/preamble
index e60cd949..7aa55dc6 100644
--- a/common/preamble
+++ b/common/preamble
@@ -4,7 +4,9 @@
 
 # Boilerplate fstests functionality
 
-# Standard cleanup function.  Individual tests can override this.
+# Standard cleanup function. If individual tests register their own cleanup
+# function, they need to call this from within their own cleanup function once
+# the test has finished cleaning up it's own state.
 _cleanup()
 {
 	cd /
@@ -19,6 +21,9 @@ _register_cleanup()
 	local cleanup="$1"
 	shift
 
+	# clear out existing traps first
+	trap - EXIT HUP INT QUIT TERM $*
+
 	test -n "$cleanup" && cleanup="${cleanup}; "
 	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
 }
-- 
2.35.1

