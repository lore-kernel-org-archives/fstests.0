Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EACBC07E99
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 16:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7CA61878
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhGHQiL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jul 2021 12:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhGHQiL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jul 2021 12:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625762129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uoz/Cr9LnjQoeKjfBMmhqB0a9q13lv+pjlfpbXxN04w=;
        b=ecBLSU9EA85t5WV9PVBdzJTvC9myx7D90DjZFnfl/kCLei2UcNoC/A9QCy2nj/R/svhp0e
        BAcIx/fDNVHByauaeGNZxQ5jFRSlPNzHnr5P36E4iE3FP4Nw/qi1wmq9pklmAeyvtz7vuT
        AtfoFJMRI+Y+FvILXrWSYP+03H8Lhrc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-8sn7e-tqNVaMBsVWtama2g-1; Thu, 08 Jul 2021 12:35:27 -0400
X-MC-Unique: 8sn7e-tqNVaMBsVWtama2g-1
Received: by mail-ed1-f70.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so3600953edt.13
        for <fstests@vger.kernel.org>; Thu, 08 Jul 2021 09:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uoz/Cr9LnjQoeKjfBMmhqB0a9q13lv+pjlfpbXxN04w=;
        b=YjXQ08TYfkfu+NbWo6M5LtjLH5RjohTcJh9qkAF3wubpDMZqLBo2Ug4p/7y3pdAdEN
         SNIyHAoGaM8e4A9UmcFfV+dcBe4uN6ptRJ4luNRep6XliQ+I3DyWpFBG8FmV+MYWzFbu
         R/B/rx4KyC46BVwwf+62wBJdPDT5P877RdBeeFrTyDCUEeJHPtLKnTZBjTFftf78NSWb
         KqZE8UnKo9HzXedNgk2G5LcIuSzTWq/gk9HZUf3sYtT1AZk//aI7uFGFjNb8tb+LdY6l
         uXI1rxfCMydF3u6x5zcpYqXao8+3c5JgijFYm/GhsxfJmSyR7WFPUyeR/dicPcKgXJnw
         GRrw==
X-Gm-Message-State: AOAM533g6Cvz0leKthjSe/lZvzFRpKVMAFRR/toBIBuFw9os0Z5SR7Q7
        wS5Bik9om1nbmyYTmMr7KCaiPWOSsRqwdJJLLQOPSleOoOuoZTsPM4OHl8uKyttOP3GcwmZMXyr
        QamKxpVDeXiauRx4vs2KAqDCE8GhDvgyDiAllSAUdfu0lSvnro8LuymGAhaeoFKCvVV0/
X-Received: by 2002:a05:6402:3181:: with SMTP id di1mr39566255edb.211.1625762126211;
        Thu, 08 Jul 2021 09:35:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6ZIetUScOJDTNzGIQupgoM2aGiN8l1a8iejnYO73zfR0tMGZs2kHOU8F8JHBSfugWeB0pzQ==
X-Received: by 2002:a05:6402:3181:: with SMTP id di1mr39566232edb.211.1625762126020;
        Thu, 08 Jul 2021 09:35:26 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v7sm1663491edd.4.2021.07.08.09.35.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 09:35:25 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 1/1] generic/{453,454}: Don't run for FSs restricting names
Date:   Thu,  8 Jul 2021 18:35:18 +0200
Message-Id: <20210708163518.51386-2-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210708163518.51386-1-preichl@redhat.com>
References: <20210708163518.51386-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Running generic/{453,454} tests is probably only useful for filesystems
that allow unrestricted byte streams for names.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc         | 13 +++++++++++++
 tests/generic/453 |  1 +
 tests/generic/454 |  1 +
 3 files changed, 15 insertions(+)

diff --git a/common/rc b/common/rc
index d4ad421e..d4b1f21f 100644
--- a/common/rc
+++ b/common/rc
@@ -4599,6 +4599,19 @@ _require_od_endian_flag()
 		_notrun "od does not support endian flag"
 }
 
+# Skip this test unless the filesystem treats names (directory entries,
+# fs labels, and extended attribute names) as raw byte sequences.
+_require_names_are_bytes() {
+        case "$FSTYP" in
+        ext2|ext3|ext4|f2fs|xfs|btrfs)
+		# do nothing
+	        ;;
+	*)
+                _notrun "$FSTYP does not allow unrestricted byte streams for names"
+		;;
+        esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/453 b/tests/generic/453
index 55ddcc01..a0fb802e 100755
--- a/tests/generic/453
+++ b/tests/generic/453
@@ -15,6 +15,7 @@ _begin_fstest auto quick dir
 # Import common functions.
 
 _require_scratch
+_require_names_are_bytes
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/454 b/tests/generic/454
index 3aefa9f0..133e2e9d 100755
--- a/tests/generic/454
+++ b/tests/generic/454
@@ -17,6 +17,7 @@ _begin_fstest auto quick attr
 
 _require_scratch
 _require_attrs
+_require_names_are_bytes
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.31.1

