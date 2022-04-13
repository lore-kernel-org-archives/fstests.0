Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB45BC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 16:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiDMQrW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiDMQrD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 12:47:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9513B2B9
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 09:44:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB4C21FCFD;
        Wed, 13 Apr 2022 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649868270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTNBRUCOFQUiFwHnsPPG16Gbly90U1iDWMl2GbyBw0E=;
        b=Om0UJW5GSHVUPOsJlxeNKZVpI4saTsJdyOp2PzfiS1a02IWVNvMk0ACNFwaemgJdZSEs2s
        tnQEH1Jqk6yy6iLtTXu+US3rAGfpMzI3vtr/Weu30vuM5qLHT7g5UpdGr7tqPyCt4E7pWo
        FD0Ulw1kWxDvIdU+h2QzBUAFflXDMtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649868270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTNBRUCOFQUiFwHnsPPG16Gbly90U1iDWMl2GbyBw0E=;
        b=/hZIhK9cwOLyPEyE/LTYcwwzp+/gr/r5kX701QfhV6n3oiPV+owK2AxAlf50A5t0uCmrHD
        L0TaGlgxB+43bcCQ==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BCEADA3BA4;
        Wed, 13 Apr 2022 16:44:30 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 1/4] generic/020: move MAX_ATTRS and MAX_ATTRVAL_SIZE logic
Date:   Wed, 13 Apr 2022 18:44:19 +0200
Message-Id: <20220413164422.30077-2-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220413164422.30077-1-ddiss@suse.de>
References: <20220413164422.30077-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

No functional change. MAX_ATTRS and MAX_ATTRVAL_SIZE are only used
within generic/020, so move the logic for determining these values
over there.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/attr       | 75 ----------------------------------------------
 tests/generic/020 | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/common/attr b/common/attr
index dae8a1bb..cce4d1b2 100644
--- a/common/attr
+++ b/common/attr
@@ -264,80 +264,5 @@ _getfattr()
 	return ${PIPESTATUS[0]}
 }
 
-# set maximum total attr space based on fs type
-case "$FSTYP" in
-xfs|udf|pvfs2|9p|ceph|nfs)
-	MAX_ATTRS=1000
-	;;
-ext2|ext3|ext4)
-	# For 4k blocksizes, most of the attributes have an attr_name of
-	# "attribute_NN" which is 12, and "value_NN" which is 8.
-	# But for larger block sizes, we start having extended attributes of the
-	# form "attribute_NNN" or "attribute_NNNN", and "value_NNN" and
-	# "value_NNNN", which causes the round(len(..), 4) to jump up by 4
-	# bytes.  So round_up(len(attr_name, 4)) becomes 16 instead of 12, and
-	# round_up(len(value, 4)) becomes 12 instead of 8.
-	#
-	# For 64K blocksize the calculation becomes
-	# 	max_attrs = (block_size - 32) / (16 + 12 + 16)
-	# or
-	# 	max_attrs = (block_size - 32) / 44
-	#
-	# For 4K blocksize:-
-	# 	max_attrs = (block_size - 32) / (16 + 8 + 12)
-	# or
-	# 	max_attrs = (block_size - 32) / 36
-	#
-	# Note (for 4K bs) above are exact calculations for attrs of type
-	# attribute_NN with values of type value_NN.
-	# With above calculations, for 4k blocksize max_attrs becomes 112.
-	# This means we can have few attrs of type attribute_NNN with values of
-	# type value_NNN. To avoid/handle this we need to add extra 4 bytes of
-	# headroom.
-	#
-	# So for 4K, the calculations becomes:-
-	# 	max_attrs = (block_size - 32) / (16 + 8 + 12 + 4)
-	# or
-	# 	max_attrs = (block_size - 32) / 40
-	#
-	# Assume max ~1 block of attrs
-	BLOCK_SIZE=`_get_block_size $TEST_DIR`
-	if [ $BLOCK_SIZE -le 4096 ]; then
-		let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 8 + 12 + 4)))
-	else
-		let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
-	fi
-	;;
-*)
-	# Assume max ~1 block of attrs
-	BLOCK_SIZE=`_get_block_size $TEST_DIR`
-	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
-	let MAX_ATTRS=$BLOCK_SIZE/40
-esac
-
-export MAX_ATTRS
-
-# Set max attr value size based on fs type
-case "$FSTYP" in
-xfs|udf|btrfs)
-	MAX_ATTRVAL_SIZE=64
-	;;
-pvfs2)
-	MAX_ATTRVAL_SIZE=8192
-	;;
-9p|ceph|nfs)
-	MAX_ATTRVAL_SIZE=65536
-	;;
-bcachefs)
-	MAX_ATTRVAL_SIZE=1024
-	;;
-*)
-	# Assume max ~1 block of attrs
-	BLOCK_SIZE=`_get_block_size $TEST_DIR`
-	# leave a little overhead
-	let MAX_ATTRVAL_SIZE=$BLOCK_SIZE-256
-esac
-
-export MAX_ATTRVAL_SIZE
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/020 b/tests/generic/020
index 29ef853c..c2c285f6 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -51,6 +51,82 @@ _attr_list()
     fi
 }
 
