Return-Path: <SRS0=LRpr=57=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465C1C2BA19
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Apr 2020 20:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C4F20784
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Apr 2020 20:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437881AbgDOUSd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:18:33 -0400
Received: from sandeen.net ([63.231.237.45]:59584 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437923AbgDOUS3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Apr 2020 16:18:29 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id D2C23170B41;
        Wed, 15 Apr 2020 15:18:08 -0500 (CDT)
Subject: [PATCH 2/4] fstests: use _require_symlinks on all necessary tests
From:   Eric Sandeen <sandeen@sandeen.net>
To:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
References: <9798d553-0bdd-2b8b-ce3b-3c8d2c37936e@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <b76c7013-0d00-23fc-fbe3-2f56da54baaf@sandeen.net>
Date:   Wed, 15 Apr 2020 15:18:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9798d553-0bdd-2b8b-ce3b-3c8d2c37936e@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Consistently use _require_symlinks on all generic tests which
create a symlink when they run.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/062 b/tests/generic/062
index 3fef02e8..ba744885 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -59,6 +59,7 @@ _supported_os Linux
 
 _require_scratch
 _require_attrs
+_require_symlinks
 
 rm -f $tmp.backup1 $tmp.backup2 $seqres.full
 
diff --git a/tests/generic/109 b/tests/generic/109
index 8be70c23..549a95b1 100755
--- a/tests/generic/109
+++ b/tests/generic/109
@@ -29,6 +29,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_symlinks
 
 rm -f $seqres.full
 
diff --git a/tests/generic/294 b/tests/generic/294
index b74579ac..32c89b03 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_symlinks
 
 rm -f $seqres.full
 _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
diff --git a/tests/generic/306 b/tests/generic/306
index 081d1a89..046f4516 100755
--- a/tests/generic/306
+++ b/tests/generic/306
@@ -33,6 +33,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_test
+_require_symlinks
 
 DEVNULL=$SCRATCH_MNT/devnull
 DEVZERO=$SCRATCH_MNT/devzero
diff --git a/tests/generic/348 b/tests/generic/348
index 630ff160..e0139d9a 100755
--- a/tests/generic/348
+++ b/tests/generic/348
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_symlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/360 b/tests/generic/360
index a9a4f2f9..f15548e2 100755
--- a/tests/generic/360
+++ b/tests/generic/360
@@ -31,6 +31,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_symlinks
 
 linkfile=$TEST_DIR/$seq.symlink
 rm -f $linkfile
diff --git a/tests/generic/397 b/tests/generic/397
index f2e22950..c2245bd5 100755
--- a/tests/generic/397
+++ b/tests/generic/397
@@ -36,6 +36,7 @@ rm -f $seqres.full
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
+_require_symlinks
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/generic/399 b/tests/generic/399
index a9b3997a..a4013720 100755
--- a/tests/generic/399
+++ b/tests/generic/399
@@ -43,6 +43,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch_encryption
+_require_symlinks
 _require_command "$XZ_PROG" xz
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/generic/401 b/tests/generic/401
index 9d45fbcd..00e9bbe0 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -37,6 +37,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_symlinks
 _require_test_program "t_dir_type"
 
 rm -f $seqres.full
diff --git a/tests/generic/423 b/tests/generic/423
index b61d5de0..6db55fd6 100755
--- a/tests/generic/423
+++ b/tests/generic/423
@@ -38,6 +38,7 @@ _require_test
 _require_test_program "stat_test"
 _require_test_program "af_unix"
 _require_statx
+_require_symlinks
 
 function check_stat () {
 	$here/src/stat_test $* || echo stat_test failed
diff --git a/tests/generic/440 b/tests/generic/440
index 1ec1ed48..3446c147 100755
--- a/tests/generic/440
+++ b/tests/generic/440
@@ -38,6 +38,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch_encryption
+_require_symlinks
 _require_command "$KEYCTL_PROG" keyctl
 
 # Set up an encryption-capable filesystem and an encryption key.
diff --git a/tests/generic/479 b/tests/generic/479
index ad20aaee..aaf864a4 100755
--- a/tests/generic/479
+++ b/tests/generic/479
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_symlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/556 b/tests/generic/556
index b7239e34..4899b403 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -19,6 +19,7 @@ _supported_os Linux
 _supported_fs generic
 _require_scratch_nocheck
 _require_scratch_casefold
+_require_symlinks
 _require_check_dmesg
 _require_attrs
 



