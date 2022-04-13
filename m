Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E6C43217
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 16:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiDMQrQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiDMQrE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 12:47:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFA3B3C2
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 09:44:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2F12A1FCFF;
        Wed, 13 Apr 2022 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649868271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhH/84AHGN0q6LaLG+GTHnxJWCqg1Ebh5hju/hRj41M=;
        b=mkJ+uKEpF++RJN6eVJ0GToFgnlJlT1rTQVnnz7LMWlIp5uAbXSKDZRYb9dbhiydXBPBLwj
        boN5MbvO74bpfNqAbq+6QurJvM4eNuX19LV+9ztpPt4NKEJYgFY/oSf7WtOEYySndYTIHl
        eCz34ld0ievWyF+tG41ln3dy/2rWgow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649868271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhH/84AHGN0q6LaLG+GTHnxJWCqg1Ebh5hju/hRj41M=;
        b=dW1fBdbX1bSlm+UOsBxd8Npud5ycmLqOTlPCEOQqYl13qRlJqhAWxwyfCrRWI3sXJ/2Ygq
        2ZzIUqOnrHj/OkDg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12883A3BA7;
        Wed, 13 Apr 2022 16:44:31 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 3/4] generic/020: fix max_attrval_size for XFS, UDF, Btrfs and NFS
Date:   Wed, 13 Apr 2022 18:44:21 +0200
Message-Id: <20220413164422.30077-4-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220413164422.30077-1-ddiss@suse.de>
References: <20220413164422.30077-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As found by Dave Chinner, fff4359d ("020: make this xattr test generic")
unintentionally changed the long attribute value length from 100K to 64
*bytes* for XFS, UDF and Btrfs.
Update XFS and UDF to use a 64K $max_attrval_size value. For Btrfs, use
the nodesize, xattr length and tree entry overhead sizes to calculate
the maximum.
NFS doesn't provide a way to find out the $max_attrval_size for the
underlying filesystem on the server, so just use a rough 1K limit.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/generic/020 | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/generic/020 b/tests/generic/020
index cbd3f227..f50a4f87 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -113,20 +113,32 @@ _attr_get_max()
 		let max_attrs=$BLOCK_SIZE/40
 	esac
 
-	# Set max attr value size based on fs type
+	# Set max attr value size in bytes based on fs type
 	case "$FSTYP" in
-	xfs|udf|btrfs)
-		max_attrval_size=64
+	btrfs)
+		_require_btrfs_command inspect-internal dump-super
+		local ns=$($BTRFS_UTIL_PROG inspect-internal dump-super \
+				$TEST_DEV | sed -n 's/nodesize\s*\(.*\)/\1/p')
+		[ -n "$ns" ] || _fail "failed to obtain nodesize"
+		# max == nodesize - sizeof(struct btrfs_header)
+		#		- sizeof(struct btrfs_item)
+		#		- sizeof(struct btrfs_dir_item) - name_len
+		max_attrval_size=$(( $ns - 156 - $max_attrval_namelen ))
 		;;
 	pvfs2)
 		max_attrval_size=8192
 		;;
-	9p|ceph|nfs)
+	xfs|udf|9p|ceph)
 		max_attrval_size=65536
 		;;
 	bcachefs)
 		max_attrval_size=1024
 		;;
+	nfs)
+		# NFS doesn't provide a way to find out the max_attrval_size for
+		# the underlying filesystem, so just use the lowest value above.
+		max_attrval_size=1024
+		;;
 	*)
 		# Assume max ~1 block of attrs
 		BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.34.1

