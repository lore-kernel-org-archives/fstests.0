Return-Path: <SRS0=RfwH=3C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB58C32771
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jan 2020 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE2206D6
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jan 2020 03:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyMSMS5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbgAMDYj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:24:39 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44748 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733109AbgAMDYj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jan 2020 22:24:39 -0500
Received: by mail-pf1-f180.google.com with SMTP id 195so4156261pfw.11
        for <fstests@vger.kernel.org>; Sun, 12 Jan 2020 19:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1clkR/hQj4YtE39u7jadVEUDAhZ5NwiMayu0BXE9ZI=;
        b=OyMSMS5vbciY6hNG9o43MIZe/sJ8tgymKt/oYKONnQQcKroBH3scytgxjo34KtaJQC
         z3kU41zHV2zJ94cLzJenQ+q5T86kGL8+bHwaA3owH0ZXZbe9SUChrH4Gq2ZKrTvZ5Ngg
         vwqeY19BKtr64F2BMOvEr4eygGx9txmEkNboeWtmlUwBKiFvRng0L4rJlX0zmhmUaW4G
         EjqjlAXsJ25HntOyjaOjZnFbTOIIeksCWSVd/tERov4KpjRNCXL9XXjWJVfy+9HPyqRu
         HL8eG2HK+hTx+71o819+xIIgz1GzM/VOSsF3Zk5SSAo9QvORlFg/rBWzPieZPdQaypSy
         ff+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1clkR/hQj4YtE39u7jadVEUDAhZ5NwiMayu0BXE9ZI=;
        b=VtUtA7EXrkYXye8NpHhSc/Q+JHbm5kWW6kFifbCTSXPKw97LdVVcI8KCVvsJLmN0kV
         B5Y04zEyw0kONd3L6zSD7DRPOJuENe75QpWRph8W5PkArVwfuMwvQ+ALb+RWZWdvCJqD
         0HgVNAuyPqMX+3wWWg0S9Y/BJdDs+ejH8/3obzUKy9BBZObBqtoukJCISTIGLYA+ZxdU
         DxZmz8AhnMXQfC+qtdcM11/JzN++KqZ8rdW9Mqcs3G+QSXqZSGm1wiyusCK2vWXx64Tu
         8YHNvOcmVOYptMgSgedCRUgB3pNs+Ozd2Pjf2cN+i/4vA1wvdvk0wkM8NQcsEN+KraZ2
         bZSw==
X-Gm-Message-State: APjAAAWsrbrEUEJGAE0e3MxFlS4NrTLlSwehD2iB7/FcSDXJi4BkEi/j
        6dwUg19Iuv+jsvYnwuLrojwqA48Y
X-Google-Smtp-Source: APXvYqy2Grqgd/0apYOWlgtHr59yX3Um4scq95zo4c2zmbgdtDCH7gEyxCbnek1d3XJ/5eJbNCzslQ==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr17822788pfi.25.1578885878772;
        Sun, 12 Jan 2020 19:24:38 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v10sm11181943pgk.24.2020.01.12.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 19:24:38 -0800 (PST)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/175, generic/176: cleanup testdir before exit
Date:   Mon, 13 Jan 2020 11:24:09 +0800
Message-Id: <20200113032409.11501-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Usually the _mkfs helper will cleanup these directories at the
beginning of testcase. However, when testing on NFS, the cleanup
could be very slow and it is confusing that: We have already
started to run generic/176 but we get stuck in _mkfs, cleaning
up files left by the previous testcase generic/175.

To be clear, cleanup testdir before exit.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/175 | 1 +
 tests/generic/176 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/generic/175 b/tests/generic/175
index 79e5b3d6..bd966a28 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -61,6 +61,7 @@ bytes=$((blks * blksz))
 echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
 _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
 
+rm -rf $testdir
 # success, all done
 status=0
 exit
diff --git a/tests/generic/176 b/tests/generic/176
index a084578a..bc83762e 100755
--- a/tests/generic/176
+++ b/tests/generic/176
@@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
 echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
 _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
 
+rm -rf $testdir
 # success, all done
 status=0
 exit
-- 
2.20.1

