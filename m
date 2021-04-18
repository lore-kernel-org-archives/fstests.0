Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDE8C433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF2610FC
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhDRQUE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Apr 2021 12:20:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48566 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231684AbhDRQUE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Apr 2021 12:20:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13IGJXvu018547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Apr 2021 12:19:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E174415C3B0D; Sun, 18 Apr 2021 12:19:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     guaneryu@gmail.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common/rc: teach _require_scratch_swapfile() that swap does not work with DAX
Date:   Sun, 18 Apr 2021 12:19:25 -0400
Message-Id: <20210418161925.240995-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The statement, "ext* and xfs have supported all variants of swap files
since their introduction, so swapon should not fail," is not quite
completely true.  In particular, swapon does not work if the DAX is
active on a swapfile, and that would be true if the file system is
mounted with -o dax.

So if swapon fails, check to see if the swapfile has the
STATX_ATTR_DAX attribute set, and if so, issue a _notrun instead of a
_fail.

Fixes: 725feeff94cc ("common/rc: swapon should not fail for given FS in _require_scratch_swapfile()")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0f91340f..d2fd5c5c 100644
--- a/common/rc
+++ b/common/rc
@@ -2495,8 +2495,17 @@ _require_scratch_swapfile()
 	case "$FSTYP" in
 	ext2|ext3|ext4|xfs)
 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+			local attributes=$($XFS_IO_PROG -c 'statx -r' \
+					"$SCRATCH_MNT/swap" 2>/dev/null | \
+					awk '/stat.attributes / { print $3 }')
 			_scratch_unmount
-			_fail "swapon failed for $FSTYP"
+			if test -n "$attributes" -a \
+				$((attributes & 0x00200000)) -eq $((0x00200000)) ;
+			then
+			    _notrun "DAX swapfiles are not supported"
+			else
+			    _fail "swapon failed for $FSTYP"
+			fi
 		fi
 		;;
 	*)
-- 
2.31.0

