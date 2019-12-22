Return-Path: <SRS0=f7WM=2M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A19C2D0C8
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Dec 2019 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D8A206B7
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Dec 2019 21:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLVV1r (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:27:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35475 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbfLVV1r (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Dec 2019 16:27:47 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBMLRgMV031831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Dec 2019 16:27:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CEE10420822; Sun, 22 Dec 2019 16:27:42 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     sandeen@sandeen.net, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic/386: check the correct field from df output
Date:   Sun, 22 Dec 2019 16:27:30 -0500
Message-Id: <20191222212730.378358-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The generic/386 test was checking the "Available" field when it should
have been checking the "1k-blocks" field, which represents the project
quota's hard limit.  On xfs, an empty directory takes no space, so it
doesn't matter.  But for ext4, an empty directory still takes 4k (or
whatever the file system's block size happens to be):

Filesystem           1K-blocks       Used  Available  Use% Pathname
/dev/vdc                512000          4     511996    0% /vdc/test

This causes generic/386 to falsely fail.  There was a confusing
comment claiming that for a very long device name, the df output would
have a line break, and for that reason, the test would extract the
field using $(NF-2).  However, looking at xfsprogs's quota command, I
see no evidence that there is any line breaking logic.  Since we now
want to use the second field, even if there was some line breaking
going on, using $2 should be a better choice.

This fix is needed to fix generic/386 from failing on ext4:

    hard limit 524283904 bytes, expected 524288000

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/386 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/generic/386 b/tests/generic/386
index 0c44c80e..37e9b943 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -62,8 +62,6 @@ _require_scratch
 # both the "df" and the "report" output.  For "report", the line we're
 # interested in contains our project name in the first field.  For "df"
 # it contains our project directory in the last field.
-# But if the device name is too long, the "df" output is broke into two
-# lines, the fourth field is not correct, so take $(NF-2) of "df"
 _filter_quota_rpt() {
 	awk '
 	BEGIN {
@@ -89,7 +87,7 @@ _filter_quota_rpt() {
 			bsize = byte_size($4);
 		} else if ($NF ~ proj_dir) {
 			# this is the "df" output
-			bsize = byte_size($(NF-2));
+			bsize = byte_size($2));
 		} else {
 			next;
 		}
-- 
2.24.1

