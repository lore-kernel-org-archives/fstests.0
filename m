Return-Path: <SRS0=x5Yn=5Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B35C2BA19
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59944206F5
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFhdmCmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDITKm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:10:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21806 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgDITKm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Apr 2020 15:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586459440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DyzCdNAtDKSxz0DXZ0dtgYVm1n1tsPFLyzzaswOBYN4=;
        b=TFhdmCmXLerFIFnRzON3zVbr0rZbUgwNnGPCCZkpayf4ls+v5Q+I4x1+v8D/O0OV1fKAHZ
        Vyv28RFFfRUpUTLJRljED/BF9zUoqJqslmsVES4I0ZST6UdAjvor7F6GjOjcVevUSSqPo3
        at5/7p/CyCjBIebF7IhFygqhPYB5wKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-fWoj-h4rM9mfhie1FG-1sQ-1; Thu, 09 Apr 2020 15:10:38 -0400
X-MC-Unique: fWoj-h4rM9mfhie1FG-1sQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE4C8017FD;
        Thu,  9 Apr 2020 19:10:37 +0000 (UTC)
Received: from [127.0.0.1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DBBC60BFB;
        Thu,  9 Apr 2020 19:10:37 +0000 (UTC)
Subject: [PATCH 2/2] fstests: add _require_hardlinks for all necessary tests
From:   Eric Sandeen <sandeen@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>
References: <83a816c2-fa40-c63f-7709-35863d412ded@redhat.com>
Autocrypt: addr=sandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <39716adc-c4db-65b3-b3c1-866bf3517d7f@redhat.com>
Date:   Thu, 9 Apr 2020 14:10:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <83a816c2-fa40-c63f-7709-35863d412ded@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a new _require function for hardlinks, to test hardlink support
in all tests which need it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index 476d3d07..8bb9aa1f 100644
--- a/common/rc
+++ b/common/rc
@@ -3493,6 +3493,18 @@ _require_symlinks()
 	rm -f $target $link
 }
 
+_require_hardlinks()
+{
+	local target=`mktemp -p $TEST_DIR`
+	local link=`mktemp -p $TEST_DIR -u`
+	ln `basename $target` $link
+	if [ "$?" -ne 0 ]; then
+		rm -f $target
+		_notrun "No hardlink support"
+	fi
+	rm -f $target $link
+}
+
 _require_test_fcntl_advisory_locks()
 {
 	[ "$FSTYP" != "cifs" ] && return 0
diff --git a/tests/generic/002 b/tests/generic/002
index 575ac42b..480b77bc 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -28,6 +28,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_hardlinks
 
 rm -f $seqres.full
 
diff --git a/tests/generic/039 b/tests/generic/039
index daa2e353..27cd6bf5 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/040 b/tests/generic/040
index 712ae595..b69d8127 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -44,6 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/041 b/tests/generic/041
index 8001e8ce..1674d544 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -48,6 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/056 b/tests/generic/056
index 9caf1166..28920d36 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/057 b/tests/generic/057
index ba51dbb9..91e1d98e 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/065 b/tests/generic/065
index d6a1670b..30f3c32e 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/089 b/tests/generic/089
index 3d608269..52649596 100755
--- a/tests/generic/089
+++ b/tests/generic/089
@@ -36,6 +36,7 @@ addentries()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_hardlinks
 
 rm -f $seqres.full
 [ "X$TEST_DIR" = "X" ] && exit 1
diff --git a/tests/generic/090 b/tests/generic/090
index bf38d1c8..db1aeef3 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -36,6 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/104 b/tests/generic/104
index d78689f4..4b6256db 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -31,6 +31,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/106 b/tests/generic/106
index 74d5dc30..e1c859e5 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -30,6 +30,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/107 b/tests/generic/107
index 5c6bbfca..214f3389 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -33,6 +33,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/236 b/tests/generic/236
index f207165f..2110b053 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -25,8 +25,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
 _supported_fs generic
-# only Linux supports fallocate
 _supported_os Linux
+_require_hardlinks
 _require_test
 
 rm -f $TEST_DIR/ouch*
diff --git a/tests/generic/336 b/tests/generic/336
index e007552c..6832ccde 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/343 b/tests/generic/343
index e35488dd..2034197e 100755
--- a/tests/generic/343
+++ b/tests/generic/343
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/378 b/tests/generic/378
index 393d1ce7..ea776949 100755
--- a/tests/generic/378
+++ b/tests/generic/378
@@ -39,6 +39,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_user
+_require_hardlinks
 
 # Setup testfile and its hardlink
 testfile=$TEST_DIR/testfile.$seq
diff --git a/tests/generic/480 b/tests/generic/480
index ba2c34ad..63a87519 100755
--- a/tests/generic/480
+++ b/tests/generic/480
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/498 b/tests/generic/498
index 71f5091c..7adf0b32 100755
--- a/tests/generic/498
+++ b/tests/generic/498
@@ -31,6 +31,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/502 b/tests/generic/502
index a60ac9a7..a49ee0b3 100755
--- a/tests/generic/502
+++ b/tests/generic/502
@@ -34,6 +34,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/526 b/tests/generic/526
index d0b51f87..934d263f 100755
--- a/tests/generic/526
+++ b/tests/generic/526
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/527 b/tests/generic/527
index 61dd4f0b..4b664da9 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_hardlinks
 _require_dm_target flakey
 
 rm -f $seqres.full

