Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE20C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 17 May 2021 03:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB8D61206
	for <linux-fstests@archiver.kernel.org>; Mon, 17 May 2021 03:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhEQDgN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 May 2021 23:36:13 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:49221 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231508AbhEQDgN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 May 2021 23:36:13 -0400
Received: from [100.113.5.30] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id A1/43-57985-F54E1A06; Mon, 17 May 2021 03:34:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRWlGSWpSXmKPExsViZ8MxRTf+ycI
  Eg6ZOeYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN2NM/i62gnbtiboNnA+MWzi5GLg4hgU4miRun
  zjBDOHsYJXqXr2fvYuTkYBPQk1jybw8riC0iICvxf8ZqJhCbWUBH4su9LWwgtrCApcSqD9fA6
  lkEVCWWtTwDq+cV8JB43QPRKyGgIDHl4XtmiLigxMmZT1gg5khIHHzxghmiRlHi7NR1LBB2hc
  SsWW1MExh5ZyFpmYWkZQEj0ypGy6SizPSMktzEzBxdQwMDXUNDY11TXSMTQ73EKt0kvdRS3eT
  UvJKiRKCsXmJ5sV5xZW5yTopeXmrJJkZgeKUUsn7cwXjo9Qe9Q4ySHExKorz77OYnCPEl5adU
  ZiQWZ8QXleakFh9ilOHgUJLgvfNoYYKQYFFqempFWmYOMNRh0hIcPEoivI/vAqV5iwsSc4sz0
  yFSpxh1OS5fn7eIWYglLz8vVUqcV+cxUJEASFFGaR7cCFjcXWKUlRLmZWRgYBDiKUgtys0sQZ
  V/xSjOwagkzHsHZApPZl4J3KZXQEcwAR2xrWceyBEliQgpqQYmpfvq0+ZJLXrp2et7ieEqQ8H
  GyWfecMx9vEp5N/9ib59YddFpPwunT1EIF3XLSFv9Om3FrVuXfeRONmhvC3LSbEx+ENs3pWW7
  HWdgycX0DRFFvzN0zpwOnHKh+enyiQ8XRM8KDF92q6p8YmUa74OYFJ97IsskcnTr9Z/PF4nmt
  tqySIn/0K2iGptJjAW3fqT6Lf/Hsp3fzGOJ99YvN5cdz/ZcHjhxUvALG2cNocsLJaKb+25Mj/
  YsCxA32vHZdJmTz2Sf+AZh7t8GjHf6ZuctsjIy/xLl28HqqiSwRPQs85mU7Qe1/y21XyVvebG
  mWySM95aMz5bzhnHilZpdewtlBOojjqUtLovqOtzQoqLEUpyRaKjFXFScCAD0kNe5NgMAAA==
X-Env-Sender: huangjh.jy@fujitsu.com
X-Msg-Ref: server-6.tower-238.messagelabs.com!1621222494!299204!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32732 invoked from network); 17 May 2021 03:34:55 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-6.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 May 2021 03:34:55 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 14H3YlS7003369
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Mon, 17 May 2021 04:34:54 +0100
Received: from localhost.localdomain (10.167.220.33) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Mon, 17 May 2021 04:34:45 +0100
From:   Jinhui Huang <huangjh.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Subject: [PATCH] xfs: Add the appropriate _require helper
Date:   Mon, 17 May 2021 11:34:13 +0800
Message-ID: <1621222453-2824-1-git-send-email-huangjh.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.33]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1.xfs/162 uses xfs_db -c 'fuzz' but forgets to check if the feature
is supported. This will cause the case to fail on a system without
fuzz support. so we add _require to check if the fuzz is supported.

2.xfs/495 use _require_scratch_xfs_fuzz_fields to check the features
required by field fuzzing, but some of the features are not used in
this case like xfs_scrub, this will cause the case to skip on a system
without xfs_scrub support, even if the features being uesd are supported.
So we just need to use _require to check the features being used.

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 tests/xfs/162 | 2 ++
 tests/xfs/495 | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/162 b/tests/xfs/162
index e3257a3..c7c72d1 100755
--- a/tests/xfs/162
+++ b/tests/xfs/162
@@ -31,6 +31,8 @@ _cleanup()
 # real QA test starts here
 _supported_fs xfs
 _require_scratch_nocheck
+_require_populate_commands
+_require_xfs_db_command "fuzz"
 
 rm -f $seqres.full
 
diff --git a/tests/xfs/495 b/tests/xfs/495
index 6292b5e..a3b4fb2 100755
--- a/tests/xfs/495
+++ b/tests/xfs/495
@@ -32,7 +32,9 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs xfs
-_require_scratch_xfs_fuzz_fields
+_require_scratch_nocheck
+_require_populate_commands
+_require_xfs_db_command "fuzz"
 
 echo "Format and populate"
 _scratch_populate_cached nofill > $seqres.full 2>&1
-- 
1.8.3.1

