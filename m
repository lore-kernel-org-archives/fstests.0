Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5990C83F11
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Aug 2023 17:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjH1RYK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjH1RYC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 13:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F1411C
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693243396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nhmwtrAleKvCDQ36c0A+UfbAnkvaBtkDyqi/zs1xBQ4=;
        b=XiUDHJYCEnOck1NNWM7pbwZnmGUZ4mUfdgGSpXMx1OWRGYhoL8BR2c1sPOTM78jOwksjly
        R0vXRJKHqQnvJHt+IniN2Xhz73LQJB5frodTOcOnYZR/Yg9QlyQcJlHuWhQySOhKpR/5oR
        gX2jqvAtZCGu58H1NPO/FfulRalopEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-pIIfOASBPvaKO3DXYvaFwA-1; Mon, 28 Aug 2023 13:23:15 -0400
X-MC-Unique: pIIfOASBPvaKO3DXYvaFwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1EEB101A528
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 17:23:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.34.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA03D1121318;
        Mon, 28 Aug 2023 17:23:14 +0000 (UTC)
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH v3] fstests: generic/352 should accomodate other pwrite behaviors
Date:   Mon, 28 Aug 2023 12:23:07 -0500
Message-ID: <20230828172307.7497-1-bodonnel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs_io pwrite issues a series of block size writes, but there is no
guarantee that the resulting extent(s) will be singular or contiguous.
This behavior is acceptable, but the test is flawed in that it expects
a single extent for a pwrite.

Modify test to limit pwrite and reflink to a single block.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---
 tests/generic/352     | 10 ++++++----
 tests/generic/352.out |  6 ++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/generic/352 b/tests/generic/352
index 52ec4850..acc17dac 100755
--- a/tests/generic/352
+++ b/tests/generic/352
@@ -28,14 +28,16 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-blocksize=$((128 * 1024))
+blocksize=$(_get_file_block_size $SCRATCH_MNT)
 _require_congruent_file_oplen $SCRATCH_MNT $blocksize
 file="$SCRATCH_MNT/tmp"
 
 # Golden output is for $LOAD_FACTOR == 1 case
+# and assumes a normal blocksize of 4K
 orig_nr=8192
-orig_last_extent=$(($orig_nr * $blocksize / 512))
-orig_end=$(($orig_last_extent + $blocksize / 512 - 1))
+orig_blocksize=4096
+orig_last_extent=$(($orig_nr * $orig_blocksize / 512))
+orig_end=$(($orig_last_extent + $orig_blocksize / 512 - 1))
 
 # Real output
 nr=$(($orig_nr * $LOAD_FACTOR))
@@ -43,7 +45,7 @@ last_extent=$(($nr * $blocksize / 512))
 end=$(($last_extent + $blocksize / 512 - 1))
 
 # write the initial block for later reflink
-_pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
+_pwrite_byte 0xcdcdcdcd 0 $blocksize $file > /dev/null
 
 # use reflink to create the rest of the file, whose all extents are all
 # pointing to the first extent
diff --git a/tests/generic/352.out b/tests/generic/352.out
index 4ff66c21..454ff52f 100644
--- a/tests/generic/352.out
+++ b/tests/generic/352.out
@@ -1,5 +1,3 @@
 QA output created by 352
-wrote 131072/131072 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-0: [0..2097151]: shared
-1: [2097152..2097407]: shared|last
+0: [0..65535]: shared
+1: [65536..65543]: shared|last
-- 
2.41.0

