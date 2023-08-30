Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F97C6FA8F
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Aug 2023 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbjH3Sww (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244284AbjH3Mvz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Aug 2023 08:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A2185
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2023 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693399866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RwzYSnseP7w/+Hm+XBtz3YnbPcm43eVvHsQCXXwo/bI=;
        b=RYQr2AHtLMng4je5GRzyBkEp38sNdDMlHlrobxe603OC0kjLsDj4firvJ04bokSxKkCy5F
        9WOTkigJbJcDaoeJghdobQKJfHNrmzAWNx2uhBDWnGgxExgAPK9oXCu+z/7pwKrJXR5Avk
        n1DNPB5zGVtOQyuTK0XcgNNOHWVihQc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-BIYw6aY-NYGNIh3XL7MhqQ-1; Wed, 30 Aug 2023 08:51:03 -0400
X-MC-Unique: BIYw6aY-NYGNIh3XL7MhqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 809001C06ED6
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2023 12:51:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.34.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 564CE40610F;
        Wed, 30 Aug 2023 12:51:03 +0000 (UTC)
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH] fstests: generic/353 should accomodate other pwrite behaviors
Date:   Wed, 30 Aug 2023 07:50:56 -0500
Message-ID: <20230830125056.71299-1-bodonnel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs_io pwrite issues a series of block size writes, but there is no
guarantee that the resulting extent(s) will be singular or contiguous.
This behavior is acceptable, but the test is flawed in that it expects
a single extent for a pwrite.

Modify test to use actual blocksize for pwrite and reflink. Also
modify it to accommodate pwrite and reflink that produce different
mapping results.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---
 tests/generic/353     | 27 ++++++++++++++-------------
 tests/generic/353.out | 14 --------------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/tests/generic/353 b/tests/generic/353
index 9a1471bd..03b038a6 100755
--- a/tests/generic/353
+++ b/tests/generic/353
@@ -29,31 +29,32 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-blocksize=64k
+blocksize=$(_get_file_block_size $SCRATCH_MNT)
+
 file1="$SCRATCH_MNT/file1"
 file2="$SCRATCH_MNT/file2"
+extmap1="$SCRATCH_MNT/extmap1"
+extmap2="$SCRATCH_MNT/extmap2"
 
 # write the initial file
-_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 | _filter_xfs_io
+_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 > /dev/null
 
 # reflink initial file
-_reflink_range $file1 0 $file2 0 $blocksize | _filter_xfs_io
+_reflink_range $file1 0 $file2 0 $blocksize > /dev/null
 
 # check their fiemap to make sure it's correct
-echo "before sync:"
-echo "$file1" | _filter_scratch
-$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
-echo "$file2" | _filter_scratch
-$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
+$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
+$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
+
+cmp -s $extmap1 $extmap2 || echo "mismatched extent maps before sync"
 
 # sync and recheck, to make sure the fiemap doesn't change just
 # due to sync
 sync
-echo "after sync:"
-echo "$file1" | _filter_scratch
-$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
-echo "$file2" | _filter_scratch
-$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
+$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
+$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
+
+cmp -s $extmap1 $extmap2 || echo "mismatched extent maps after sync"
 
 # success, all done
 status=0
diff --git a/tests/generic/353.out b/tests/generic/353.out
index 4f6e0b92..86cece4f 100644
--- a/tests/generic/353.out
+++ b/tests/generic/353.out
@@ -1,15 +1 @@
 QA output created by 353
-wrote 65536/65536 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 65536/65536 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-before sync:
-SCRATCH_MNT/file1
-0: [0..127]: shared|last
-SCRATCH_MNT/file2
-0: [0..127]: shared|last
-after sync:
-SCRATCH_MNT/file1
-0: [0..127]: shared|last
-SCRATCH_MNT/file2
-0: [0..127]: shared|last
-- 
2.41.0

