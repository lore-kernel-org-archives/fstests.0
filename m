Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5CFCA0ECE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Sep 2023 22:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbjIKWqO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbjIKUHi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Sep 2023 16:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E04E185
        for <fstests@vger.kernel.org>; Mon, 11 Sep 2023 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694462806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=68rrNCxWRK2VmJRI4wA2otsKeJcntoz7oSW2095jKCk=;
        b=TdMocJFadBuohTZgdmYktFadSBqrI7mIgSseqlLbICMdzzXlExTSGOnY/Zf0h+nwrPWStW
        djDGoyQCKRY/2tCuYg11BQrohOXSIt/CBZxZGoVYOsP9eyDmAC8WLyL35+qLjykLe2uRAy
        LWPW4ppRL/dEz48+q0e/mc1nmdXw09U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-tXyJ6BVdN8C8Wv8Dbls4Uw-1; Mon, 11 Sep 2023 16:06:44 -0400
X-MC-Unique: tXyJ6BVdN8C8Wv8Dbls4Uw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31ad77537ebso3159906f8f.0
        for <fstests@vger.kernel.org>; Mon, 11 Sep 2023 13:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462803; x=1695067603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68rrNCxWRK2VmJRI4wA2otsKeJcntoz7oSW2095jKCk=;
        b=lrtJWWkmxKVQtUDCqFTOSjj4wEIC+52uSEy7ou68WSYeo4d+NFD3I5cVoCZs92HGS7
         7R64HVJh56lh6G8g9KJYty+whhbx+wMmIhtOGgS3ANCOAjSjLlXYuMyeAbIfxnPkElHb
         Zv7VwyNBjkl11LIoB7VkKqks6UtK1p48NAYBA40PLHcGnwuust5ApKkn8gS1GJWFqItp
         kPkOBufsI1ESCYZ06VdKaxlPhIOW0Ybf4HXVBqQIH47ifgwQHlQMjchy1RvPEabaJWF9
         n+MrH00gwnQXFXWPVe9oDIVjBaFSBuaNECOvhZaLXkChqCQ84KMxBKGnmTCUjEfC6VBQ
         Eh6Q==
X-Gm-Message-State: AOJu0YxVN6TSq6O/L+g9lAvWPGiXCSSCspYsWkP2qBp+Leb3xueGM3Bt
        +nXcHse9tHDu03yJxERyqEXf/Q1zz3habzyIX2vVDoDqDS8r2oQo4tsWB897IBUnCSOxWT8SY59
        uHkyjW6BJ9rlgGt8/vRbnRaOO3IVKse+aBwBd8bIWvHb4W8lhnz7RfUR5TAu0GJSHbcYHHfhCqa
        qq
X-Received: by 2002:a5d:610d:0:b0:31d:ce83:8a34 with SMTP id v13-20020a5d610d000000b0031dce838a34mr9181159wrt.39.1694462803280;
        Mon, 11 Sep 2023 13:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcHWLNpdI4Riw+2UXE5aSNzL0YtOftIJjZgN+9dxn/hTs0HzlABjPKIq6cHU4MmvegMUNohA==
X-Received: by 2002:a5d:610d:0:b0:31d:ce83:8a34 with SMTP id v13-20020a5d610d000000b0031dce838a34mr9181143wrt.39.1694462802889;
        Mon, 11 Sep 2023 13:06:42 -0700 (PDT)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a3-20020adfeec3000000b003196e992567sm10915023wrp.115.2023.09.11.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:06:42 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org, fsverity@lists.linux.dev
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] common/rc: make _get_max_file_size find file size on mount point
Date:   Mon, 11 Sep 2023 22:06:17 +0200
Message-Id: <20230911200617.777985-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently, _get_max_file_size finds max file size on $TEST_DIR.
The tests/generic/692 uses this function to detect file size and
then tries to create a file on $SCRATCH_MNT.

This works fine when test and scratch filesystems have the same
block size. However, it will fail if they differ, for example, TEST
is 4k and SCRATCH is 1k (file will be too big).

Found this by running generic/692 on ext4 with -b 1024.

Make _get_max_file_size accept mount point on which to detect max
file size.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 common/rc         | 8 +++++++-
 tests/generic/299 | 2 +-
 tests/generic/485 | 2 +-
 tests/generic/692 | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 68d2ad04..d17ec73a 100644
--- a/common/rc
+++ b/common/rc
@@ -4809,7 +4809,13 @@ _require_scratch_feature()
 # be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
 _get_max_file_size()
 {
-	local testfile=$TEST_DIR/maxfilesize.$seq
+	if [ -z $1 ] || [ ! -d $1 ]; then
+		echo "Missing mount point argument for _get_max_file_size"
+		exit 1
+	fi
+
+	local mnt=$1
+	local testfile=$mnt/maxfilesize.$seq
 	local l=0
 	local r=9223372036854775807 # LLONG_MAX
 
diff --git a/tests/generic/299 b/tests/generic/299
index d8ecff53..0cd12202 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -30,7 +30,7 @@ NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 FILE_SIZE=$((BLK_DEV_SIZE * 512))
 
-max_file_size=$(_get_max_file_size)
+max_file_size=$(_get_max_file_size $TEST_DIR)
 if [ $max_file_size -lt $FILE_SIZE ]; then
 	FILE_SIZE=$max_file_size
 fi
diff --git a/tests/generic/485 b/tests/generic/485
index 3f7749ff..8bab450b 100755
--- a/tests/generic/485
+++ b/tests/generic/485
@@ -30,7 +30,7 @@ _require_xfs_io_command "finsert"
 _require_xfs_io_command "truncate"
 
 block_size=$(_get_file_block_size $TEST_DIR)
-max_file_size=$(_get_max_file_size)
+max_file_size=$(_get_max_file_size $TEST_DIR)
 max_blocks=$((max_file_size / block_size))
 testfile=$TEST_DIR/testfile.$seq
 
diff --git a/tests/generic/692 b/tests/generic/692
index 95f6ec04..3fb8ac01 100755
--- a/tests/generic/692
+++ b/tests/generic/692
@@ -40,7 +40,7 @@ _scratch_mount
 
 fsv_file=$SCRATCH_MNT/file.fsv
 
-max_sz=$(_get_max_file_size)
+max_sz=$(_get_max_file_size $SCRATCH_MNT)
 _fsv_scratch_begin_subtest "way too big: fail on first merkle block"
 truncate -s $max_sz $fsv_file
 _fsv_enable $fsv_file |& _filter_scratch
-- 
2.40.1