+# set maximum total attr space based on fs type
+case "$FSTYP" in
+xfs|udf|pvfs2|9p|ceph|nfs)
+	MAX_ATTRS=1000
+	;;
+ext2|ext3|ext4)
+	# For 4k blocksizes, most of the attributes have an attr_name of
+	# "attribute_NN" which is 12, and "value_NN" which is 8.
+	# But for larger block sizes, we start having extended attributes of the
+	# form "attribute_NNN" or "attribute_NNNN", and "value_NNN" and
+	# "value_NNNN", which causes the round(len(..), 4) to jump up by 4
+	# bytes.  So round_up(len(attr_name, 4)) becomes 16 instead of 12, and
+	# round_up(len(value, 4)) becomes 12 instead of 8.
+	#
+	# For 64K blocksize the calculation becomes
+	# 	max_attrs = (block_size - 32) / (16 + 12 + 16)
+	# or
+	# 	max_attrs = (block_size - 32) / 44
+	#
+	# For 4K blocksize:-
+	# 	max_attrs = (block_size - 32) / (16 + 8 + 12)
+	# or
+	# 	max_attrs = (block_size - 32) / 36
+	#
+	# Note (for 4K bs) above are exact calculations for attrs of type
+	# attribute_NN with values of type value_NN.
+	# With above calculations, for 4k blocksize max_attrs becomes 112.
+	# This means we can have few attrs of type attribute_NNN with values of
+	# type value_NNN. To avoid/handle this we need to add extra 4 bytes of
+	# headroom.
+	#
+	# So for 4K, the calculations becomes:-
+	# 	max_attrs = (block_size - 32) / (16 + 8 + 12 + 4)
+	# or
+	# 	max_attrs = (block_size - 32) / 40
+	#
+	# Assume max ~1 block of attrs
+	BLOCK_SIZE=`_get_block_size $TEST_DIR`
+	if [ $BLOCK_SIZE -le 4096 ]; then
+		let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 8 + 12 + 4)))
+	else
+		let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
+	fi
+	;;
+*)
+	# Assume max ~1 block of attrs
+	BLOCK_SIZE=`_get_block_size $TEST_DIR`
+	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
+	let MAX_ATTRS=$BLOCK_SIZE/40
+esac
+
+export MAX_ATTRS
+
+# Set max attr value size based on fs type
+case "$FSTYP" in
+xfs|udf|btrfs)
+	MAX_ATTRVAL_SIZE=64
+	;;
+pvfs2)
+	MAX_ATTRVAL_SIZE=8192
+	;;
+9p|ceph|nfs)
+	MAX_ATTRVAL_SIZE=65536
+	;;
+bcachefs)
+	MAX_ATTRVAL_SIZE=1024
+	;;
+*)
+	# Assume max ~1 block of attrs
+	BLOCK_SIZE=`_get_block_size $TEST_DIR`
+	# leave a little overhead
+	let MAX_ATTRVAL_SIZE=$BLOCK_SIZE-256
+esac
+
+export MAX_ATTRVAL_SIZE
+
 # real QA test starts here
 _supported_fs generic
 
-- 
2.34.1

