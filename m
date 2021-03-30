Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1078C433DB
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 01:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EA261988
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 01:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC3A7w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhC3A7t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Mar 2021 20:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617065989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EBcR6+008JNnywPi/rrAyCGk8grOjfEcRskJ5z5lP1U=;
        b=HAHpfkVmZ3Rbi9pp0Co4zXssZlMuJOPyNv1gXVDPhnG0su8IC60WblRAMySJh3K5xsrjsF
        pnK/SFggG6Gywi0ZpIVJnw2nQ+aFDLFhcaRLUaIehTHyzzWymDYUZtMfMW7N/BiAb127EF
        76Qc31GrZWT7Nr6eQBUo5dyX7WlA3+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-yFFhhVgNMQuvhS8GE200Xg-1; Mon, 29 Mar 2021 20:59:47 -0400
X-MC-Unique: yFFhhVgNMQuvhS8GE200Xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 589F98B5DC2
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 00:59:46 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64DE95D9CC
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 00:59:45 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] generic/233,270: unlimit the max locked memory size for io_uring
Date:   Tue, 30 Mar 2021 08:59:42 +0800
Message-Id: <20210330005942.536259-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Hi,

V2 removed `ulimit -l $lmem`, due to each case runs in child process, won't
affect other testing.

Thanks,
Zorro

 tests/generic/233 | 6 ++++++
 tests/generic/270 | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/generic/233 b/tests/generic/233
index 7eda5774..cc794c79 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -43,6 +43,12 @@ _fsstress()
 -f rename=10 -f fsync=2 -f write=15 -f dwrite=15 \
 -n $count -d $out -p 7`
 
+	# io_uring accounts memory it needs under the rlimit memlocked option,
+	# which can be quite low on some setups (especially 64K pagesize). root
+	# isn't under this restriction, but regular users are. To avoid the
+	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
+	# temporarily.
+	ulimit -l unlimited
 	echo "fsstress $args" >> $seqres.full
 	if ! su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
 	then
diff --git a/tests/generic/270 b/tests/generic/270
index 3d8656d4..e93940ef 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -37,6 +37,12 @@ _workout()
 	cp $FSSTRESS_PROG  $tmp.fsstress.bin
 	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
 
+	# io_uring accounts memory it needs under the rlimit memlocked option,
+	# which can be quite low on some setups (especially 64K pagesize). root
+	# isn't under this restriction, but regular users are. To avoid the
+	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
+	# temporarily.
+	ulimit -l unlimited
 	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
 
 	echo "Run dd writers in parallel"
-- 
2.30.2

