Return-Path: <SRS0=9PQ0=6T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520CC47247
	for <linux-fstests@archiver.kernel.org>; Tue,  5 May 2020 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0D62068E
	for <linux-fstests@archiver.kernel.org>; Tue,  5 May 2020 20:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaNFmiLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEEUUP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 May 2020 16:20:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728609AbgEEUUP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 May 2020 16:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588710013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OfXrdLvD0nvCSMDp43Yh4Q5UUOoQ5wYKDx3GZIBKTs=;
        b=DaNFmiLVIyYo3lpxH5aQl3E88f0fFUb+A5knzbUhWVaSu95IVym3cjSiidetFaVI8dB/SC
        yJiMzQ0y5tQwdCBmwD64eX9Ue16wXF+0cq+tvvx/2TFmIkrhDBzVP0pufjvqNxKoCtXtGy
        DjZzwlUJi2hGuCpMM21k6rttB1j/Jfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-fI6_h4iLN4S9FlxfSYahTg-1; Tue, 05 May 2020 16:20:11 -0400
X-MC-Unique: fI6_h4iLN4S9FlxfSYahTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3A880183C
        for <fstests@vger.kernel.org>; Tue,  5 May 2020 20:20:11 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FAD5C1B2
        for <fstests@vger.kernel.org>; Tue,  5 May 2020 20:20:10 +0000 (UTC)
Subject: [PATCH 2/3] fstests: test restricted symlinks & hardlinks sysctls
From:   Eric Sandeen <sandeen@redhat.com>
To:     fstests <fstests@vger.kernel.org>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
Message-ID: <294c5739-ff30-285c-8cf7-11a6dff98294@redhat.com>
Date:   Tue, 5 May 2020 15:20:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..f0ac46ef
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,114 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
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
+	sysctl -qw fs.protected_symlinks=$SYMLINK_PROTECTION
+	sysctl -qw fs.protected_hardlinks=$HARDLINK_PROTECTION
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
+_require_sysctl fs.protected_symlinks
+_require_sysctl fs.protected_hardlinks
+_require_user fsgqa
+_require_user fsgqa2
+
+OWNER=fsgqa
+OTHER=fsgqa2
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
+	sudo -u $OTHER cat $TEST_DIR/$seq/sticky_dir/symlink 2>&1 \
+		 | _filter_test_dir
+	rm -f $TEST_DIR/$seq/sticky_dir/symlink
+}
+
+test_hardlink()
+{
+	chown $OWNER.$OWNER $TEST_DIR/$seq/target
+	chmod go-rw $TEST_DIR/$seq/target
+	sudo -u $OTHER \
+	    ln $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/hardlink 2>&1 \
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
index 00000000..c9b26dbd
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,14 @@
+QA output created by 900
+== Test symlink follow protection when
+== process != link owner and dir owner != link owner
+fs.protected_symlinks = 0
+successfully followed symlink
+fs.protected_symlinks = 1
+cat: TEST_DIR/900/sticky_dir/symlink: Permission denied
+
+== Test hardlink create protection when
+== process != target owner and process cannot read target
+fs.protected_hardlinks = 0
+successfully created hardlink
+fs.protected_hardlinks = 1
+ln: failed to create hard link 'TEST_DIR/900/sticky_dir/hardlink' => 'TEST_DIR/900/target': Operation not permitted
diff --git a/tests/generic/group b/tests/generic/group
index 718575ba..782b0cc3 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -598,3 +598,4 @@
 594 auto quick quota
 595 auto quick encrypt
 596 auto quick
+900 auto quick perms


