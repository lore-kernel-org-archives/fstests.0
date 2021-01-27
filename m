Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD5C4332D
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jan 2021 07:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9EA20656
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jan 2021 07:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhA0HZY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231644AbhA0HXY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jan 2021 02:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611732116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ovqLdByoQEJxHlSVHfIdSWvZKYf9Sp9alKNYxtYJVCk=;
        b=HMMoG7KqGrcdwQfd8ygNX9wNfMK6cIed36GHevnhuZ4eYtNSsnia4VgWT5HvWyg6hm1Jd3
        ADYq70Mjw6Szo0T2YAJlpYIEeH8TP75uyiI3CHmpBO42CxbYaKjniabClSQxA53HE4jNDw
        wod9nquLammun0WhDNKtGnFaqYLAzsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-fSdO6q-CMMuH8TgCQpfolg-1; Wed, 27 Jan 2021 02:21:54 -0500
X-MC-Unique: fSdO6q-CMMuH8TgCQpfolg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8394B802B42
        for <fstests@vger.kernel.org>; Wed, 27 Jan 2021 07:21:53 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9135E17F6D
        for <fstests@vger.kernel.org>; Wed, 27 Jan 2021 07:21:52 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/233,270: unlimit the max locked memory size for io_uring
Date:   Wed, 27 Jan 2021 15:21:43 +0800
Message-Id: <20210127072143.247849-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The ltp/fsstress always fails on io_uring_queue_init() by returnning
ENOMEM. Due to io_uring accounts memory it needs under the rlimit
memlocked option, which can be quite low on some setups, especially
on 64K pagesize machine. root isn't under this restriction, but
regular users are. So only g/233 and g/270 which use $qa_user to run
fsstress are failed.

To avoid this failure, set max locked memory to unlimited before doing
fsstress, then restore it after test done.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/233 | 8 ++++++++
 tests/generic/270 | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/tests/generic/233 b/tests/generic/233
index 7eda5774..342690c2 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -43,6 +43,13 @@ _fsstress()
 -f rename=10 -f fsync=2 -f write=15 -f dwrite=15 \
 -n $count -d $out -p 7`
 
+	# io_uring accounts memory it needs under the rlimit memlocked option,
+	# which can be quite low on some setups (especially 64K pagesize). root
+	# isn't under this restriction, but regular users are. To avoid the
+	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
+	# temporarily.
+	lmem=`ulimit -l`
+	ulimit -l unlimited
 	echo "fsstress $args" >> $seqres.full
 	if ! su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
 	then
@@ -50,6 +57,7 @@ _fsstress()
 		cat $tmp.out | tee -a $seqres.full
 		status=1
 	fi
+	ulimit -l $lmem
 }
 
 # real QA test starts here
diff --git a/tests/generic/270 b/tests/generic/270
index 3d8656d4..bd52d56e 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -37,6 +37,13 @@ _workout()
 	cp $FSSTRESS_PROG  $tmp.fsstress.bin
 	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
 
+	# io_uring accounts memory it needs under the rlimit memlocked option,
+	# which can be quite low on some setups (especially 64K pagesize). root
+	# isn't under this restriction, but regular users are. To avoid the
+	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
+	# temporarily.
+	lmem=`ulimit -l`
+	ulimit -l unlimited
 	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
 
 	echo "Run dd writers in parallel"
@@ -50,6 +57,7 @@ _workout()
 	done
 
 	$KILLALL_PROG -w $tmp.fsstress.bin
+	ulimit -l $lmem
 }
 
 # real QA test starts here
-- 
2.29.2

