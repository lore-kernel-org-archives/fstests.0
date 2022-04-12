Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1143AC433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 11:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbiDLL7h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353054AbiDLL6h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 07:58:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046A6623F
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 03:50:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C114821608;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649760606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwY4bG9YQ616qRq1aG+a9uyxRmYcJ9CWcMj/YXvjgqI=;
        b=GZNe3NQpjoyH5ZBXFnVAWZlx95F4Nth8HpfQfQsYFCBD5IOf4K/as04NGz++T6E2iwnxqd
        r+nr0pzEVrbGL/iLIEmPop1fUxLUHZv7YP+lk88YmKIyOtSpF7DPUddaOg6hxmbIUHtou1
        LZL0+MpH+Mv2ui2676Thh8B7SNS34VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649760606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwY4bG9YQ616qRq1aG+a9uyxRmYcJ9CWcMj/YXvjgqI=;
        b=Bes7zxcA1Ck3f5i69J0XyTJWq8uyAzFXcNAuOBhD7rp3zoymavTGLFbPG6iu9rpLRV1LD9
        pj0QkkfYv8yLWoAQ==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3968A3BB2;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/3] common/attr: fix MAX_ATTRVAL_SIZE for XFS, UDF, Btrfs and NFS
Date:   Tue, 12 Apr 2022 12:50:00 +0200
Message-Id: <20220412105001.14325-3-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412105001.14325-1-ddiss@suse.de>
References: <20220412105001.14325-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As found by Dave Chinner, fff4359d ("020: make this xattr test generic")
unintentionally changed the long attribute value length from 100K to 64
*bytes* for XFS, UDF and Btrfs.
Update XFS and UDF to use 64K MAX_ATTRVAL_SIZE value. For Btrfs, use the
nodesize, xattr length and tree entry overhead sizes to calculate the
maximum.
NFS doesn't provide a way to find out the MAX_ATTRVAL_SIZE for the
underlying filesystem on the server, so just use a rough 1K limit.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/attr | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/common/attr b/common/attr
index a80b10a1..1e1c8f6e 100644
--- a/common/attr
+++ b/common/attr
@@ -328,20 +328,32 @@ _attr_get_max()
 
 	export MAX_ATTRS
 
-	# Set max attr value size based on fs type
+	# Set max attr value size in bytes based on fs type
 	case "$FSTYP" in
-	xfs|udf|btrfs)
-		MAX_ATTRVAL_SIZE=64
+	btrfs)
+		_require_btrfs_command inspect-internal dump-super
+		local ns=$($BTRFS_UTIL_PROG inspect-internal dump-super \
+				$TEST_DEV | sed -n 's/nodesize\s*\(.*\)/\1/p')
+		[ -n "$ns" ] || _fail "failed to obtain nodesize"
+		# max == nodesize - sizeof(struct btrfs_header)
+		#		- sizeof(struct btrfs_item)
+		#		- sizeof(struct btrfs_dir_item) - name_len
+		MAX_ATTRVAL_SIZE=$(( $ns - 156 - $max_attrval_namelen ))
 		;;
 	pvfs2)
 		MAX_ATTRVAL_SIZE=8192
 		;;
-	9p|ceph|nfs)
+	xfs|udf|9p|ceph)
 		MAX_ATTRVAL_SIZE=65536
 		;;
 	bcachefs)
 		MAX_ATTRVAL_SIZE=1024
 		;;
+	nfs)
+		# NFS doesn't provide a way to find out the MAX_ATTRVAL_SIZE for
+		# the underlying filesystem, so just use the lowest value above.
+		MAX_ATTRVAL_SIZE=1024
+		;;
 	*)
 		# Assume max ~1 block of attrs
 		BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.34.1

