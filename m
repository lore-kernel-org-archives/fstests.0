Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D717C001B0
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Aug 2023 08:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjHOI3K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Aug 2023 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHOI2n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2023 04:28:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F390127
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 01:28:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso8282660e87.0
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692088119; x=1692692919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjjZ7acpFCbSorTKGRbLQpEVADt5GGavruXC9uYjeWA=;
        b=mVa9MnzMtj1dkxfGkUtesz9v9KCrxJFDpiSqnxyBlVSGHLF+/UhE0+SRvYt8I2NPkO
         Jr+segR0U0Tl5K2HNLenWTdeqrpM1t1iIt70Dou38DMYXiqhwGeUnov4lMUI6EdCXOd+
         72TfFAIKxmQvg1VC8DxrTtNLkKO6N7Rwk3An/3Q7dznHTM6SCY4ZL4HgUXwg5DwHSjIb
         wU4tPC4/NadORtxeflkUvlefmm1mZiy60ul5+Kc/p4xpQyzVyOB8ISEDrfLLL/KqFdkl
         jeDUVlmRofyPpv2CTWz1WdUlShYkMv1hv7q4AMDYQzd58xyFEZGWdHB3nzRFTHimTymF
         OhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692088119; x=1692692919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjjZ7acpFCbSorTKGRbLQpEVADt5GGavruXC9uYjeWA=;
        b=I1tNvfsgDP4TT05vZiaTP1gN5fTq4F40hWbyPyK6JD2EweKSAwKZeA8BR/hlt3nodu
         bYj5yDoJ/iG0n8+SthyOmo8xu4aP+R9Haee5RUsNRIpbHKWZ0ftMxAShHA6+p+u78jg6
         NUR+4Vpn9oA5GG0wAISs1SN3ouQGOOce8COwU6oGFvbAoKICU1120JQ8kV8rbztP/MBx
         DMravAUK20GxpP1+gEHLV27XwPnHWUiRR2aq/sKC79BkBoNa+AS1ii36xUWcJXHuOovZ
         vzxtfw2Uo+Xwj9uWi57+Mol7BUkE29Iif2HLP5LYySoHzUrv3EFTHQEtf86P+7phFbQo
         qEvQ==
X-Gm-Message-State: AOJu0Yyxk1uqpdu6ICWnadr+4+96zK8PsnKV9lYuwWEpORNWIyCSRSIl
        fyW4jkloZG7XRlceEGmupJHIOeDSLHQ=
X-Google-Smtp-Source: AGHT+IH6jRpy4MDBxD3iAVWCHqrNUmV/CjhwH+PWkrPYAn/0Oy6QhVfmD0x5xi8aXbtiDxPED6TQdQ==
X-Received: by 2002:a05:6512:34c8:b0:4f9:6528:fb15 with SMTP id w8-20020a05651234c800b004f96528fb15mr6582397lfr.12.1692088119190;
        Tue, 15 Aug 2023 01:28:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090682cd00b00992f81122e1sm6738124ejy.21.2023.08.15.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 01:28:38 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        fstests@vger.kernel.org
Subject: [PATCH v2] generic/{175,297,298}: fix use of uninitialized var
Date:   Tue, 15 Aug 2023 11:28:35 +0300
Message-Id: <20230815082835.790906-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The truncate command in those tests use an uninitialized variable i.
in kdevops, i must contain some leftover, so we get errors like:
/data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
           syntax error: operand expected (error token is "/dev/loop12)")

Apparently, noone including the author of the tests knows why this
truncate command is in the test, so remove the wrong truncate command.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Remove the unneeded truncate command instead of fixing it

 tests/generic/175 | 1 -
 tests/generic/297 | 1 -
 tests/generic/298 | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tests/generic/175 b/tests/generic/175
index 07af2199..f827beb6 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -33,7 +33,6 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
 
 fnr=19
 echo "Create extents"
-truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
 for i in $(seq 0 $fnr); do
 	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
 	n=$(( (2 ** i) * blksz))
diff --git a/tests/generic/297 b/tests/generic/297
index 6bdc3e1c..54c2ac21 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -42,7 +42,6 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
 fnr=26		# 2^26 reflink extents should be enough to find a slow op?
 timeout=8	# guarantee a good long run...
 echo "Find a reflink size that takes a long time"
-truncate -s $(( (2 ** i) * blksz)) $testdir/file1
 for i in $(seq 0 $fnr); do
 	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
 	n=$(( (2 ** i) * blksz))
diff --git a/tests/generic/298 b/tests/generic/298
index 95d4c02b..115a9bf7 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -42,7 +42,6 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
 fnr=26		# 2^26 reflink extents should be enough to find a slow op?
 timeout=8	# guarantee a good long run...
 echo "Find a reflink size that takes a long time"
-truncate -s $(( (2 ** i) * blksz)) $testdir/file1
 for i in $(seq 0 $fnr); do
 	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
 	n=$(( (2 ** i) * blksz))
-- 
2.34.1

