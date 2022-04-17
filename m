Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A678DC433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Apr 2022 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiDQRnP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiDQRnN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 13:43:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8C2F011
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so16256509wrh.11
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Nt2H8dnSKzdahB11/DEz8yIshCPVlEfhuKcx3/7zzI=;
        b=b8aU000JiyK4B9mLxwMztboVBOu/Dk64uh+eCWtNnlv9bE2ZT0oMF5JIyBJ0VZ0VBN
         xR7L+QBLEYIObmn7N1I4+eKmz9gLZTr49m00jpDqjLX6mQoN8TFJMbuuLGUm9R6c546E
         MnI65lsKps+INqDS8dBRkLohkWRr8CnsOQBcrk79FKFNNtbtt0TOJF5pWRh5n1MrNBu9
         XtIED3jDhUUKTbggLZlENT3HGBi4gHcaApC/GU+a2qUDVTEJHyfXE8ZUpM4R1CmN9PM2
         92n01bH8gp49eXEjxjXfxyYo1CqW3HhOUjBbdXJMOn8tWxWhUKiP5KolPmVhsmei3qH/
         NBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Nt2H8dnSKzdahB11/DEz8yIshCPVlEfhuKcx3/7zzI=;
        b=fLtHoem582FP9tywe5jiVdrrsnwdqWJpGO4urRYfNszghRKubPniYwXxw5X8aFEF/q
         Ro2Yuih8h0F7YrFswnJ5bntsTa5MGSQLPTcE2ONhdhAPB09G1FO7Xhn4KzKPhzSARyf4
         hZqwNwU84morbFHk7Fu3eSne3YGE96/utLwwu0twmO+M6jFyKIW/Sz+A+ZkQpS/9bA24
         BLjkvzgEE2+aP98aRjjeviXDEVOYtTdOyIIxZhQMubQ50JXChBsjqFiHhoN904cvh/Jb
         VUDjVdFSAooAAVU/OFpeLS684xbJjzLLH8T0ksGBlMmA/6A+kTs0S5imsPCyRzOaN0Fr
         fosA==
X-Gm-Message-State: AOAM530fkMCLEIegr4nA7tOUBO/zAHzLUECfUR0XLIqDLVw64a/kq/zM
        Ym0UWbwwlQeQl4doIoWfMyc=
X-Google-Smtp-Source: ABdhPJyFA1sW2YW9sE8fyjosC84L7cN8IsG7/rT3cfWjAM4Q4qNFNlbLTyNEHj+76p4hfcXum7DRCg==
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id n12-20020a5d588c000000b002057f173901mr5886590wrf.359.1650217235742;
        Sun, 17 Apr 2022 10:40:35 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm9108564wrg.70.2022.04.17.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:40:35 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH 3/3] common: add run option to skip tests for known issues
Date:   Sun, 17 Apr 2022 20:40:23 +0300
Message-Id: <20220417174023.3244263-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417174023.3244263-1-amir73il@gmail.com>
References: <20220417174023.3244263-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some tests are written before a fix is merged upstream and some tests
are written without a known available fix at all. Such is the case with
test overlay/061.

Introduce a helper _known_issues_on_fs() which can be used to document
this situation and print a hint on failure.
The helper supports specifying specifc fs with the known issue for
generic tests as well as the notation ^FS1 ^FS2 to indicate a known issue
on all filesystems expect for FS1 FS2.

Setting the variable SKIP_KNOWN_ISSUES=yes, will cause all tests
annotated as known issues for the tested fs to be skipped.

A future improvement may provide a run option to skip tests based on
_known_issues_before_kernel when running the tests on an older kernel
version.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 README            |  2 ++
 common/rc         | 16 +++++++++++++++-
 tests/overlay/061 |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 7da66cb6..8abc3840 100644
--- a/README
+++ b/README
@@ -241,6 +241,8 @@ Misc:
    this option is supported for all filesystems currently only -overlay is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
+ - set SKIP_KNOWN_ISSUES=yes to skip tests for bug without a known fix.
+   Those tests are annotated with _known_issue_on_fs helper.
 
 ______________________
 USING THE FSQA SUITE
diff --git a/common/rc b/common/rc
index 2e9dc408..3cf60a7e 100644
--- a/common/rc
+++ b/common/rc
@@ -1597,8 +1597,23 @@ _supported_fs()
 		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
+_known_issue_on_fs()
+{
+	# Only "supported" fs have the known issue
+	_check_supported_fs $* || return
+
+	if [ "$SKIP_KNOWN_ISSUES" = "yes" ]; then
+		_notrun "known issue for this filesystem type: $FSTYP"
+	fi
+
+	echo "HINT: You _MAY_ be hit by a known issue for filesystem type $FSTYP." >> $seqres.hints
+	echo >> $seqres.hints
+}
+
 _known_issue_before_kernel()
 {
+	# TODO: don't run if $SKIP_KNOWN_ISSUES and kernel version < $1
+
 	echo "HINT: You _MAY_ be hit by a known issue on kernel version < $1." >> $seqres.hints
 	echo >> $seqres.hints
 }
@@ -4929,7 +4944,6 @@ _require_kernel_config()
 	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
 }
 
-
 init_rc
 
 ################################################################################
diff --git a/tests/overlay/061 b/tests/overlay/061
index b80cf5a0..36be3391 100755
--- a/tests/overlay/061
+++ b/tests/overlay/061
@@ -22,6 +22,8 @@ _begin_fstest posix copyup
 
 # real QA test starts here
 _supported_fs overlay
+_known_issue_on_fs overlay
+
 _require_scratch
 _require_xfs_io_command "open"
 
-- 
2.35.1

