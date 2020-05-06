Return-Path: <SRS0=0Rk7=6U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59182C28CBC
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 19:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A4208CA
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 19:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdUiojJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgEFT3w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 May 2020 15:29:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728433AbgEFT3v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 May 2020 15:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588793389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=e/OGCWRK9UV8vA/guwGB3M4Hq6nxBBzzD/B+xhZQm60=;
        b=HdUiojJyquuCANuzmEz+ra7/xshiVZjHKKS0+T4frIytH86MlesKzJ3omP0kkiddF+Wdaa
        tCnEWhGqe2kNCaSSlOgiYUOSB+UXYosYNJKDgKLO5QoAXVP3Uy/pqn5QIc4kFl7MV87jTu
        +RJjeZCTTBgR5U1zCzp1IIlc57KDMT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-vu4vHjVHPHeeqpTwPM4ilw-1; Wed, 06 May 2020 15:29:47 -0400
X-MC-Unique: vu4vHjVHPHeeqpTwPM4ilw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC9BB83DD19
        for <fstests@vger.kernel.org>; Wed,  6 May 2020 19:29:46 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 865B0690E2;
        Wed,  6 May 2020 19:29:43 +0000 (UTC)
Subject: [PATCH 3/3 V2] fstests: test restricted file access sysctls
From:   Eric Sandeen <sandeen@redhat.com>
To:     fstests <fstests@vger.kernel.org>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
 <8e007b9f-9fdb-c9dd-c2b0-dd273d24a517@redhat.com>
Autocrypt: addr=sandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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
Cc:     Bill O'Donnell <billodo@redhat.com>
Message-ID: <646dee70-4758-99cc-6164-36c640126616@redhat.com>
Date:   Wed, 6 May 2020 14:29:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8e007b9f-9fdb-c9dd-c2b0-dd273d24a517@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This tests the fs.protected_regular and fs.protected_fifos
sysctls which restrict access behavior in sticky world-writable
directories as documented in the kernel at 
Documentation/admin-guide/sysctl/fs.rst

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: Don't count on nonzero exit from xfs_io since that is almost
always broken and was only recently fixed and may end up broken
again... collect & check any emitted error messages instead.

diff --git a/tests/generic/901 b/tests/generic/901
new file mode 100755
index 00000000..9bb658e0
--- /dev/null
+++ b/tests/generic/901
@@ -0,0 +1,133 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 900
+#
+# Test protected_symlink and protected_hardlink ioctls
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -rf $TEST_DIR/$seq
+	sysctl -qw fs.protected_regular=$REGULAR_PROTECTION
+	sysctl -qw fs.protected_fifos=$FIFO_PROTECTION
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_sysctl fs.protected_regular
+_require_sysctl fs.protected_fifos
+_require_user fsgqa
+_require_user fsgqa2
+
+USER1=fsgqa
+USER2=fsgqa2
+
+# Save current system state to reset when done
+REGULAR_PROTECTION=`sysctl -n fs.protected_regular`
+FIFO_PROTECTION=`sysctl -n fs.protected_fifos`
+
+test_access()
+{
+	FILENAME=$1
+
+	# sticky dir is world & group writable:
+	echo "= group & world writable dir"
+	chmod og+w $TEST_DIR/$seq/sticky_dir
+	# "open -f" opens O_CREAT
+	result=`sudo -u $USER2 $XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/$FILENAME" 2>&1`
+	if [ -z "$result" ]; then
+		echo "successfully opened $FILENAME"
+	else
+		echo $result | _filter_test_dir
+	fi
+	# sticky dir is only group writable:
+	echo "= only group writable dir"
+	chmod o-w $TEST_DIR/$seq/sticky_dir
+	result=`sudo -u $USER2 $XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/$FILENAME" 2>&1`
+	if [ -z "$result" ]; then
+		echo "successfully opened $FILENAME"
+	else
+		echo $result | _filter_test_dir
+	fi
+}
+
+setup_tree()
+{
+	# Create sticky dir owned by $USER2
+	mkdir -p $TEST_DIR/$seq
+	mkdir -p $TEST_DIR/$seq/sticky_dir
+	chmod 1777 $TEST_DIR/$seq/sticky_dir
+	chown $USER2.$USER2 $TEST_DIR/$seq/sticky_dir
+
+	# Create file & fifo in that dir owned by $USER1, and open
+	# normal read/write privs for world & group
+	$XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/file"
+	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/file
+	chmod o+rw $TEST_DIR/$seq/sticky_dir/file
+
+	mkfifo $TEST_DIR/$seq/sticky_dir/fifo
+	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/fifo
+	chmod o+rw $TEST_DIR/$seq/sticky_dir/fifo
+}
+
+setup_tree
+
+# First test fs.protected_regular
+# With protection set to 1, O_CREAT opens in a world-writable sticky
+# directory should fail if the file exists, is owned by another, and
+# file owner != dir owner
+#
+# With protection set to 2, the same goes for group-writable
+# sticky directories
+
+echo "== Test file open when owned by another and file owner != dir owner"
+sysctl -w fs.protected_regular=0
+test_access file
+sysctl -w fs.protected_regular=1
+test_access file
+sysctl -w fs.protected_regular=2
+test_access file
+
+echo
+
+# Now test fs.protected_fifos
+# With protection set to 1, O_CREAT opens in a world-writable sticky
+# directory should fail if the fifo exists, is owned by another, and
+# file owner != dir owner
+#
+# With protection set to 2, the same goes for group-writable
+# sticky directories
+echo "== Test fifo open when owned by another and fifo owner != dir owner"
+sysctl -w fs.protected_fifos=0
+test_access fifo
+sysctl -w fs.protected_fifos=1
+test_access fifo
+sysctl -w fs.protected_fifos=2
+test_access fifo
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/901.out b/tests/generic/901.out
new file mode 100644
index 00000000..af774ca5
--- /dev/null
+++ b/tests/generic/901.out
@@ -0,0 +1,34 @@
+QA output created by 901
+== Test file open when owned by another and file owner != dir owner
+fs.protected_regular = 0
+= group & world writable dir
+successfully opened file
+= only group writable dir
+successfully opened file
+fs.protected_regular = 1
+= group & world writable dir
+TEST_DIR/901/sticky_dir/file: Permission denied
+= only group writable dir
+successfully opened file
+fs.protected_regular = 2
+= group & world writable dir
+TEST_DIR/901/sticky_dir/file: Permission denied
+= only group writable dir
+TEST_DIR/901/sticky_dir/file: Permission denied
+
+== Test fifo open when owned by another and fifo owner != dir owner
+fs.protected_fifos = 0
+= group & world writable dir
+successfully opened fifo
+= only group writable dir
+successfully opened fifo
+fs.protected_fifos = 1
+= group & world writable dir
+TEST_DIR/901/sticky_dir/fifo: Permission denied
+= only group writable dir
+successfully opened fifo
+fs.protected_fifos = 2
+= group & world writable dir
+TEST_DIR/901/sticky_dir/fifo: Permission denied
+= only group writable dir
+TEST_DIR/901/sticky_dir/fifo: Permission denied
diff --git a/tests/generic/group b/tests/generic/group
index 782b0cc3..d1e529d5 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -599,3 +599,4 @@
 595 auto quick encrypt
 596 auto quick
 900 auto quick perms
+901 auto quick perms

