Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3653C433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Jan 2022 19:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiAIT7p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Jan 2022 14:59:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41296 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230452AbiAIT7o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jan 2022 14:59:44 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 209JxfOc009365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Jan 2022 14:59:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 63F2915C33E8; Sun,  9 Jan 2022 14:59:41 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common/rc: fix _check_xfs_scrub_does_unicode on newer versions of libc-bin
Date:   Sun,  9 Jan 2022 14:59:35 -0500
Message-Id: <20220109195935.3453304-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Debian 10 uses ldd from glibc 2.28, where as Debian 11 uses ldd from
glibc 2.31.  Sometime between glibc 2.28 and 2.31, ldd has been
changed so that the message "not a dynamic executable" is sent stderr,
where before it was sent to stdout.  As a result, it caused
regressions for tests such as generic/453 which uses
_check_xfs_scurb_does_unicode:

generic/453 5s ... 	[22:42:03] [22:42:08]- output mismatch (see /results/xfs/results-4k/generic/453.out.bad)
    --- tests/generic/453.out	2022-01-08 15:15:15.000000000 -0500
    +++ /results/xfs/results-4k/generic/453.out.bad	2022-01-08 22:42:08.596982251 -0500
    @@ -4,3 +4,4 @@
     Test files
     Uniqueness of inodes?
     Test XFS online scrub, if applicable
    +	not a dynamic executable
    ...

Fix this by sending stderr from ldd to /dev/null.  This is not a
perfect solution, since it means that even if xfs_scrub was compiled
with libicui18n, we will skip the online scrub portion of generic/453.
However, this fixes the regression when runtime OS is changed from
Debian Buster to Debian Bullseye when xfsprogs is built statically.

In the long run, it would be nice if we could determine whether
xfs_scrub has unicode support without using ldd --- perhaps by
signally this in the output of xfs_scrub -V --- but we'll need to
discuss this with the xfsprogs maintainers.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 87b9b69b..add6170c 100644
--- a/common/rc
+++ b/common/rc
@@ -4909,7 +4909,7 @@ _check_xfs_scrub_does_unicode() {
 
 	# We only care if xfs_scrub has unicode string support...
 	if ! type ldd > /dev/null 2>&1 || \
-	   ! ldd "${XFS_SCRUB_PROG}" | grep -q libicui18n; then
+	   ! ldd "${XFS_SCRUB_PROG}" 2> /dev/null | grep -q libicui18n; then
 		return 1
 	fi
 
-- 
2.31.0

