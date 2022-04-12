Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC84C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 11:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDLL7k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353084AbiDLL6i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 07:58:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A266239
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 03:50:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9EC45210ED;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649760606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjIjmgdjQ7FA0Bf30wcaacIz2cHvz+vq/dX8W5UjBf4=;
        b=LQ2/FOcavZD98T76CF4o3Kpuy6KvrkOKNWUbF8XQNpdZlb+xKBJvhxmX5u8vuzkg4ItNB2
        97nXwz9AnheL9T9pAB6JWLuxCD/cHxN92Glyu1qUGz7fl4HrHjHo3kFe50on8C21sXgU7s
        owXkgatDxGipY5hyV8eVXUbtMvr64tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649760606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjIjmgdjQ7FA0Bf30wcaacIz2cHvz+vq/dX8W5UjBf4=;
        b=sLx5TUdUYQcz56Agz2SlYuC8q/ucvz/0Q6aKi2mkFlGGcJEnbfkBXkcC9kt7MmaFq2g+ZV
        Vk68HZIgZ+0k4CAg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 800E7A3BAD;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/3] common/attr: add and use _attr_get_max()
Date:   Tue, 12 Apr 2022 12:49:59 +0200
Message-Id: <20220412105001.14325-2-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412105001.14325-1-ddiss@suse.de>
References: <20220412105001.14325-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

No functional change. The MAX_ATTRS and MAX_ATTRVAL_SIZE exports are
only used by generic/020. In preparation for taking into account the
attr name length when calculating MAX_ATTRVAL_SIZE, split the current
logic out into a _attr_get_max() helper function.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/attr       | 163 +++++++++++++++++++++++++---------------------
 tests/generic/020 |  10 ++-
 2 files changed, 95 insertions(+), 78 deletions(-)

diff --git a/common/attr b/common/attr
index dae8a1bb..a80b10a1 100644
--- a/common/attr
+++ b/common/attr
@@ -264,80 +264,93 @@ _getfattr()
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
+# export fs-specific MAX_ATTRS and MAX_ATTRVAL_SIZE values. The parameter
+# @max_attrval_namelen is required for filesystems which take into account attr
+# name lengths (including namespace prefix) when determining limits.
+_attr_get_max()
+{
+	local max_attrval_namelen="$1"
+
+	# set maximum total attr space based on fs type
+	case "$FSTYP" in
+	xfs|udf|pvfs2|9p|ceph|nfs)
+		MAX_ATTRS=1000
+		;;
+	ext2|ext3|ext4)
+		# For 4k blocksizes, most of the attributes have an attr_name of
+		# "attribute_NN" which is 12, and "value_NN" which is 8.
+		# But for larger block sizes, we start having extended
+		# attributes of the
+		# form "attribute_NNN" or "attribute_NNNN", and "value_NNN" and
+		# "value_NNNN", which causes the round(len(..), 4) to jump up by
+		# 4 bytes.  So round_up(len(attr_name, 4)) becomes 16 instead of
+		# 12, and round_up(len(value, 4)) becomes 12 instead of 8.
+		#
+		# For 64K blocksize the calculation becomes
+		# 	max_attrs = (block_size - 32) / (16 + 12 + 16)
+		# or
+		# 	max_attrs = (block_size - 32) / 44
+		#
+		# For 4K blocksize:-
+		# 	max_attrs = (block_size - 32) / (16 + 8 + 12)
+		# or
+		# 	max_attrs = (block_size - 32) / 36
+		#
+		# Note (for 4K bs) above are exact calculations for attrs of
+		# type attribute_NN with values of type value_NN.
+		# With above calculations, for 4k blocksize max_attrs becomes
+		# 112.
+		# This means we can have few attrs of type attribute_NNN with
+		# values of
+		# type value_NNN. To avoid/handle this we need to add extra 4
+		# bytes of headroom.
+		#
+		# So for 4K, the calculations becomes:-
+		# 	max_attrs = (block_size - 32) / (16 + 8 + 12 + 4)
+		# or
+		# 	max_attrs = (block_size - 32) / 40
+		#
+		# Assume max ~1 block of attrs
+		BLOCK_SIZE=`_get_block_size $TEST_DIR`
+		if [ $BLOCK_SIZE -le 4096 ]; then
+			let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 8 + 12 + 4)))
+		else
+			let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
+		fi
+		;;
+	*)
+		# Assume max ~1 block of attrs
+		BLOCK_SIZE=`_get_block_size $TEST_DIR`
+		# user.attribute_XXX="value.XXX" is about 32 bytes; leave some
+		# overhead
+		let MAX_ATTRS=$BLOCK_SIZE/40
+	esac
+
+	export MAX_ATTRS
+
+	# Set max attr value size based on fs type
+	case "$FSTYP" in
+	xfs|udf|btrfs)
+		MAX_ATTRVAL_SIZE=64
+		;;
+	pvfs2)
+		MAX_ATTRVAL_SIZE=8192
+		;;
+	9p|ceph|nfs)
+		MAX_ATTRVAL_SIZE=65536
+		;;
+	bcachefs)
+		MAX_ATTRVAL_SIZE=1024
+		;;
+	*)
+		# Assume max ~1 block of attrs
+		BLOCK_SIZE=`_get_block_size $TEST_DIR`
+		# leave a little overhead
+		let MAX_ATTRVAL_SIZE=$BLOCK_SIZE-256
+	esac
+
+	export MAX_ATTRVAL_SIZE
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/020 b/tests/generic/020
index 29ef853c..34861401 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -88,6 +88,9 @@ _attr_list $testfile
 echo "*** add lots of attributes"
 v=0
 
+max_attrval_name="long_attr"	# add 5 for "user." prefix
+_attr_get_max "$(( 5 + ${#max_attrval_name} ))"
+
 while [ $v -lt $MAX_ATTRS ]
 do
     echo -n "value_$v" | attr -s "attribute_$v" $testfile >>$seqres.full
@@ -128,11 +131,12 @@ _attr_list $testfile
 
 echo "*** really long value"
 dd if=/dev/zero bs=1 count=$MAX_ATTRVAL_SIZE 2>/dev/null \
-    | _attr -s "long_attr" $testfile >/dev/null
+    | _attr -s "$max_attrval_name" $testfile >/dev/null
 
 OCTAL_SIZE=`echo "obase=8; $MAX_ATTRVAL_SIZE" | bc`
-_attr -q -g "long_attr" $testfile | od -t x1 | sed -e "s/^0*$OCTAL_SIZE$/ATTRSIZE/"    
-_attr -r "long_attr" $testfile >/dev/null
+_attr -q -g "$max_attrval_name" $testfile | od -t x1 \
+    | sed -e "s/^0*$OCTAL_SIZE$/ATTRSIZE/"
+_attr -r "$max_attrval_name" $testfile >/dev/null
 
 echo "*** set/get/remove really long names (expect failure)"
 short="XXXXXXXXXX"
-- 
2.34.1

