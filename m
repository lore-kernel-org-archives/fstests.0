Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A97DEB64DD
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Aug 2023 14:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHMOJ5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Aug 2023 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOJ5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Aug 2023 10:09:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB3127
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 07:09:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317dcdae365so3035034f8f.1
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691935797; x=1692540597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+b3MkMD/guKPDrTx+rrCwvFw4TyLSteIvYy2dC7qbGk=;
        b=AEx4XxTCgblCOaP+Yglc363OXo8FSy+Xzs+OX62gu6xPeq+vNH5tsttTM65L41fxkO
         TX8SuFjcnYutzXd+Q220JxDEPZUPv9jJ2Kfdy5aLggySSEsRzWfu5Er6XuPOphegNWN5
         FmqGG6Yk2t3USzCZBxHYYmJ51w9g7WQ12BZw9rdlSu31pM0mq5sBoJAMDHCaZtaV0T44
         yjOe7vYq6DYzLfW7585UkqvbxXeX/C2p14zby3RkUyG9oCMSlx4D828rFjwcgnny9XyO
         BZQLCoxYZTMSo8hI21sKuuM4JZotWCNQxAp0LtdwAsrFpBGRTx9gWRXXYBlqiq/YRnmZ
         edjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935797; x=1692540597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b3MkMD/guKPDrTx+rrCwvFw4TyLSteIvYy2dC7qbGk=;
        b=hjUyINU+hnfemqJg/rD6b+SjiHgbaKl6QXlA8+ZhI47Oi20y5o4lip+IZzg5/BQ6lb
         S5q/svz/1swDv7/I+p6vtw/DwEXUqtQX1A0b0TXqiOKQPR3WCGiHU/o/+307Ct2TRaSh
         qwwwFsyexZxag2zi/ehZlWjIqNQDqUNru/Bih/cIwqHF1ArAdoz3r35KTgErtQviNAfl
         jXnuIIfNhIenZ84FNllkwbDi0ofPs1cOnLMp/tqajd5p4psQJjySuzdboXZ+x1ZSH47l
         PNKh/xiLBaEpCUJFANNqz2InYoAL1LEsKpYEtQPcFFqHhr3aQPyJi940CmvQZgvmWkWu
         L1kA==
X-Gm-Message-State: AOJu0YyeRAEKijtLB21II2kgJpk9ulDYpgRWynbCrTmnZ8LyhgH3O6Ty
        u3GHypIUU4m6VJcmm8kO3tKgLtUjYcI=
X-Google-Smtp-Source: AGHT+IGYqRhPL0ZKBs+6doUllZ9UT+et+ZSdxOqSC0tSf4OgCintDCGBIeXjVzkTU8Edt0B1fyGRQA==
X-Received: by 2002:adf:e649:0:b0:317:61d8:3c7e with SMTP id b9-20020adfe649000000b0031761d83c7emr5779692wrn.26.1691935796726;
        Sun, 13 Aug 2023 07:09:56 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z7-20020adfd0c7000000b00317afc7949csm10864751wrh.50.2023.08.13.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:09:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH] check: fix parsing expunge file with comments
Date:   Sun, 13 Aug 2023 17:09:50 +0300
Message-Id: <20230813140950.678899-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

commit 60054d51 ("check: fix excluded tests are only expunged in the
first iteration") change to use exclude_tests array instead of file.

The check if a test is in expunge file was using grep -q $TEST_ID FILE
so it was checking if the test was a non-exact match to one of the
lines, for a common example: "generic/001 # exclude this test" would be
a match to test generic/001.

The commit regressed this example, because the new code checks for exact
match of [ "generic/001" == "generic/001 " ]. Change the code to use
prefix match to deal with this case and any other suffix correctly.

While the original code would also match line "exclude test generic/001"
I don't think that non-prefix match is a real use case.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 549725eb..e8152f59 100755
--- a/check
+++ b/check
@@ -592,7 +592,8 @@ _expunge_test()
 	local TEST_ID="$1"
 
 	for f in "${exclude_tests[@]}"; do
-		if [ "${TEST_ID}" == "$f" ]; then
+		# $f may contain traling spaces and comments
+		if [[ "$f" == ${TEST_ID}* ]]; then
 			echo "       [expunged]"
 			return 0
 		fi
-- 
2.34.1

