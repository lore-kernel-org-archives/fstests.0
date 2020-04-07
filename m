Return-Path: <SRS0=nsk0=5X=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270F6C2BA16
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Apr 2020 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D8020748
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Apr 2020 08:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGIle convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:41:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37626 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgDGIle (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Apr 2020 04:41:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-JW5fQY7yOJK9RqZeDVlDIA-1; Tue, 07 Apr 2020 04:41:31 -0400
X-MC-Unique: JW5fQY7yOJK9RqZeDVlDIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3485A800D5C;
        Tue,  7 Apr 2020 08:41:30 +0000 (UTC)
Received: from dhcp-12-170.nay.redhat.com (dhcp-12-170.nay.redhat.com [10.66.12.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEA035DA7B;
        Tue,  7 Apr 2020 08:41:28 +0000 (UTC)
From:   "Jianhong.Yin" <yin-jianhong@163.com>
To:     fstests@vger.kernel.org
Cc:     jiyin@redhat.com, "Jianhong.Yin" <yin-jianhong@163.com>
Subject: [PATCH v2] generic/432 copy_file_range: add overwrite copy to cover known issue
Date:   Tue,  7 Apr 2020 16:41:21 +0800
Message-Id: <20200407084121.92364-1-yin-jianhong@163.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: 163.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

found that follow nfs issue has not been covered by xfstests
 https://bugzilla.redhat.com/show_bug.cgi?id=1803162
 https://bugzilla.redhat.com/show_bug.cgi?id=1803162#c6

add new test to cover it.

test log:
'''
[root@hp-dl360g9-02 xfstests]# DIFF_LENGTH=-0 ./check generic/432
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 nfsserver 4.18.0-147.el8.x86_64 ...
MKFS_OPTIONS  -- nfsserver:/home/exportdir-xfstests-mh ...
MOUNT_OPTIONS -- -overs=4.2 ...

generic/432 1s ... - output mismatch (see /var/lib/xfstests/results//generic/432.out.bad)
    --- tests/generic/432.out   2020-03-05 03:58:35.946872285 -0500
    +++ /var/lib/xfstests/results//generic/432.out.bad  2020-03-05 03:58:39.519861450 -0500
    @@ -16,6 +16,7 @@
     e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-432/file
     e5fbacd993eaa5e80ebc2b14b969887d  TEST_DIR/test-432/copy
     Copy overwrite existed copy file
    +cmp: EOF on /mnt/nfsmp-xfstests-mh/test-432/file after byte 5000, in line 1
     md5sums after copying overwrite:
     e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-432/file
    -e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-432/copy
    +98ed789264b5b11498bd3f4a70a12916  TEST_DIR/test-432/copy
Ran: generic/432
Failures: generic/432
Failed 1 of 1 tests
'''

BTW: xfs_io copy_range need this commit:
'''
 64e366d9f81785b015b85395060a492d6ae85019
 xfs_io: copy_range don't truncate dst_file, and add smart length
'''

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---

 tests/generic/432     | 7 +++++++
 tests/generic/432.out | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/tests/generic/432 b/tests/generic/432
index 6200af86..762eccae 100755
--- a/tests/generic/432
+++ b/tests/generic/432
@@ -80,6 +80,13 @@ cmp -n 4000 $testdir/file $testdir/copy 1000 3000
 echo "md5sums after copying tail:"
 md5sum $testdir/{file,copy} | _filter_test_dir
 
+echo "Copy overwrite existed copy file"
+$XFS_IO_PROG -t -f -c 'pwrite -S 0x66 0    5000' $testdir/copy >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
+cmp $testdir/file $testdir/copy
+echo "md5sums after copying overwrite:"
+md5sum $testdir/{file,copy} | _filter_test_dir
+
 #success, all done
 status=0
 exit
diff --git a/tests/generic/432.out b/tests/generic/432.out
index c49d7808..27364728 100644
--- a/tests/generic/432.out
+++ b/tests/generic/432.out
@@ -15,3 +15,7 @@ Copy tail of original file onto copy
 md5sums after copying tail:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-432/file
 e5fbacd993eaa5e80ebc2b14b969887d  TEST_DIR/test-432/copy
+Copy overwrite existed copy file
+md5sums after copying overwrite:
+e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-432/file
+e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-432/copy
-- 
2.18.1

