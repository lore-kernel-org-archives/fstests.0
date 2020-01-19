Return-Path: <SRS0=QNn/=3I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C4C32771
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jan 2020 00:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A62467C
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jan 2020 00:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBz4hJ5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgASA5w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:57:52 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40730 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgASA5v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Jan 2020 19:57:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so5231954pjb.5
        for <fstests@vger.kernel.org>; Sat, 18 Jan 2020 16:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRrtoog1ADAqp2GfWyJX93XVWiqejv3wx8aTBhiyLqs=;
        b=NBz4hJ5j6XQqx4GGR9TvVZqZ5ZJ0m2NXW6KV3szimgoddevc8kWj2209Ydj20LONFq
         a5+YFpSGnCtMdHfKMlyqRNf4TxmWKJHYki6/TvfedO0kAZMaBTgudmpLQMxXwvMP9XVN
         pdX1dTufcNruTNMJlKKYrkua753qR8bUxWi3mlQtyVnMTFQs9VWCHlbe/YZtPpiNN0kf
         Kjku13CJ++/PyN/0e+pS2spPzYBhFTTj/dzLESdYOJS7pNESVGDmyG3sAP2qU8DkWpXa
         pN2AaIRNAoXh7YittYKn4sM2jiMeYYysinR0I8f+Fxhvt3rJuZcpgqtKOf8RMieiza6U
         Oi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRrtoog1ADAqp2GfWyJX93XVWiqejv3wx8aTBhiyLqs=;
        b=KjTtTYKyH81KrtI16DRleop3CTUv0NHD14yb5Y71Z/m5GSKoClQagUgKDsVdIY4w/r
         eNaczNXv3SjlOdB5Acnl+17N9dmYQKPFnRcmBzAIdbPcJilKbnbGF/ytelydoa5eGujg
         a4o3SRNTnYmgPr80ldZ+BECCzJV30OQN+ULOHm2QOXfWyyp/X3O0yu6l83cp+Kz/wl5Y
         SXiA20rGK4FrzKURRUx8gi35MehaZiHMVSk6Yko7JoecWT/MWieIAfGkiL143KITVDLb
         7nhNarUqEHNWcT7LDv336JXe/LN2WScLOAsIEI6Vzq/JLJr0WOAA6gtR/O6nT5GUbNoj
         4VAw==
X-Gm-Message-State: APjAAAUHP1Sn1Rexwn0jmcS1PcA+r0VnZENUf1sbfcV4x/QpLPYtZkux
        i7GufOEUrQoz6l46+vi0iNBf7Jc5
X-Google-Smtp-Source: APXvYqx8gUPoc218vkZRN3qRtVgAFwALK3LepbMyQKedoC4fgDfKcCGdlJPXNNlFldh+IIcpHQzXYw==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr7419206plp.300.1579395470937;
        Sat, 18 Jan 2020 16:57:50 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id n188sm32889129pga.84.2020.01.18.16.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 16:57:50 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     amir73il@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        guaneryu@gmail.com, sashal@kernel.org, y2038@lists.linaro.org
Subject: [PATCH v3 1/1] generic/402: Make timestamp range check conditional
Date:   Sat, 18 Jan 2020 16:57:44 -0800
Message-Id: <20200119005744.12852-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABeXuvoDnwS5Km657iDwgWVL=L3muqqJp51owc0kkNcTFRrEYw@mail.gmail.com>
References: <CABeXuvoDnwS5Km657iDwgWVL=L3muqqJp51owc0kkNcTFRrEYw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Addition of fs-specific timestamp range checking was added
in 188d20bcd1eb ("vfs: Add file timestamp range support").

Add a check for whether the kernel supports the limits check
before running the associated test.

Based on an off-list discussion, we use a simpler interim approach
until fsinfo syscall would provide fs timestamp limits info.
This isn't perfect, but works for filesystems expiring in 2038.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 common/rc         |  7 +++++++
 tests/generic/402 | 13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index eeac1355..fc82c17a 100644
--- a/common/rc
+++ b/common/rc
@@ -1990,6 +1990,13 @@ _require_timestamp_range()
 	if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
 		_notrun "filesystem $FSTYP timestamp bounds are unknown"
 	fi
+
+	# expect console warning from rw scratch mount if fs limit is near
+	if [ $tsmax -le $((1<<31)) ] && \
+		! _check_dmesg_for "filesystem being mounted at .* supports timestamps until"
+	then
+		_notrun "Kernel does not support timestamp limits"
+	fi
 }
 
 _filesystem_timestamp_range()
diff --git a/tests/generic/402 b/tests/generic/402
index 0392c258..2a34d127 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -16,7 +16,13 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
 
 # Get standard environment, filters and checks.
 . ./common/rc
@@ -30,6 +36,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_check_dmesg
 _require_xfs_io_command utimes
 
 # Compare file timestamps obtained from stat
@@ -80,6 +87,8 @@ run_test()
 }
 
 _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount || _fail "scratch mount failed"
+
 _require_timestamp_range $SCRATCH_DEV
 
 read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
@@ -96,8 +105,6 @@ declare -a TIMESTAMPS=(
 	$((tsmax+1))
 )
 
-_scratch_mount || _fail "scratch mount failed"
-
 status=0
 
 # Begin test case 1
-- 
2.17.1

