Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C0EE4993
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Aug 2023 15:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjHWPpI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjHWPpI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 11:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E2E70
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692805467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Muvpd+48ZxNskXats5HeTEgitHl0I3abBqJmLv6AFmw=;
        b=Xn/wbMz47PrKUUTLvAsK33s2ZtqTwoQVuKUKnGaYL4rtEyThwoYnjb1Xt4uq5mp+0Dwkz/
        7atIccPbqcHfZB0gapHxd2Idekn78Tl2aO/5gowVWL9IVsPrYXkIIAqsSvOVg7/rVxctGX
        TDeLqgvza7HeTa/JDCu4hOU11LoRTt4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-eTre6dVGMAe1yPdPHrH0eA-1; Wed, 23 Aug 2023 11:44:26 -0400
X-MC-Unique: eTre6dVGMAe1yPdPHrH0eA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ED971012458
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 15:44:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAD656B2AC;
        Wed, 23 Aug 2023 15:44:25 +0000 (UTC)
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH] fstests: generic/352 should accomodate other pwrite behaviors
Date:   Wed, 23 Aug 2023 10:43:50 -0500
Message-ID: <20230823154350.18829-1-bodonnel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs_io pwrite issues a series of block size writes, but there is no guarantee
that the resulting extent(s) will be singular or contiguous. This behavior is
acceptable, but the test is flawed in that it expects a single extent for a
pwrite.

Modify test to accept any layout for the reflinked logical range.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---
 tests/generic/352     | 16 +++++++++++-----
 tests/generic/352.out |  2 --
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/generic/352 b/tests/generic/352
index 52ec4850..c4ee8a44 100755
--- a/tests/generic/352
+++ b/tests/generic/352
@@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
 # use reflink to create the rest of the file, whose all extents are all
 # pointing to the first extent
 for i in $(seq 1 $nr); do
-	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev/null
+	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp1.out
 done
 
 # then call fiemap on that file to test both the shared flag and if
 # reserved extent mapping search will cause soft lockup
-$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
-cat $tmp.out >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
+cat $tmp2.out >> $seqres.full
 
 # refact the $LOAD_FACTOR to 1 to match the golden output
 sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
 	-e "s/$last_extent/$orig_last_extent/" \
-	-e "s/$end/$orig_end/" $tmp.out
-cat $tmp.out
+	-e "s/$end/$orig_end/" $tmp2.out
+
+cat $tmp1.out > tmp.1
+cat $tmp2.out > tmp.2
+
+diff tmp.[12]
+rm tmp.1
+rm tmp.2
 
 # success, all done
 status=0
diff --git a/tests/generic/352.out b/tests/generic/352.out
index 4ff66c21..ad90ae0d 100644
--- a/tests/generic/352.out
+++ b/tests/generic/352.out
@@ -1,5 +1,3 @@
 QA output created by 352
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-0: [0..2097151]: shared
-1: [2097152..2097407]: shared|last
-- 
2.41.0

