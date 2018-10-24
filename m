Received: from mail-qk1-f195.google.com ([209.85.222.195]:38810 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeJXXCT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Oct 2018 19:02:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id p3-v6so3301474qkb.5
        for <fstests@vger.kernel.org>; Wed, 24 Oct 2018 07:33:58 -0700 (PDT)
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH] check: skip parsing if the file is not shell script.
Date: Wed, 24 Oct 2018 10:33:07 -0400
Message-Id: <20181024143307.25372-1-msys.mizuma@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

If we run tests using '*', for example './check xfs/*', we will
get following error messages. This patch introduces to avoid
the messages.

./check xfs/*
xfs/001.out - unknown test, ignored
xfs/002.out - unknown test, ignored
xfs/003.out - unknown test, ignored
xfs/004.out - unknown test, ignored
...

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check b/check
index f3c8021d..96cb222f 100755
--- a/check
+++ b/check
@@ -339,6 +339,10 @@ if $have_test_arg; then
 				test_dir=`dirname $t`
 				test_dir=${test_dir#$SRC_DIR/*}
 				test_name=`basename $t`
+				if ! file -bi $SRC_DIR/$test_dir/$test_name | \
+					egrep -q 'text/x-shellscript'; then
+					continue
+				fi
 				group_file=$SRC_DIR/$test_dir/group
 
 				if egrep -q "^$test_name" $group_file; then
-- 
2.18.0
