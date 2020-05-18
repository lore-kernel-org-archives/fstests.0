Return-Path: <SRS0=Vcut=7A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C6C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A85F20674
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL5MSW7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgERQOu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 May 2020 12:14:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbgERQOt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 May 2020 12:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589818486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=7TJefXKcAkVIG8BHiJMGC0i8JX4aYKZuA5PkXcpUx7s=;
        b=DL5MSW7iAMD6LEj837rdGDdB923YywtUu7gX2rTI6t5ecdNOHG6BPm6kPYY+e0M4VYvqVV
        s+9f1C9UOCN3LYoNoAV0PT05CKZpuJ+RlrzOSDGMHJXY3v7m1CwWzzcvYq26XRzN91Cldk
        BSu30kACh8ZjFEBprcSaeawKYXnQN7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-bwoeJ9jsMiChI0XuPPfQkw-1; Mon, 18 May 2020 12:14:45 -0400
X-MC-Unique: bwoeJ9jsMiChI0XuPPfQkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAE2EC1A0
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 16:14:44 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC6C78B54
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 16:14:44 +0000 (UTC)
Subject: [PATCH 2/5] fstests: test restricted symlinks & hardlinks sysctls
From:   Eric Sandeen <sandeen@redhat.com>
To:     fstests <fstests@vger.kernel.org>
References: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
Autocrypt: addr=sandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8640243b-8056-a81a-9c23-d19c4e0dc426@redhat.com>
Date:   Mon, 18 May 2020 11:14:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This tests the fs.protected_symlinks and fs.protected_hardlinks
sysctls which restrict links behavior in sticky world-writable
directories as documented in the kernel at
Documentation/admin-guide/sysctl/fs.rst

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: many fixes requested by Eryu
update copyright
reset sysctl only if saved
switch to _user_do
fix test description in comments

 tests/generic/900     | 115 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out |  14 +++++
 tests/generic/group   |   1 +
 3 files changed, 130 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..fd54fa4e
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,115 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 900
+#
+# Test protected_symlink and protected_hardlink sysctls
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
+	[ ! -z "$SYMLINK_PROTECTION" ] \
+		&& sysctl -qw fs.protected_symlinks=$SYMLINK_PROTECTION
+	[ ! -z "$HARDLINK_PROTECTION" ] \
+		&& sysctl -qw fs.protected_hardlinks=$HARDLINK_PROTECTION
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
+_require_sysctl_variable fs.protected_symlinks
+_require_sysctl_variable fs.protected_hardlinks
+_require_user 123456-fsgqa
+# Do this SECOND so that qa_user is fsgqa, and _do_user uses that account
+_require_user fsgqa
+
+OWNER=123456-fsgqa
+OTHER=fsgqa
+
+# Save current system state to reset when done
+SYMLINK_PROTECTION=`sysctl -n fs.protected_symlinks`
+HARDLINK_PROTECTION=`sysctl -n fs.protected_hardlinks`
+
+test_symlink()
+{
+	ln -s $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/symlink
+	chown $OTHER.$OTHER $TEST_DIR/$seq/sticky_dir
+	chown $OWNER.$OWNER $TEST_DIR/$seq/sticky_dir/symlink
+	# If we can read the target, we followed the link
+	_user_do "cat $TEST_DIR/$seq/sticky_dir/symlink" | _filter_test_dir
+	rm -f $TEST_DIR/$seq/sticky_dir/symlink
+}
+
+test_hardlink()
+{
+	chown $OWNER.$OWNER $TEST_DIR/$seq/target
+	chmod go-rw $TEST_DIR/$seq/target
+	_user_do "ln $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/hardlink" \
+		| _filter_test_dir
+	test -f $TEST_DIR/$seq/sticky_dir/hardlink \
+		&& echo "successfully created hardlink"
+	rm -f $TEST_DIR/$seq/sticky_dir/hardlink
+}
+
+setup_tree()
+{
+	# Create world-writable sticky dir
+	mkdir -p $TEST_DIR/$seq/sticky_dir
+	chmod 1777 $TEST_DIR/$seq/sticky_dir
+	# And a file elsewhere that will be linked to from that sticky dir
+	mkdir -p $TEST_DIR/$seq
+	# If we can read it, we followed the link.
+	echo "successfully followed symlink" > $TEST_DIR/$seq/target
+}
+
+setup_tree
+
+# First test fs.protected_symlinks
+# With protection on, symlink follows should fail if the
+# link owner != the sticky directory owner, and the process
+# is not the link owner.
+echo "== Test symlink follow protection when"
+echo "== process != link owner and dir owner != link owner"
+sysctl -w fs.protected_symlinks=0
+test_symlink
+sysctl -w fs.protected_symlinks=1
+test_symlink
+
+echo
+
+# Now test fs.protected_hardlinks
+# With protection on, hardlink creation should fail if the
+# process does not own the target file, and the process does not have
+# read-write access to the target
+echo "== Test hardlink create protection when"
+echo "== process != target owner and process cannot read target"
+sysctl -w fs.protected_hardlinks=0
+test_hardlink
+sysctl -w fs.protected_hardlinks=1
+test_hardlink
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..7adf97ed
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,14 @@
+QA output created by 900
+== Test symlink follow protection when
+== process != link owner and dir owner != link owner
+fs.protected_symlinks = 0
+successfully followed symlink
+fs.protected_symlinks = 1
+Permission denied
+
+== Test hardlink create protection when
+== process != target owner and process cannot read target
+fs.protected_hardlinks = 0
+successfully created hardlink
+fs.protected_hardlinks = 1
+ln: failed to create hard link 'TEST_DIR/900/sticky_dir/hardlink' => 'TEST_DIR/900/target': Operation not permitted
diff --git a/tests/generic/group b/tests/generic/group
index e82004e8..fd2360ea 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -599,3 +599,4 @@
 594 auto quick quota
 595 auto quick encrypt
 596 auto quick
+900 auto quick perms
-- 
2.17.0


