Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5589C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 12:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B916460ED4
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 12:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJXMHl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 08:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229867AbhJXMHl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Oct 2021 08:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635077120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rqgd9X7XZxjbZs5pzhROD1vKcEkyjr8A2fIESeGfuTk=;
        b=EGXdfjDt+r+vAXvpd/Y3GDVqqISHmfE/gWeOju/X9E7NfXf59JjjqdBcX1MYs0dPMu3kPP
        3DWVM7f4xiAVjsdrTpKVF9K3fSD6YiuVI8nlnmUc+NvFItROSvdnnIbZ9p2cbpHEQ73mSj
        LTKF3I9WIa8rdT23Up3dFYQkzT1sEEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-ZY3wEP_tOE6dBp4fWhfbsQ-1; Sun, 24 Oct 2021 08:05:18 -0400
X-MC-Unique: ZY3wEP_tOE6dBp4fWhfbsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 023985074B
        for <fstests@vger.kernel.org>; Sun, 24 Oct 2021 12:05:18 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1414460862
        for <fstests@vger.kernel.org>; Sun, 24 Oct 2021 12:05:15 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] generic/648: dmerror must be unmounted
Date:   Sun, 24 Oct 2021 20:05:12 +0800
Message-Id: <20211024120512.2383377-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Sometimes g/648 fail to unmount dmerror with this error:

   umount: /mnt/xfstests/scratch: target is busy.

Even worse, it will cause all later test cases fail as:

  mount: bad usage
  Try 'mount --help' for more information.
  check: failed to mount $SCRATCH_DEV using specified options
  Interrupted!

So we shouldn't _fail directly if dmerror_unmount fails, use a while
loop to try to unmount it enough times.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

As Darrick's review point, V2 brings the "iteration XXX scratch
unmount failed" _fail back.

Thanks,
Zorro

 tests/generic/648 | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/generic/648 b/tests/generic/648
index 83dd111d..e5c743c5 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -104,7 +104,7 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
 		wait > /dev/null 2>&1
 		ps -e | grep fsstress > /dev/null 2>&1
 	done
-	for ((i = 0; i < 10; i++)); do
+	for ((j = 0; j < 10; j++)); do
 		test -e "$snap_aliveflag" || break
 		sleep 1
 	done
@@ -112,7 +112,21 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
 	# Mount again to replay log after loading working table, so we have a
 	# consistent fs after test.
 	$UMOUNT_PROG $loopmnt
-	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
+	is_unmounted=1
+	# We must unmount dmerror at here, or whole later testing will crash.
+	# So try to umount enough times, before we have no choice.
+	for ((j = 0; j < 100; j++)); do
+		sleep 1
+		_dmerror_unmount > $tmp.unmount.err 2>&1
+		if [ $? -eq 0 ];then
+			is_unmounted=0
+			break
+		fi
+	done
+	if [ $is_unmounted -ne 0 ];then
+		cat $tmp.unmount.err
+		_fail "iteration $i scratch unmount failed"
+	fi
 	_dmerror_load_working_table
 	if ! _dmerror_mount; then
 		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
-- 
2.31.1

