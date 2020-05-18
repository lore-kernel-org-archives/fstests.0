Return-Path: <SRS0=Vcut=7A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240EC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2C320674
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 16:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2DE0oQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERQQy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 May 2020 12:16:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbgERQQy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 May 2020 12:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589818612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=i2JZyEB5WU/zHbClWF2rTgCJGJ8RuiVVx0Xcz2lXh7o=;
        b=i2DE0oQp0kjrv6MAK1Li8Q4mhlvfEfpRVlVoG3f73ipp+/9jFq0Nklp5ZLnnywIsEzT0kf
        IyHMw5xTIOd2i3iahiU85uLB2/3A2foYfX62/4xJrvMmrb9Cw71gGE9Gmk9bGz53qP+dFs
        G2g9fmzJCDR7KYGdMuoHNlB1NJdIxx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-NKPeyQQLPESMmgkjq1Cy3Q-1; Mon, 18 May 2020 12:16:49 -0400
X-MC-Unique: NKPeyQQLPESMmgkjq1Cy3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F079C835B75
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 16:16:48 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E3A25D9DD
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 16:16:48 +0000 (UTC)
Subject: [PATCH 4/5] fstests: add _require_mknod
From:   Eric Sandeen <sandeen@redhat.com>
To:     fstests <fstests@vger.kernel.org>
References: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
Autocrypt: addr=sandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c99e460-11bf-ade8-c2bd-afaccabf4b9f@redhat.com>
Date:   Mon, 18 May 2020 11:16:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a _require_mknod test so that filesystems with no ->mknod
operation will _notrun instead of fail, and add the helper to
all necessary tests.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 common/rc         | 7 +++++++
 tests/generic/062 | 1 +
 tests/generic/184 | 1 +
 tests/generic/306 | 1 +
 tests/generic/401 | 1 +
 tests/generic/434 | 1 +
 tests/generic/479 | 1 +
 tests/generic/564 | 3 +++
 8 files changed, 16 insertions(+)

diff --git a/common/rc b/common/rc
index 62952036..310fdc46 100644
--- a/common/rc
+++ b/common/rc
@@ -4215,6 +4215,13 @@ _require_sysctl_variable()
 	sysctl $name &>/dev/null || _notrun "$name sysctl unavailable"
 }
 
+_require_mknod()
+{
+	mknod $TEST_DIR/$seq.null c 1 3 \
+		|| _notrun "$FSTYP does not support mknod/mkfifo"
+	rm -f $TEST_DIR/$seq.null
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/062 b/tests/generic/062
index ba744885..d2a0ac9a 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -60,6 +60,7 @@ _supported_os Linux
 _require_scratch
 _require_attrs
 _require_symlinks
+_require_mknod
 
 rm -f $tmp.backup1 $tmp.backup2 $seqres.full
 
diff --git a/tests/generic/184 b/tests/generic/184
index 8aca1a0d..94f4d0e1 100755
--- a/tests/generic/184
+++ b/tests/generic/184
@@ -29,6 +29,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_mknod
 
 rm -f $TEST_DIR/null
 mknod $TEST_DIR/null c 1 3
diff --git a/tests/generic/306 b/tests/generic/306
index 046f4516..6f16a5f5 100755
--- a/tests/generic/306
+++ b/tests/generic/306
@@ -34,6 +34,7 @@ _supported_os Linux
 _require_scratch
 _require_test
 _require_symlinks
+_require_mknod
 
 DEVNULL=$SCRATCH_MNT/devnull
 DEVZERO=$SCRATCH_MNT/devzero
diff --git a/tests/generic/401 b/tests/generic/401
index 00e9bbe0..f8b1fd21 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -38,6 +38,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_symlinks
+_require_mknod
 _require_test_program "t_dir_type"
 
 rm -f $seqres.full
diff --git a/tests/generic/434 b/tests/generic/434
index edbf49d3..131c5d99 100755
--- a/tests/generic/434
+++ b/tests/generic/434
@@ -30,6 +30,7 @@ _supported_os Linux
 
 _require_xfs_io_command "copy_range"
 _require_test
+_require_mknod
 
 testdir=$TEST_DIR/test-$seq
 rm -rf $testdir
diff --git a/tests/generic/479 b/tests/generic/479
index aaf864a4..fc0b3b6c 100755
--- a/tests/generic/479
+++ b/tests/generic/479
@@ -33,6 +33,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_symlinks
+_require_mknod
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/564 b/tests/generic/564
index 4958b3b5..b9b21134 100755
--- a/tests/generic/564
+++ b/tests/generic/564
@@ -37,6 +37,9 @@ rm -f $seqres.full
 
 _require_test
 _require_loop
+# for mkfifo
+_require_mknod
+
 #
 # This test effectively requires xfs_io with these commits
 #  2a42470b xfs_io: copy_file_range length is a size_t
-- 
2.17.0


