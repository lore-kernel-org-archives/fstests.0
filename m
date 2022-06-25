Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5365ACCA473
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiFYDIP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiFYDHh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:07:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681426801E
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:07:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25P37WKT010327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 23:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656126454; bh=ypqd/td0tS0WQt7msGj29BedADOKfGdf/46sCVC/B+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TrmD1sAgJr0w2nkOX6hEJ2wnb1+78yelbdcjITfOx6cgL+RxKO4jdai2tz9MRkXiR
         X31GzpvWfhp8Kk2kmog6xTa4v3muZ0oLgLrxhomnDvyI/a80YATRNktfIRCJSJYCIv
         2JjzDecd9HVi8NJe+czpdPBXC96ohwaPVMY2SbdxKG8YBSClIyEiLxvZmR+PDgT9Ck
         YTigkEHbGXlTvN/zIYwyY9ofmtbK7+tpbGSgscXJgKkHK8/VlPuT4LbAqsj9yuYWIt
         7rFJ+A4LVHDtoghZ1FXPafQCnDOh5D30QXmnBIwHUjxf+zHdG+JSudv2wNyTsMw6to
         w9RlyYLZSeA/Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C5AF315C430F; Fri, 24 Jun 2022 23:07:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/5] ext4/050: support indirect as well as extent mapped journals
Date:   Fri, 24 Jun 2022 23:07:14 -0400
Message-Id: <20220625030718.1215980-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220625030718.1215980-1-tytso@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Simplify the test and fix ext4/050 failures when running ext4 without
extents enabled (e.g., in ext3 emulation mode).

Instead of relying on parsing debugfs output's (which varies depending
on whether the journal inode is extent mapped or indirect block
mapped), use debugfs's "cat" command to get the contents of the
journal.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/050 | 58 +++++---------------------------------------------
 1 file changed, 5 insertions(+), 53 deletions(-)

diff --git a/tests/ext4/050 b/tests/ext4/050
index 79961957..6f93b86d 100755
--- a/tests/ext4/050
+++ b/tests/ext4/050
@@ -22,55 +22,6 @@ _require_command "$DEBUGFS_PROG" debugfs
 checkpoint_journal=$here/src/checkpoint_journal
 _require_test_program "checkpoint_journal"
 
-# convert output from stat<journal_inode> to list of block numbers
-get_journal_extents() {
-	inode_info=$($DEBUGFS_PROG $SCRATCH_DEV -R "stat <8>" 2>> $seqres.full)
-	echo -e "\nJournal info:" >> $seqres.full
-	echo "$inode_info" >> $seqres.full
-
-	extents_line=$(echo "$inode_info" | awk '/EXTENTS:/{ print NR; exit }')
-	get_extents=$(echo "$inode_info" | sed -n "$(($extents_line + 1))"p)
-
-	# get just the physical block numbers
-	get_extents=$(echo "$get_extents" |  perl -pe 's|\(.*?\):||g' | sed -e 's/, /\n/g' | perl -pe 's|(\d+)-(\d+)|\1 \2|g')
-
-	echo "$get_extents"
-}
-
-# checks all extents are zero'd out except for the superblock
-# arg 1: extents (output of get_journal_extents())
-check_extents() {
-	echo -e "\nChecking extents:" >> $seqres.full
-	echo "$1" >> $seqres.full
-
-	super_block="true"
-	echo "$1" | while IFS= read line; do
-		start_block=$(echo $line | cut -f1 -d' ')
-		end_block=$(echo $line | cut -f2 -d' ' -s)
-
-		# if first block of journal, shouldn't be wiped
-		if [ "$super_block" == "true" ]; then
-			super_block="false"
-
-			#if super block only block in this extent, skip extent
-			if [ -z "$end_block" ]; then
-				continue;
-			fi
-			start_block=$(($start_block + 1))
-		fi
-
-		if [ ! -z "$end_block" ]; then
-			blocks=$(($end_block - $start_block + 1))
-		else
-			blocks=1
-		fi
-
-		check=$(od $SCRATCH_DEV --skip-bytes=$(($start_block * $blocksize)) --read-bytes=$(($blocks * $blocksize)) -An -v | sed -e 's/[0 \t\n\r]//g')
-
-		[ ! -z "$check" ] && echo "error" && break
-	done
-}
-
 testdir="${SCRATCH_MNT}/testdir"
 
 _scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
@@ -93,11 +44,12 @@ sync --file-system $testdir/1
 # call ioctl to checkpoint and zero-fill journal blocks
 $checkpoint_journal $SCRATCH_MNT --erase=zeroout || _fail "ioctl returned error"
 
-extents=$(get_journal_extents)
-
 # check journal blocks zeroed out
-ret=$(check_extents "$extents")
-[ "$ret" = "error" ] && _fail "Journal was not zero-filled"
+$DEBUGFS_PROG $SCRATCH_DEV -R "cat <8>" 2> /dev/null | od >> $seqres.full
+check=$($DEBUGFS_PROG $SCRATCH_DEV -R "cat <8>" 2> /dev/null | \
+	    od --skip-bytes="$blocksize" -An -v | sed -e '/^[0 \t]*$/d')
+
+[ ! -z "$check" ] && _fail "Journal was not zeroed"
 
 _scratch_unmount >> $seqres.full 2>&1
 
-- 
2.31.0

