Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F25C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Oct 2021 02:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD19611F0
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Oct 2021 02:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhJPCRN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 15 Oct 2021 22:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232812AbhJPCRN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Oct 2021 22:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634350503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ayW4FikIYv7pKSxHa0gyFEFS/cEhZZPimmugtuvZHlg=;
        b=UyOulFuq7BWyMKAH8ZWcAHg+QaQmxzcQomZMD7lVMowbcpSzpM+B5upKoH1EolW2Ic02ly
        yQ6q4lXo0vFopeG1fJepxHFoH6BWcrYcr/Ew88+c6DU6JSebGSTchK+ZCTCaCAl2JZVcr0
        H+8ar3rD946mMP3faBZq0u3BuoL/HJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-Eq8M0ZYoOi2pduk4ex1Hqg-1; Fri, 15 Oct 2021 22:15:02 -0400
X-MC-Unique: Eq8M0ZYoOi2pduk4ex1Hqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D2D1006AA2
        for <fstests@vger.kernel.org>; Sat, 16 Oct 2021 02:15:01 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-96.pek2.redhat.com [10.72.12.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10D175C1C5
        for <fstests@vger.kernel.org>; Sat, 16 Oct 2021 02:14:59 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/648: dmerror must be unmounted
Date:   Sat, 16 Oct 2021 10:14:56 +0800
Message-Id: <20211016021456.3097323-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
loop to try to make sure it's unmounted.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/648 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/648 b/tests/generic/648
index 83dd111d..218f207b 100755
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
@@ -112,7 +112,11 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
 	# Mount again to replay log after loading working table, so we have a
 	# consistent fs after test.
 	$UMOUNT_PROG $loopmnt
-	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
+	_dmerror_unmount > /dev/null 2>&1
+	while [ $? -ne 0 ]; do
+		sleep 1
+		_dmerror_unmount > /dev/null 2>&1
+	done
 	_dmerror_load_working_table
 	if ! _dmerror_mount; then
 		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
-- 
2.31.1

