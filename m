Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003AEC432BE
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 01:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E7960E90
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 01:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhH3BO5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Aug 2021 21:14:57 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43070 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhH3BO4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Aug 2021 21:14:56 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3D83C104D025
        for <fstests@vger.kernel.org>; Mon, 30 Aug 2021 11:14:02 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mKVs9-006W7P-GJ
        for fstests@vger.kernel.org; Mon, 30 Aug 2021 11:14:01 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1mKVs9-002vPS-6M
        for fstests@vger.kernel.org; Mon, 30 Aug 2021 11:14:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] fstests: which has been deprecated by Debian
Date:   Mon, 30 Aug 2021 11:14:01 +1000
Message-Id: <20210830011401.697295-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=MhDmnRu9jo8A:10 a=20KFwNOVAAAA:8 a=0hNrBVDOQfQb40N9bkUA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This patch is brought to you by the Department That Hates Users.

The latest debian unstable release is now causing a bunch of new
test failures because they have deprecated the which command.

Rather than make everyone jump through hoops chasing problems with
'which' while debian decides to how to package at least three
variants of 'which' - each which will different semantics, behaviour
and support - as alternatives users then have to opt into, let's
just remove the remaining uses of the shell independent 'which'
command and replace them with bash builtin 'type -P' operations.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc         | 2 +-
 src/fill2fs       | 2 +-
 tests/ext4/006    | 2 +-
 tests/generic/128 | 2 +-
 tests/generic/452 | 2 +-
 tests/xfs/293     | 2 +-
 tests/xfs/505     | 2 +-
 tests/xfs/514     | 2 +-
 tests/xfs/515     | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/common/rc b/common/rc
index a7f9ed86..db400c4d 100644
--- a/common/rc
+++ b/common/rc
@@ -4,7 +4,7 @@
 
 . common/config
 
-BC=$(which bc 2> /dev/null) || BC=
+BC="$(type -P bc)" || BC=
 
 _require_math()
 {
diff --git a/src/fill2fs b/src/fill2fs
index 1c3383a8..d5e5436b 100755
--- a/src/fill2fs
+++ b/src/fill2fs
@@ -111,7 +111,7 @@ sub normal {
 #
 
 chomp($cwd = `pwd`);
-chomp($_ = `which fill2 2>&1 | head -1`);
+chomp($_ = `type -P fill2 | head -1`);
 if (-x $_) {
   # look in the path
   $fill2 = fill2;
diff --git a/tests/ext4/006 b/tests/ext4/006
index 17e77f86..48ed6bee 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -24,7 +24,7 @@ _cleanup()
 . ./common/populate
 . ./common/fuzzy
 
-if [ ! -x "$(which e2fuzz)" ]; then
+if [ ! -x "$(type -P e2fuzz)" ]; then
 	_notrun "Couldn't find e2fuzz"
 fi
 
diff --git a/tests/generic/128 b/tests/generic/128
index dfc67fd5..dc1d43f4 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -23,7 +23,7 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount "-o nosuid"
 
 mkdir $SCRATCH_MNT/nosuid
-cp `which ls` $SCRATCH_MNT
+cp "$(type -P ls)" $SCRATCH_MNT
 chmod 700 $SCRATCH_MNT/nosuid
 chmod 4755 $SCRATCH_MNT/ls
 
diff --git a/tests/generic/452 b/tests/generic/452
index ee4dfe9e..7cbd2dfa 100755
--- a/tests/generic/452
+++ b/tests/generic/452
@@ -26,7 +26,7 @@ _exclude_scratch_mount_option "noexec"
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
-LS=$(which ls --skip-alias --skip-functions)
+LS="$(type -P ls) --skip-alias --skip-functions)"
 SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
 cp $LS $SCRATCH_LS
 
diff --git a/tests/xfs/293 b/tests/xfs/293
index fbd26b63..20f8c486 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -30,7 +30,7 @@ case "$MANPAGE" in
 *)		CAT=cat;;
 esac
 
-_require_command `which $CAT` $CAT
+_require_command "$(type -P $CAT)" $CAT
 
 for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
   $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
diff --git a/tests/xfs/505 b/tests/xfs/505
index 8a999ff4..71fb6e9d 100755
--- a/tests/xfs/505
+++ b/tests/xfs/505
@@ -26,7 +26,7 @@ case "$MANPAGE" in
 *.xz)		CAT=xzcat;;
 *)		CAT=cat;;
 esac
-_require_command `which $CAT` $CAT
+_require_command "$(type -P $CAT)" $CAT
 
 for COMMAND in `$XFS_SPACEMAN_PROG -c help $TEST_DIR | awk '{print $1}' | grep -v "^Use"`; do
   $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
diff --git a/tests/xfs/514 b/tests/xfs/514
index a9c67645..cf5588f2 100755
--- a/tests/xfs/514
+++ b/tests/xfs/514
@@ -34,7 +34,7 @@ case "$MANPAGE" in
 *.xz)		CAT=xzcat;;
 *)		CAT=cat;;
 esac
-_require_command `which $CAT` $CAT
+_require_command "$(type -P $CAT)" $CAT
 
 file=$TEST_DIR/xx.$seq
 truncate -s 128m $file
diff --git a/tests/xfs/515 b/tests/xfs/515
index 32216fe6..2d7bbb35 100755
--- a/tests/xfs/515
+++ b/tests/xfs/515
@@ -34,7 +34,7 @@ case "$MANPAGE" in
 *.xz)		CAT=xzcat;;
 *)		CAT=cat;;
 esac
-_require_command `which $CAT` $CAT
+_require_command "$(type -P $CAT)" $CAT
 
 for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
   $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
-- 
2.31.1

