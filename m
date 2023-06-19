Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486EFEB64DA
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Jun 2023 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFSKwZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Jun 2023 06:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFSKwB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Jun 2023 06:52:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0291BD5
        for <fstests@vger.kernel.org>; Mon, 19 Jun 2023 03:51:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8f3786f1dso36212125e9.2
        for <fstests@vger.kernel.org>; Mon, 19 Jun 2023 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687171862; x=1689763862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCTkBpB8Sc9TQPpVFkwgmVkiO8nR7ucg3dCfU2RZLTA=;
        b=q3CkKTaIMrQ2DWZlICYTJ92WDjeX1+0abCn70jL0U0wQy2AwuClDnFX+MHj/gegmLS
         1io+TMxB/ByQUtlK+Y57F6bFbLf5TKXpgdXGpsEcH0+ofC3+JEuAzjNSrGL3oHvzqlY8
         jVvWwDatppA5BJi5nkGYWnnSE3Y2U2iKFiMRUTcIcbO8GPiRwX1IJL9Ye5OUcaOS08w5
         Z6C4qhEnCR7wwT4KHuSOeS/KfDTT2aRgYw+MyBueiEejGwoYBd4pUHvkSrhpXPLywX+Q
         p78HvjunvurFiNP/uiVfV4+5iRdW8HdI4WlhUFDiC4diPwwvhRuzB6bdmjJkop0VVVm8
         oLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687171862; x=1689763862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCTkBpB8Sc9TQPpVFkwgmVkiO8nR7ucg3dCfU2RZLTA=;
        b=UJPhK0mUaxb71eGwdistZHhBMbG3DJlRzV/lZA+4hsgiZoKR92Ls16jfq3gP3SGQl/
         vTrKmu+x2P/wuHmcr5Jrnm2wMNYtURNSrFm2hYbMTgWDnG89T6f0gLbLZOJT0p+NfV+5
         8maP/CJswTgy7YkMRMvwzUEDc+9MsnrH4TNJQYL767SqR6BHT7m3P/Fj+Kw8viRqMuSj
         fa6PHBma3cAX2owSSYUWYOj48Prvv4umbqrAa5pqV4NG1gJXvzaJSzn9E7LhIh42LskC
         rTSaYxyAT3Ao468HiAPU3yl0eDGdEv8q7w67Eaea7udDxjNewELSmsFuG6xC6vYQvoOW
         oXrw==
X-Gm-Message-State: AC+VfDxW1YHs2tf+6IQGbtpieFt6eCeA9F02n49HjgCjR4uUkgiEqn2V
        qGrsj4oh9niUTlumcS5Q1PM4YEsRuwc=
X-Google-Smtp-Source: ACHHUZ5zgTEAqybAfgR/Vh+HbEuZ5h5UySEiYbXiKruTNCx8h+9AG/yjm8SwrcflARroxj8Zn0V0vQ==
X-Received: by 2002:a05:600c:22cf:b0:3f9:b358:8197 with SMTP id 15-20020a05600c22cf00b003f9b3588197mr782438wmg.11.1687171862156;
        Mon, 19 Jun 2023 03:51:02 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c2b8f00b003f4266965fbsm10348610wmc.5.2023.06.19.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:51:01 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: [PATCH] fstests: reduce runtime of check -n
Date:   Mon, 19 Jun 2023 13:50:58 +0300
Message-Id: <20230619105058.2711467-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

kvm-xfstests invokes check -n twice to pre-process and generate the
tests-to-run list, which is then being passed as a long list of tests
for invkoing check in the command line.

check invokes dirname, basename and sed several times per test just
for doing basic string prefix/suffix trimming.
Use bash string pattern matching instead which is much faster.

Note that the following pattern matching expression change:
< test_dir=${test_dir#$SRC_DIR/*}
> t=${t#$SRC_DIR/}
does not change the meaning of the expression, because the
shortest match of "$SRC_DIR/*" that is being trimmed is "$SRC_DIR/"
and removing the tests/ prefix is what this code intended to do.

With check -n, there is no need to cleanup the results dir,
but check -n is doing that for every single listed test.
Move the cleanup of results dir to before actually running the test.

These improvements to check pre-test code cut down several minutes
from the time until tests actually start to run with kvm-xfstests.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Zorro,

Just to clarify, this change is not expected to change behavior -
only to improve runtime of check -n and the things that happen
before the first test is invoked.

Thanks,
Amir.

 check | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/check b/check
index e36978c1..1a16eccb 100755
--- a/check
+++ b/check
@@ -399,9 +399,9 @@ if $have_test_arg; then
 		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
 			list=$(cd $SRC_DIR; echo $1)
 			for t in $list; do
-				test_dir=`dirname $t`
-				test_dir=${test_dir#$SRC_DIR/*}
-				test_name=`basename $t`
+				t=${t#$SRC_DIR/}
+				test_dir=${t%/*}
+				test_name=${t#*/}
 				group_file=$SRC_DIR/$test_dir/group.list
 
 				if grep -Eq "^$test_name" $group_file; then
@@ -849,18 +849,14 @@ function run_section()
 
 		# the filename for the test and the name output are different.
 		# we don't include the tests/ directory in the name output.
-		export seqnum=`echo $seq | sed -e "s;$SRC_DIR/;;"`
-
-		# Similarly, the result directory needs to replace the tests/
-		# part of the test location.
-		group=`dirname $seq`
+		export seqnum=${seq#$SRC_DIR/}
+		group=${seqnum%/*}
 		if $OPTIONS_HAVE_SECTIONS; then
-			export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
 			REPORT_DIR="$RESULT_BASE/$section"
 		else
-			export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
 			REPORT_DIR="$RESULT_BASE"
 		fi
+		export RESULT_DIR="$REPORT_DIR/$group"
 		seqres="$REPORT_DIR/$seqnum"
 
 		# Generate the entire section report with whatever test results
@@ -872,9 +868,6 @@ function run_section()
 					     "" &> /dev/null
 		fi
 
-		mkdir -p $RESULT_DIR
-		rm -f ${RESULT_DIR}/require_scratch*
-		rm -f ${RESULT_DIR}/require_test*
 		echo -n "$seqnum"
 
 		if $showme; then
@@ -899,6 +892,9 @@ function run_section()
 		fi
 
 		# really going to try and run this one
+		mkdir -p $RESULT_DIR
+		rm -f ${RESULT_DIR}/require_scratch*
+		rm -f ${RESULT_DIR}/require_test*
 		rm -f $seqres.out.bad $seqres.hints
 
 		# check if we really should run it
-- 
2.34.1

