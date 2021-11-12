Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE01C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Nov 2021 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D609760F36
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Nov 2021 20:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhKLUkp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Nov 2021 15:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhKLUko (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Nov 2021 15:40:44 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B14C061766
        for <fstests@vger.kernel.org>; Fri, 12 Nov 2021 12:37:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 193so10300577qkh.10
        for <fstests@vger.kernel.org>; Fri, 12 Nov 2021 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0mC8E0nVs+4PIAevDGFm/VHiYARiuJ41dU7KZkBaPw=;
        b=KVaP/N/QrT5ENGGVLBNM2idWsODJquG7UmEHCTVFShbpBz54Ldg07DTTat6e5zUWcM
         McvJ2oJR3xpVAYKbmFmW/rFezJv3T46fTJrrew9VGahkCnglzPo3WUnlyhQJQtTpDnRz
         5fXK+Qr1xFqHefIvmnK5UJIi4+IXqF2ks5TQMBUkhIcpUUC7FDOcwzg9Ij3eQzjZjve0
         vPXf0EmVH3xT4fg7WK14VDWY0s1sBr7hdRfTmCnWUwUM5MKwNH73yP6hJ08lLz8Swzod
         kTlaRb5fATYuDcXDDbCIGjuzYu6//Rz8nnIzxPE8d5i8WlOLYRuF9TVm5fqmUdTKn9Um
         TBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0mC8E0nVs+4PIAevDGFm/VHiYARiuJ41dU7KZkBaPw=;
        b=TArSo2dLFQS0n8Mw44hR3c5B8FH4lsOTLDDbhubMFknwmVkhHHAKcFVv2m9oyBngDH
         ASQWZUnIfLnuCxGDRFXbJHOoRQ6+NxvMFOQyyov0y51231FrisoBJnxiAgTKXqc8jThl
         janNexmey8J78UZxoQlgQsSWJOdSqHXJpHBzRQTbc9EsLM1+PqywRiS6niIZByvKxBpr
         Lw9G1mdmqrMUAkUi+BqxFgsaLAHD5hFuWJ+P6JHuqzwYbPz637jrAvRUA8fCVkskTuTn
         XNEZL50LB5t4Ees+E/KRDkmPmptD1JmDfos7ylKpT0cA7Wtju/1WCxHpVnpDVLt1vb+F
         V+8g==
X-Gm-Message-State: AOAM531N+hOR2EJf6oeTFJdTXUGk7y8juTl81iatOrIsBq6JmF0w0Ztt
        TGH5Ocs/27byMTyu+GFNx+ARHg==
X-Google-Smtp-Source: ABdhPJx9lCGOWzFxvKztUOT7d5TKeXIzh2x0XayjyDs8xS5sLZpMKiU47GUZzUNqZsYWrY87XSHL4w==
X-Received: by 2002:a05:620a:400f:: with SMTP id h15mr14700401qko.226.1636749472507;
        Fri, 12 Nov 2021 12:37:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s8sm3452735qkp.17.2021.11.12.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 12:37:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: print symbolic names for fiemap flags
Date:   Fri, 12 Nov 2021 15:37:48 -0500
Message-Id: <36864f7a8701651bd7c1734aa57cb520fbf34a49.1636749456.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

My nightly btrfs tests are failing on my configs with -o compress because the
extents have FIEMAP_EXTENT_ENCODED set, which throws the golden output off.

Fix this by changing the filter helper to spit out symbolic names for SHARED and
LAST (these tests only care about SHARED).  Then change the golden output to
match the new output of the filter.  With this patch my -o compress configs now
pass these tests.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/punch          | 16 +++++++++++++++-
 tests/generic/352.out |  4 ++--
 tests/generic/353.out |  8 ++++----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/common/punch b/common/punch
index b6c337e7..b6b8a0b9 100644
--- a/common/punch
+++ b/common/punch
@@ -119,7 +119,21 @@ _filter_fiemap_flags()
 			next;
 		}
 		$5 ~ /0x[[:xdigit:]]+/ {
-			print $1, $2, $5;
+			flags = strtonum($5);
+			flag_str = "none";
+			set = 0;
+
+			if (and(flags, 0x2000)) {
+				flag_str = "shared";
+				set = 1;
+			}
+			if (and(flags, 0x1)) {
+				if (set) {
+					flag_str = flag_str"|";
+				}
+				flag_str = flag_str"last";
+			}
+			print $1, $2, flag_str
 		}' |
 	_coalesce_extents
 }
diff --git a/tests/generic/352.out b/tests/generic/352.out
index a87c5073..4ff66c21 100644
--- a/tests/generic/352.out
+++ b/tests/generic/352.out
@@ -1,5 +1,5 @@
 QA output created by 352
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-0: [0..2097151]: 0x2000
-1: [2097152..2097407]: 0x2001
+0: [0..2097151]: shared
+1: [2097152..2097407]: shared|last
diff --git a/tests/generic/353.out b/tests/generic/353.out
index b7184a61..4f6e0b92 100644
--- a/tests/generic/353.out
+++ b/tests/generic/353.out
@@ -5,11 +5,11 @@ linked 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 before sync:
 SCRATCH_MNT/file1
-0: [0..127]: 0x2001
+0: [0..127]: shared|last
 SCRATCH_MNT/file2
-0: [0..127]: 0x2001
+0: [0..127]: shared|last
 after sync:
 SCRATCH_MNT/file1
-0: [0..127]: 0x2001
+0: [0..127]: shared|last
 SCRATCH_MNT/file2
-0: [0..127]: 0x2001
+0: [0..127]: shared|last
-- 
2.26.3

