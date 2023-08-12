Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A586CC0015E
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Aug 2023 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjHLPPE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Aug 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHLPPD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Aug 2023 11:15:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C210EA
        for <fstests@vger.kernel.org>; Sat, 12 Aug 2023 08:15:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso44140381fa.3
        for <fstests@vger.kernel.org>; Sat, 12 Aug 2023 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853305; x=1692458105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lB2KVcRISOGFMFL8gXEU5DsnMgR05s0NyZpVQkOsMXs=;
        b=KAsTue0DNplRJBQL98t5SLI1McqFA5L1Vt5y4rRdkF7uKjMi7Y/hpztcxb91qpKLU7
         u+PL1w/cCKQWIuPe5gQtCQw6ZCRD69RDlhtIQsululDUbh/W4oljWdcdIPBmKrEugY1U
         uwZdsYkVgQGp8Vv/u5lnuV/cG0DlvO4l7vcvhR64a0r1WomlQKbbZw8lPRqW4PzDbey7
         WMwN+1gSDUKohrblIwAUGIQKQnPHJZo7y8xzXsX/rIk8ypEZt0F3Jp9cM6P0a7fk3E9Y
         QpQRXdJuutxXwMHVRWBjshyOoJ47Abh625fGRec6CaLPLF2KDwxGffjGvJDqRphWSNxo
         feJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853305; x=1692458105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB2KVcRISOGFMFL8gXEU5DsnMgR05s0NyZpVQkOsMXs=;
        b=D7/Lir7Y6Y151ThxpXiPku/eRC6dOt+f+9Y6/zX0ePhBBL3nxlBIrlasjAzQ3j1jpL
         U0SnTcawENDRgc+li6dZKhQA6/QsBjz0eVxnnyo4U8ck8fmE33M6dYlU/lGfmNYSt9xo
         bPNvyUBZcVve3YgCFTK8hXUvIJCECst9/VQcyftG7tIc6RTiDBMimnA3jy17fgAJ4vbZ
         TQfEDqeZbiFIVQj7vX/eLifY2d3hfkSJjGuBYJaLhCTAjrtnYbGJJCXM9Nix91xsjsz4
         R2hUStC0FQ7s0DVOH4ne/lNymCMyxo1fop9baW4nbFEZ8Ft4O2n1cSMtNlIkprzin+SR
         a+3w==
X-Gm-Message-State: AOJu0YwA009gr++65UHq42HzELHHw5FfWah8Kt8iuFEwuskcetP37Ry2
        oIJUORk7vx41CmRFfJ713AqLD8p31ms=
X-Google-Smtp-Source: AGHT+IH7XrtdbNOCwzE9MNb8HRlqJiSUZ0ATwrt0ExiQ9B9QFShO3Gikh53U/TPGYrtkCBynHrzBcg==
X-Received: by 2002:a2e:99c6:0:b0:2b9:cf90:ab9c with SMTP id l6-20020a2e99c6000000b002b9cf90ab9cmr3759374ljj.8.1691853304704;
        Sat, 12 Aug 2023 08:15:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id jw13-20020a17090776ad00b0099275c59bc9sm3545176ejc.33.2023.08.12.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:15:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH] generic/{175,297,298}: fix use of uninitialized var
Date:   Sat, 12 Aug 2023 18:15:00 +0300
Message-Id: <20230812151500.553233-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Not sure how those tests pass in regression tests.
Probably truncate silently fails and is not critical to the test.

in kdevops I get errors like:
/data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
           syntax error: operand expected (error token is "/dev/loop12)")

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/175 | 2 +-
 tests/generic/297 | 2 +-
 tests/generic/298 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/175 b/tests/generic/175
index 07af2199..14825a39 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -33,7 +33,7 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
 
 fnr=19
 echo "Create extents"
-truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
+truncate -s $(( (2 ** (fnr + 1)) * blksz)) "$testdir/file1"
 for i in $(seq 0 $fnr); do
 	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
 	n=$(( (2 ** i) * blksz))
diff --git a/tests/generic/297 b/tests/generic/297
index 6bdc3e1c..1fc48671 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
 fnr=26		# 2^26 reflink extents should be enough to find a slow op?
 timeout=8	# guarantee a good long run...
 echo "Find a reflink size that takes a long time"
-truncate -s $(( (2 ** i) * blksz)) $testdir/file1
+truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
 for i in $(seq 0 $fnr); do
 	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
 	n=$(( (2 ** i) * blksz))
diff --git a/tests/generic/298 b/tests/generic/298
index 95d4c02b..2e917a87 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
 fnr=26		# 2^26 reflink extents should be enough to find a slow op?
 timeout=8	# guarantee a good long run...
 echo "Find a reflink size that takes a long time"
-truncate -s $(( (2 ** i) * blksz)) $testdir/file1
+truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
 for i in $(seq 0 $fnr); do
 	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
 	n=$(( (2 ** i) * blksz))
-- 
2.34.1

