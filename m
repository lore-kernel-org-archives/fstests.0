Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B6C33CB1
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B317D20748
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 08:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMIvf+am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgAQIjM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:39:12 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:33561 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgAQIjM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 03:39:12 -0500
Received: by mail-pg1-f177.google.com with SMTP id 6so11327503pgk.0
        for <fstests@vger.kernel.org>; Fri, 17 Jan 2020 00:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb1fQLXJyizanC/VXJeJrUpg29fLsVvgv6a3J2H4LxU=;
        b=hMIvf+amKlzHo0WIC6niqM4p21f+LtWhJw93eefUEizWc8JbW+LHT4Lxdo13yiVWh2
         KVO/2QWq2HHNgW5UpbsuH5jFs2ukiL3dwjzur/f6UCZc7b4jFTF3KkksH3uyT1nyimBa
         fPdEGt923+ACPhrhi76a7SE/thOaPOC8JopKtQ7sSFHdQxgYQhJKtNELJrp6oSsEjkTq
         aUhmQQcQ42hQDwA/kHTKpGAhjXPyv0wtziWA18QlVpqg06fvN1xzU6rUVXdwYUzEjZzm
         yp/5AZUAfcF9YaIzcE99vecdb3t0xd5ea9Yv4znAqk0bk86LqWmqL77LNqmeFJ54/rMT
         3qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb1fQLXJyizanC/VXJeJrUpg29fLsVvgv6a3J2H4LxU=;
        b=UpsM5brs9of9vEJeU1GE7dIobEMpq3X3IHPTXKeHDV40gKgK7xWS1S+4RoZEItkMpp
         uXMX/bNmtSkl8OyDUtBHLnHEmLvcCD2raZFWVj7QrHKby8vEf2byFyEJ6KWmaVDETILR
         5r/7ibcf30N2l6Fg54TQZ7q9WnsrrFqinhVwsN212hsTryGwCe9x9qO4weiFCybf3U8k
         go5tpxsPYHLfuEHBT2OPcpNaPFRQVO27mKxzX3DjAFo+ZjkL+IWSq1GRbkqxjsriDggl
         NJOkxE3kvkK/BpZ0yZmd2WwV+05OhCZOtY8xAsYOZhSImx0kX6H56mBn5AMs5LT/O2Jw
         Nsng==
X-Gm-Message-State: APjAAAWvlTsfWcYsu64Sat4s0R9pvWiqVHjeldx799piSS3OZVTC0C/4
        irBN7oYtrGwllNfh9wYghMBAWC3T
X-Google-Smtp-Source: APXvYqzttpT0+VevYXph2YOfzwqTfyw0YTIcU7fqvnATjHoHvK3TWwwBoDlvmNU4lr1ENiJiApVsug==
X-Received: by 2002:a62:7883:: with SMTP id t125mr1898201pfc.141.1579250351489;
        Fri, 17 Jan 2020 00:39:11 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a17sm1435996pjv.6.2020.01.17.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 00:39:11 -0800 (PST)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic: require fibmap for testcases using filefrag
Date:   Fri, 17 Jan 2020 16:38:24 +0800
Message-Id: <20200117083824.32450-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

To mute false alarm on NFS, which is reporting FIBMAP unsupported.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/516 | 1 +
 tests/generic/540 | 1 +
 tests/generic/541 | 1 +
 tests/generic/542 | 1 +
 tests/generic/543 | 1 +
 tests/generic/578 | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tests/generic/516 b/tests/generic/516
index ceaa4151..906e38ec 100755
--- a/tests/generic/516
+++ b/tests/generic/516
@@ -31,6 +31,7 @@ _cleanup()
 # real QA test starts here
 _supported_os Linux
 _require_test_dedupe
+_require_fibmap
 
 rm -f $seqres.full
 
diff --git a/tests/generic/540 b/tests/generic/540
index dc4d9485..242ab805 100755
--- a/tests/generic/540
+++ b/tests/generic/540
@@ -40,6 +40,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
+_require_fibmap
 _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
diff --git a/tests/generic/541 b/tests/generic/541
index fcb5d567..ec7ed52a 100755
--- a/tests/generic/541
+++ b/tests/generic/541
@@ -40,6 +40,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
+_require_fibmap
 _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
diff --git a/tests/generic/542 b/tests/generic/542
index 62b32cb5..62fc55ea 100755
--- a/tests/generic/542
+++ b/tests/generic/542
@@ -40,6 +40,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
+_require_fibmap
 _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
diff --git a/tests/generic/543 b/tests/generic/543
index cc7ee532..75c2f7ef 100755
--- a/tests/generic/543
+++ b/tests/generic/543
@@ -40,6 +40,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
+_require_fibmap
 _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
diff --git a/tests/generic/578 b/tests/generic/578
index 798cccf0..6e160142 100755
--- a/tests/generic/578
+++ b/tests/generic/578
@@ -29,6 +29,7 @@ _cleanup()
 # real QA test starts here
 _supported_os Linux
 _supported_fs generic
+_require_fibmap
 _require_test_program "mmap-write-concurrent"
 _require_command "$FILEFRAG_PROG" filefrag
 _require_test_reflink
-- 
2.20.1

