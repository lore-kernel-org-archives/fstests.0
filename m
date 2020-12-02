Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB7C64E8A
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Dec 2020 10:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA642086A
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Dec 2020 10:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgLBK3G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Dec 2020 05:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388076AbgLBK3G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Dec 2020 05:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606904859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VnQpv7xx5Dd9yERok39y0nG8oM/egbE9/sgEABTPfbo=;
        b=SKLcRrcASa3CrLn3ccUUDRPqT+XEYgJlbHpYoI3NVBe1t0AFIWJBCXZqhAtNqtHm4fcIl5
        Uh9vLU1d6OPWpAPHYlMZiQL0Iucv7uLpCmI56fJeiUI68Gp4vwXeD28TXzdacFxastTvO3
        DAFKLa/8SKNtwQWupFSL90OZ7bLSWf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Pv2luWIVOrqIuz2bK5gVeg-1; Wed, 02 Dec 2020 05:27:38 -0500
X-MC-Unique: Pv2luWIVOrqIuz2bK5gVeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD148049C1
        for <fstests@vger.kernel.org>; Wed,  2 Dec 2020 10:27:37 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A2160BFA;
        Wed,  2 Dec 2020 10:27:32 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v1] generic/275: use free block counts to check if fs is filled sufficiently.
Date:   Wed,  2 Dec 2020 18:27:31 +0800
Message-Id: <20201202102731.22350-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

For large block size, such as 64k, there're maybe leave more than 768k
space when disk is full. I met one. When I test 64k for dax. It leaves
about 800k space when disk is full. So change to jude the free block
for >4k fs.
---
 tests/generic/275 | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/generic/275 b/tests/generic/275
index 3a016037..2c5a807f 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -62,9 +62,16 @@ rm -f $SCRATCH_MNT/tmp1
 sync
 echo "Post rm space:" >> $seqres.full
 $DF_PROG $SCRATCH_MNT >>$seqres.full 2>&1
-_freespace=`$DF_PROG -k $SCRATCH_MNT | tail -n 1 | awk '{print $5}'`
-[ $_freespace -gt 1024 ] && _fail "could not sufficiently fill filesystem"
-
+bsize=$(_get_file_block_size $SCRATCH_MNT)
+bsize=$((bsize / 1024))
+_freespace=`$DF_PROG -k  $SCRATCH_MNT | tail -n 1 | awk '{print $5}'`
+# When block size is >4k, use the free counts of block to judge
+if [ "$bsize" -gt 4 ]; then
+	_freeblock=$((_freespace / bsize))
+	[ "$_freeblock" -gt 256 ] && _fail "could not sufficiently fill filesystem"
+else
+	[ "$_freespace" -gt 1024 ] && _fail "could not sufficiently fill filesystem"
+fi
 # Try to write more than available space in chunks that will allow at least one
 # full write to succeed.
 dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=128k count=8 >>$seqres.full 2>&1
-- 
2.18.1

