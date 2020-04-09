Return-Path: <SRS0=x5Yn=5Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E76C2BA19
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 22:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064442074F
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 22:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXNUxG0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDIWuh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:50:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726896AbgDIWug (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Apr 2020 18:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586472636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=goA+3L6c/fClvq/1nWaDnxGHeuDGyrhHqz4Hc1FL+k0=;
        b=KXNUxG0YJbQlY2Yo48E0OKQGnqRAJqJ3T5dhTL6FN4EeOxA0clsQsoLczqyNpCGBKu1+2a
        Qif57NuCQ+S5oMM6+8KTp0m8tQeQXKAnyAqQyp00j1dGgzxRWN5uW90ujYPNopYh+EmAiw
        AXMLbW8OpKlGi/CqdtQKgwGg5n1ovIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-PvhIrMeBPku8ZFzUnViSCg-1; Thu, 09 Apr 2020 18:50:34 -0400
X-MC-Unique: PvhIrMeBPku8ZFzUnViSCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8E718AB2D3;
        Thu,  9 Apr 2020 22:50:33 +0000 (UTC)
Received: from [127.0.0.1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C76FB5E001;
        Thu,  9 Apr 2020 22:50:32 +0000 (UTC)
Subject: [PATCH 1.2/2] fstests: use _require_symlinks on all necessary tests
From:   Eric Sandeen <sandeen@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>
References: <83a816c2-fa40-c63f-7709-35863d412ded@redhat.com>
 <5bc398a3-a62d-e67f-1597-98dfee96f2f1@redhat.com>
Autocrypt: addr=sandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1073036a-6c68-7136-800d-b17258459847@redhat.com>
Date:   Thu, 9 Apr 2020 17:50:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5bc398a3-a62d-e67f-1597-98dfee96f2f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 


