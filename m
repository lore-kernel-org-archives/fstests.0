Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEBC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 16:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiDMQrY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiDMQrD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 12:47:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8E03B2B7
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 09:44:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 099DF1FCFE;
        Wed, 13 Apr 2022 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649868271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7C+0Q+oglDhX03MMtuaPNFmC0yYRmwoX/+Af89y17RI=;
        b=zcpjXelDwRsfYZYDp/lNauQ2ZUoZ4F60qnxEPMS5Vg58X+i9tphUOTdWVB4LismmOH4wo9
        zzw8IUBgPOsYRP18BSrbK73SS38blSCvlwveVqvm36QFLwgQXrwxIm9J2GubfIerOqGgfs
        QBBtIAZsq3qPJsn5LEhX7CSPmD3x2PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649868271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7C+0Q+oglDhX03MMtuaPNFmC0yYRmwoX/+Af89y17RI=;
        b=I/34RO/KCuFiXchJt01hy3CwFpDeI3yqrZl1aULuHmgrU1w7dManOLmN5k6Fcos4IbHCli
        iG3CEnExvBH67gBQ==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E26BAA3BA5;
        Wed, 13 Apr 2022 16:44:30 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 2/4] generic/020: add and use _attr_get_max()
Date:   Wed, 13 Apr 2022 18:44:20 +0200
Message-Id: <20220413164422.30077-3-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220413164422.30077-1-ddiss@suse.de>
References: <20220413164422.30077-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In preparation for taking into account the attr name length when
calculating $MAX_ATTRVAL_SIZE, put the current logic in a
_attr_get_max() helper function and set local $max_attrval_size /
$max_attrs variables instead of using export.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/generic/020 | 178 +++++++++++++++++++++++++---------------------
 1 file changed, 95 insertions(+), 83 deletions(-)

diff --git a/tests/generic/020 b/tests/generic/020
index c2c285f6..cbd3f227 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -51,81 +51,89 @@ _attr_list()
     fi
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
+# set fs-specific max_attrs and max_attrval_size values. The parameter
+# @max_attrval_namelen is required for filesystems which take into account attr
+# name lengths (including namespace prefix) when determining limits.
+_attr_get_max()
+{
+	local max_attrval_namelen="$1"
+
+	# set maximum total attr space based on fs type
+	case "$FSTYP" in
+	xfs|udf|pvfs2|9p|ceph|nfs)
+		max_attrs=1000
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
+			let max_attrs=$((($BLOCK_SIZE - 32) / (16 + 8 + 12 + 4)))
+		else
+			let max_attrs=$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
+		fi
+		;;
+	*)
+		# Assume max ~1 block of attrs
+		BLOCK_SIZE=`_get_block_size $TEST_DIR`
+		# user.attribute_XXX="value.XXX" is about 32 bytes; leave some
+		# overhead
+		let max_attrs=$BLOCK_SIZE/40
+	esac
+
+	# Set max attr value size based on fs type
+	case "$FSTYP" in
+	xfs|udf|btrfs)
+		max_attrval_size=64
+		;;
+	pvfs2)
+		max_attrval_size=8192
+		;;
+	9p|ceph|nfs)
+		max_attrval_size=65536
+		;;
+	bcachefs)
+		max_attrval_size=1024
+		;;
+	*)
+		# Assume max ~1 block of attrs
+		BLOCK_SIZE=`_get_block_size $TEST_DIR`
+		# leave a little overhead
+		let max_attrval_size=$BLOCK_SIZE-256
+	esac
+}
 
 # real QA test starts here
 _supported_fs generic
@@ -161,10 +169,13 @@ echo "*** remove attribute"
 _attr -r fish $testfile
 _attr_list $testfile
 
+max_attrval_name="long_attr"	# add 5 for "user." prefix
+_attr_get_max "$(( 5 + ${#max_attrval_name} ))"
+
 echo "*** add lots of attributes"
 v=0
 
-while [ $v -lt $MAX_ATTRS ]
+while [ $v -lt $max_attrs ]
 do
     echo -n "value_$v" | attr -s "attribute_$v" $testfile >>$seqres.full
     if [ $? -ne 0 ]
@@ -185,11 +196,11 @@ _getfattr --absolute-names $testfile \
 	/^[ 	]*$/ { next }
         { l++ } 
 	END {print "   *** " (l - 1) " attribute(s)" }' \
-    | sed s/$MAX_ATTRS/MAX_ATTRS/
+    | sed s/$max_attrs/MAX_ATTRS/
 
 echo "*** remove lots of attributes"
 v=0
-while [ $v -lt $MAX_ATTRS ]
+while [ $v -lt $max_attrs ]
 do
     if ! $ATTR_PROG -r "attribute_$v" $testfile >>$seqres.full
     then
@@ -203,12 +214,13 @@ done
 _attr_list $testfile
 
 echo "*** really long value"
-dd if=/dev/zero bs=1 count=$MAX_ATTRVAL_SIZE 2>/dev/null \
-    | _attr -s "long_attr" $testfile >/dev/null
+dd if=/dev/zero bs=1 count=$max_attrval_size 2>/dev/null \
+    | _attr -s "$max_attrval_name" $testfile >/dev/null
 
-OCTAL_SIZE=`echo "obase=8; $MAX_ATTRVAL_SIZE" | bc`
-_attr -q -g "long_attr" $testfile | od -t x1 | sed -e "s/^0*$OCTAL_SIZE$/ATTRSIZE/"    
-_attr -r "long_attr" $testfile >/dev/null
+OCTAL_SIZE=`echo "obase=8; $max_attrval_size" | bc`
+_attr -q -g "$max_attrval_name" $testfile | od -t x1 \
+    | sed -e "s/^0*$OCTAL_SIZE$/ATTRSIZE/"
+_attr -r "$max_attrval_name" $testfile >/dev/null
 
 echo "*** set/get/remove really long names (expect failure)"
 short="XXXXXXXXXX"
-- 
2.34.1

