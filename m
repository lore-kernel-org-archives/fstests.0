Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4042C05027
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Feb 2023 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjBCRsy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjBCRsq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2023 12:48:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436CDBFD
        for <fstests@vger.kernel.org>; Fri,  3 Feb 2023 09:48:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1325C236
        for <fstests@vger.kernel.org>; Fri,  3 Feb 2023 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675446474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mObJ04iT1s5hfCYpto/K0Ja5fdt02Q8JopYsXRQRfWM=;
        b=IGwId4Wbe1W2DrCIQR81Tdgjq9OVxNnsMJ3NCyX1TsCeAk0yhiil0NNde3WJ0p/AekeUDx
        cZ3B9J200r8Q/F6cTwTT3oJegT+DFPgyi6Hn8WHynIs6EVFxucYXFwwJRFaARxV2WShdaq
        7YnhR9otlWlAtEQ/c5buwGcugYlPt4U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D23C1346D
        for <fstests@vger.kernel.org>; Fri,  3 Feb 2023 17:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P8XvFcpI3WP3AgAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Fri, 03 Feb 2023 17:47:54 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] xfs/191: fix xattr leaf block emptying on 64k blocksized fses
Date:   Fri,  3 Feb 2023 18:47:44 +0100
Message-Id: <20230203174744.151270-1-ailiop@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test is failing on filesystems with 64k blocksize since the leaf
hdr.firstused field is 16 bit and as such trying to reset it to $dbsize
overflows and is rejected by xfs_db. The leaf is never properly resetted
and the discrepancy is picked up by xfs_repair, thus failing the test.

Fix it by setting it to XFS_ATTR3_LEAF_NULLOFF (0) as this is the proper
on-disk value to indicate an empty leaf on 64k blocksized fses.

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/191 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

v2:
- moved upstream commit comment into a _fixed_by_kernel_commit
- removed trailing semicolons from assignment statements
- add rvbs

diff --git a/tests/xfs/191 b/tests/xfs/191
index 4f0a9b9eeef5..7a02f1be217c 100755
--- a/tests/xfs/191
+++ b/tests/xfs/191
@@ -30,6 +30,7 @@ _supported_fs xfs
 _require_scratch
 _require_scratch_xfs_crc # V4 is deprecated
 _fixed_by_kernel_commit 7be3bd8856fb "xfs: empty xattr leaf header blocks are not corruption"
+_fixed_by_kernel_commit e87021a2bc10 "xfs: use larger in-core attr firstused field and detect overflow"
 _fixed_by_git_commit xfsprogs f50d3462c654 "xfs_repair: ignore empty xattr leaf blocks"
 
 _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
@@ -78,10 +79,19 @@ make_empty_leaf() {
 
 	base=$(_scratch_xfs_get_metadata_field "hdr.freemap[0].base" "inode $inum" "ablock 0")
 
+	# 64k dbsize is a special case since it overflows the 16 bit firstused
+	# field and it needs to be set to the special XFS_ATTR3_LEAF_NULLOFF (0)
+	# value to indicate a null leaf.
+	if [ $dbsize -eq 65536 ]; then
+		firstused=0
+	else
+		firstused=$dbsize
+	fi
+
 	_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" \
 		-c "write -d hdr.count 0" \
 		-c "write -d hdr.usedbytes 0" \
-		-c "write -d hdr.firstused $dbsize" \
+		-c "write -d hdr.firstused $firstused" \
 		-c "write -d hdr.freemap[0].size $((dbsize - base))" \
 		-c print >> $seqres.full
 }
-- 
2.35.3

