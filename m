Return-Path: <SRS0=lZLm=5T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF823C43331
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Apr 2020 00:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B12078C
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Apr 2020 00:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LourREHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbgDCAcs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:32:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389550AbgDCAcr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2020 20:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585873966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qhjmoT7vU8vKU9t31HmfG8/99kRySiNbmI4D5uwj/Yk=;
        b=LourREHWw4MLHbptGoryNT5u5ovdPaBKu93F7KF4FDhWhIwpoKN6yp1ElQ2Fd4WiBRu3CW
        WbnABrpqvpdnJq12CqjxcYb0030vGkILop/QGRm+FBPB/BBSLJ56tFHiGdk9tttnh9kBNb
        nVygkT1yqyeXNfGMTzKrinNpFknxMAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-2oqfU77iPvuCtZExiQFoBw-1; Thu, 02 Apr 2020 20:32:42 -0400
X-MC-Unique: 2oqfU77iPvuCtZExiQFoBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A355518A6EC0;
        Fri,  3 Apr 2020 00:32:41 +0000 (UTC)
Received: from localhost (dhcp-12-152.nay.redhat.com [10.66.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17FCC5E037;
        Fri,  3 Apr 2020 00:32:40 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH] generic/565: change to use filter _filter_testdir_and_scratch
Date:   Fri,  3 Apr 2020 08:32:31 +0800
Message-Id: <20200403003231.25098-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If $TEST_DIR is a substring of $SCRATCH_MNT (like /mnt and /mnt2),
this test always fail. Change to use _filter_testdir_and_scratch
which will filter the longer string first if the other string is a
substring of the longer one.

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---

Previously it failed with 565.out.bad:
~~~
QA output created by 565
md5sums after xdev copy:
81615449a98aaaad8dc179b3bec87f38  TEST_DIR/test-565/file
81615449a98aaaad8dc179b3bec87f38  TEST_DIR2/copy
~~~

It can pass with this patch:
~~~
[09:18:16 root@ /var/lib/xfstests]# DIFF_LENGTH=3D-0 ./check -nfs generic=
/565
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 kvm-guest 4.18.0-193.el8.x86_64 #1 SMP Fri =
Mar 27 14:35:58 UTC 2020
MKFS_OPTIONS  -- test-machine.com:/export-xfstests/dir2
MOUNT_OPTIONS -- -overs=3D4 -o context=3Dsystem_u:object_r:root_t:s0 test=
-machine.com:/export-xfstests/dir2 /mnt/nfsmp2

generic/565	 10s
Ran: generic/565
Passed all 1 tests
~~~

Thanks,
Yongcheng

 tests/generic/565 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/565 b/tests/generic/565
index 39eb20c8..41d85b91 100755
--- a/tests/generic/565
+++ b/tests/generic/565
@@ -57,7 +57,7 @@ echo $testio | grep -q "cross-device" && \
 echo -n $testio
 cmp $testdir/file $SCRATCH_MNT/copy
 echo "md5sums after xdev copy:"
-md5sum $testdir/file $SCRATCH_MNT/copy | _filter_test_dir | _filter_scra=
tch
+md5sum $testdir/file $SCRATCH_MNT/copy | _filter_testdir_and_scratch
=20
 # success, all done
 status=3D0
--=20
2.20.1

