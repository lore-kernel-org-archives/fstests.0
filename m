Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FAC4361B
	for <linux-fstests@archiver.kernel.org>; Sat, 19 Dec 2020 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D075A23BE2
	for <linux-fstests@archiver.kernel.org>; Sat, 19 Dec 2020 09:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgLSJL6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 19 Dec 2020 04:11:58 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:49390 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgLSJL6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 19 Dec 2020 04:11:58 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 5EAB66C00781;
        Sat, 19 Dec 2020 11:11:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1608369071; bh=9Qiuyis32ZgrNgXBpCGhfBqxbOpZ+gNJ9BfYCkqdJcw=;
        h=From:To:Cc:Subject:Date;
        b=Kp1JluowjQ5t08A0B/WbcLHfgnpM8VEazWpoyUtJ2QTnCM1ti6I1yrpck+iqu9pjF
         YlujZBrszjC4ozk6XjoAvSsnDHZ5oc/GKfGMPTfufk9BQIUqp/4LNV+RDEI9zI8bfe
         vSWusHf0VgxXcxIWX/ucnOJaJI3+DNde4V5oij2c=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 50DD36C00772;
        Sat, 19 Dec 2020 11:11:11 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id MabOrzD9QT-M; Sat, 19 Dec 2020 11:11:11 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D9F2B6C00770;
        Sat, 19 Dec 2020 11:11:10 +0200 (EET)
Received: from localhost.localdomain (unknown [45.87.95.238])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 90DA91BE0094;
        Sat, 19 Dec 2020 11:11:08 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     fstests@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, l@damenly.su
Subject: [PATCH v2] shared/032: add options for jffs2
Date:   Sat, 19 Dec 2020 17:10:58 +0800
Message-Id: <20201219091058.26422-1-l@damenly.su>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtNzzY6IuClpKemqX1UmH7kOSmad00TUhO/gQ4FQH+k
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Recently I found that my disk space was eaten by results/shared/032.full
after one round of xfstests running. The file was filled with binary
bytes by the command:
`mkfs -t jffs2 /dev/mapper/test-2 >> results/shared/032.full 2>&1`

Manual of mkfs.jffs2:
========================================================================
The program mkfs.jffs2 creates a JFFS2 (Second Journalling Flash
File System) file system image and writes the resulting image to the
file specified by the -o option or by default to the standard output,
unless the standard output is a terminal device in which case mkfs.jffs2
will abort. The file system image is created using the files and
directories contained in the directory specified by the option -r or
the present directory, if the -r option is not specified.
========================================================================

So the command equals to
`mkfs -t jffs2 -r xfstests-dev /dev/mapper/test-2 \
    -o xfstests-dev/results/shared/032.full \
    >>xfstests-dev/results/shared/032.full 2>&1`

The output image 032.full is under the directory xfstests-dev.
mkfs.jffs2 keeps reading from 032.full in page size and append bytes
to 032.full until the disk where xfstests-devel located is full.

Fix it by setting @preargs to '-r /proc/fs -o' for jffs2, now the output
is $SCRATCH_DEV. Since mkfs.jffs2 doesn't check overwrite case, just
skip overwrite attempt.

Signed-off-by: Su Yue <l@damenly.su>
---
v2:
  Fix typos in comment.
  Fix path of results/shared/032.full in commit message.
---
 tests/shared/032 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/shared/032 b/tests/shared/032
index 00ae6860d9d5..9836f13a691b 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -55,6 +55,8 @@ do
 	[ $fs = ext3 ] && preargs="-F"
 	[ $fs = ext4 ] && preargs="-F"
 	[ $fs = ext4dev ] && preargs="-F"
+	# jffs2 mkfs requires '-r $directory' and '-o $image'
+	[ $fs = jffs2 ] && preargs="-r /proc/fs -o"
 
 	# overwite the first few Kb - should blow away superblocks
 	$here/src/devzero -n 20 $SCRATCH_DEV >/dev/null
@@ -66,6 +68,9 @@ do
 
 	if [ $? -eq 0 ] ; then
 		# next, ensure we don't overwrite it
+		# jffs2 mkfs doesn't check overwrite case
+		[ $fs = jffs2 ] && continue
+
 		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
 		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
 
-- 
2.29.2

