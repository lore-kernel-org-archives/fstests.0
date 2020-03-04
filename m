Return-Path: <SRS0=J9/m=4V=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC5C3F2D1
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Mar 2020 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83634215A4
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Mar 2020 16:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgCDQLT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:11:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:34914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDQLT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Mar 2020 11:11:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8E4A2AEBD;
        Wed,  4 Mar 2020 16:11:17 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     fstests@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] generic/258: check filesystem support for negative timestamps
Date:   Wed,  4 Mar 2020 16:11:20 +0000
Message-Id: <20200304161120.25764-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some filesystems do not support negative c/m/atime timestamps.  And for
these filesystems, generic/258 will fail.  Since there's currently no way
to check sb->s_time_min from userspace, this patch adds a new common/rc
function _require_negative_timestamps() that will _notrun depending on the
$FSTYP variable.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
Hi!

I'm only adding 'ceph' to the _require_negative_timestamps() case because
that was the only filesystem with s_time_min = 0 that I was able to test.
However, a simple grep indicates there are a few other filesystems that
would also be required there (e.g. nfs version < 4).

Cheers,
--
Luis

 common/rc         | 8 ++++++++
 tests/generic/258 | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index 0306e93cb1ca..067f30cecde7 100644
--- a/common/rc
+++ b/common/rc
@@ -4157,6 +4157,14 @@ _check_xfs_scrub_does_unicode() {
 	return 0
 }
 
+_require_negative_timestamps() {
+	case "$FSTYP" in
+	ceph)
+		_notrun "$FSTYP does not support negative timestamps"
+		;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/258 b/tests/generic/258
index 68b8155d4a9f..dab1a476ed20 100755
--- a/tests/generic/258
+++ b/tests/generic/258
@@ -30,6 +30,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_negative_timestamps
 
 TESTFILE=$TEST_DIR/timestamp-test.txt
 
