Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21302C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjA3W5b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjA3W5a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 17:57:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E91631C
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 14:57:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z9so11798343qtv.5
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B52IcH5afCDbjXZ6XPMFWbLLH2jiHjXUS7iI27Pmhec=;
        b=PrRsnq6lBsT8vvGV9dI7i3l4jQ29CmRTflhgnwbf0Hsk/kGLDJe42tWo7NArizPWC5
         cTlWAEa47A4d4Bzpd4GiN9GqbIXyeM48DHwteo5ZLD1lIbD5Dxp2o3fVeebF6WZnDG1O
         TGYaWUp0hifNPXmzL3Xs7nA/DHuuNWM2UrBfWkDont9Dk7skyeIFOSkyGs2eIaMNpauU
         wAsysEa4IAqLQOcBTd1qf0vIdtwKOFXDuqWC7s0wSkvSRL85/UmiwiCgHkYUPNJMjAOB
         WCepKIyMnvK1Jocsz8pvtQhZYAji+lIBXfAxiS90XofleNpKI6fTGCsL+uOLFzDkXBRj
         VzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B52IcH5afCDbjXZ6XPMFWbLLH2jiHjXUS7iI27Pmhec=;
        b=eu8KPBStPXEQ+wFU0scTqn//gyUA2NcESJz84XedCqTDDGDUVp0D6lbAc9Fwg9sQQa
         An2s4X3EF8wvgXynHWqsSkyeaVrqfpj4lVVh6zcqh1ZSewKssOr/+Px9wNwNAMqUDhR7
         sEvIl4rufwVkR70lqz4s+d8HJTGK810XHM3Kf0Rew2dmuktbF+SiUSD5JCiAQGlVxHYm
         mnIchjKPH/3yyLQn4XgHcdmED9ijvceNWDrrwJ84An7X6KulAPmC/VwbHkkph9lQq4Gx
         p3QZJ9fwucHs1XrEJnou/0V3vNGLQerjNgVwhWywE6WJpK8/EyjkzyzenexGvZRCbBx7
         EA+w==
X-Gm-Message-State: AO0yUKVz/66p7AfuC4FK0mbmmCE6L9fKNpf+qOs8MY6pQYRX3Khsfvme
        POJPC79WArGWe+BR/UwJeCq/AmeRsig=
X-Google-Smtp-Source: AK7set9bQ3eddJjtZPzB3AxVlER+rcPnR5eepmjhwgmjLiNJXbUv8VxGdk8Io19odO3ggcc1vxVm2g==
X-Received: by 2002:ac8:4b65:0:b0:3b8:58d0:b4d4 with SMTP id g5-20020ac84b65000000b003b858d0b4d4mr3367655qts.2.1675119443164;
        Mon, 30 Jan 2023 14:57:23 -0800 (PST)
Received: from shiina-laptop.redhat.com ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id b25-20020ac844d9000000b003b82cb8748dsm6416332qto.96.2023.01.30.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:57:22 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH v3 2/2] xfs: test xfsrestore on multi-level dumpfiles with wrong root
Date:   Mon, 30 Jan 2023 17:56:43 -0500
Message-Id: <20230130225643.148935-3-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130225643.148935-1-shiina.hironori@fujitsu.com>
References: <20230130225643.148935-1-shiina.hironori@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

While developing `xfsrestore -x`, we hit an issue at restoring a
renamed file in the cumulative mode (multi-level dumps):
  https://lore.kernel.org/linux-xfs/e61ae295-a331-d36a-cae1-646022dc2a6e@gmail.com/
Then, this patch adds test cases where '-x' flag is used in the
cumulative mode with various file operations referring to existing tests.

Signed-off-by: Hironori Shiina <shiina.hironori@fujitsu.com>
---
 tests/xfs/567     |  125 ++++
 tests/xfs/567.out | 1517 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/568     |  213 +++++++
 tests/xfs/568.out |  849 +++++++++++++++++++++++++
 4 files changed, 2704 insertions(+)
 create mode 100644 tests/xfs/567
 create mode 100644 tests/xfs/567.out
 create mode 100644 tests/xfs/568
 create mode 100644 tests/xfs/568.out

diff --git a/tests/xfs/567 b/tests/xfs/567
new file mode 100644
index 00000000..b19eca23
--- /dev/null
+++ b/tests/xfs/567
@@ -0,0 +1,125 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test No. 567
+#
+# Tests `xfsrestore -x` which handles an wrong inode in a dump, with the
+# multi-level dumps where we hit an issue during development.
+# This procedure is cribbed from:
+#     xfs/064: test multilevel dump and restores with hardlinks
+
+. ./common/preamble
+_begin_fstest auto dump
+
+# Import common functions.
+. ./common/dump
+
+_supported_fs xfs
+_fixed_by_git_commit xfsdump \
+	"XXXXXXXXXXXX xfsrestore: fix rootdir due to xfsdump bulkstat misuse"
+_require_xfs_io_command "falloc"
+_require_scratch
+_require_xfsrestore_xflag
+
+# Create a filesystem which contains a fake root inode
+inums=($(_scratch_xfs_create_fake_root))
+root_inum=${inums[0]}
+fake_inum=${inums[1]}
+
+# Remove unnecessary files
+find $SCRATCH_MNT -not -inum $fake_inum -type f -delete
+# Rename a file root file to the static filename
+find $SCRATCH_MNT -inum $fake_inum -exec mv {} $SCRATCH_MNT/fakeroot \;
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_cleanup_dump
+	cd /
+	rm -f $tmp.*
+}
+
+_ls_size_filter()
+{
+	#
+	# Print size ($5) and fname ($9).
+	# The size is significant since we add to the file as part
+	# of a file change for the incremental.
+	#
+	# Filter out the housekeeping files of xfsrestore
+	#
+	$AWK_PROG 'NF == 9 { print $5, $9 }' |\
+	grep -E -v 'dumpdir|housekeeping|dirattr|dirextattr|namreg|state|tree'
+}
+
+
+_create_dumpdir_hardlinks 9
+
+echo "Do the incremental dumps"
+i=0
+while [ $i -le 9 ]; do
+	if [ $i -gt 0 ]; then
+		sleep 2
+		_modify_level $i
+	fi
+
+	_stable_fs
+	sleep 2
+
+	echo "********* level $i ***********" >>$seqres.full
+	date >>$seqres.full
+	find $SCRATCH_MNT -exec $here/src/lstat64 {} \; | sed 's/(00.*)//' >$tmp.dates.$i
+	if [ $i -gt 0 ]; then
+		let level_1=$i-1
+		diff -c $tmp.dates.$level_1 $tmp.dates.$i >>$seqres.full
+	else
+		cat $tmp.dates.$i >>$seqres.full
+	fi
+
+	dumpfile=$tmp.df.level$i
+	_do_dump_file -f $dumpfile -l $i
+	# Set the wrong root inode number to the dump file
+	# as problematic xfsdump used to do.
+	$here/src/fake-dump-rootino $dumpfile $fake_inum
+
+	let i=$i+1
+done
+
+echo "Listing of what files we start with:"
+ls -l $dump_dir | _ls_size_filter
+
+echo "Look at what files are contained in the inc. dump"
+i=0
+while [ $i -le 9 ]; do
+	echo ""
+	echo "restoring from df.level$i"
+	_do_restore_toc -x -f $tmp.df.level$i | \
+		sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
+		-e "s/# to ${root_inum}/# to ROOTNO/g"
+	let i=$i+1
+done
+
+echo "Do the cumulative restores"
+_prepare_restore_dir
+i=0
+while [ $i -le 9 ]; do
+	if [ $i -eq 0 ]; then
+		# The root inode is fixed at the first restore
+		opt='-x'
+	else
+		opt=
+	fi
+	echo ""
+	echo "restoring from df.level$i"
+	_do_restore_file_cum $opt -f $tmp.df.level$i | \
+		sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
+		-e "s/# to ${root_inum}/# to ROOTNO/g"
+	echo "ls -l restore_dir"
+	ls -lR $restore_dir | _ls_size_filter | _check_quota_file
+	let i=$i+1
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/567.out b/tests/xfs/567.out
new file mode 100644
index 00000000..7b5beea1
--- /dev/null
+++ b/tests/xfs/567.out
@@ -0,0 +1,1517 @@
+QA output created by 567
+Creating directory system of hardlinks to incrementally dump.
+creating hardlink file1_h1 to file1
+creating hardlink file1_h2 to file1
+creating hardlink file1_h3 to file1
+creating hardlink file1_h4 to file1
+creating hardlink file1_h5 to file1
+creating hardlink file2_h1 to file2
+creating hardlink file2_h2 to file2
+creating hardlink file2_h3 to file2
+creating hardlink file2_h4 to file2
+creating hardlink file2_h5 to file2
+creating hardlink file3_h1 to file3
+creating hardlink file3_h2 to file3
+creating hardlink file3_h3 to file3
+creating hardlink file3_h4 to file3
+creating hardlink file3_h5 to file3
+creating hardlink file4_h1 to file4
+creating hardlink file4_h2 to file4
+creating hardlink file4_h3 to file4
+creating hardlink file4_h4 to file4
+creating hardlink file4_h5 to file4
+creating hardlink file5_h1 to file5
+creating hardlink file5_h2 to file5
+creating hardlink file5_h3 to file5
+creating hardlink file5_h4 to file5
+creating hardlink file5_h5 to file5
+creating hardlink file6_h1 to file6
+creating hardlink file6_h2 to file6
+creating hardlink file6_h3 to file6
+creating hardlink file6_h4 to file6
+creating hardlink file6_h5 to file6
+creating hardlink file7_h1 to file7
+creating hardlink file7_h2 to file7
+creating hardlink file7_h3 to file7
+creating hardlink file7_h4 to file7
+creating hardlink file7_h5 to file7
+creating hardlink file8_h1 to file8
+creating hardlink file8_h2 to file8
+creating hardlink file8_h3 to file8
+creating hardlink file8_h4 to file8
+creating hardlink file8_h5 to file8
+creating hardlink file9_h1 to file9
+creating hardlink file9_h2 to file9
+creating hardlink file9_h3 to file9
+creating hardlink file9_h4 to file9
+creating hardlink file9_h5 to file9
+Do the incremental dumps
+Dumping to file...
+xfsdump  -l0 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: /var/xfsdump/inventory created
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l1 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 1 incremental dump of HOSTNAME:SCRATCH_MNT based on level 0 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l2 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 2 incremental dump of HOSTNAME:SCRATCH_MNT based on level 1 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l3 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 3 incremental dump of HOSTNAME:SCRATCH_MNT based on level 2 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l4 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 4 incremental dump of HOSTNAME:SCRATCH_MNT based on level 3 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l5 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 5 incremental dump of HOSTNAME:SCRATCH_MNT based on level 4 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l6 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 6 incremental dump of HOSTNAME:SCRATCH_MNT based on level 5 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l7 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 7 incremental dump of HOSTNAME:SCRATCH_MNT based on level 6 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l8 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 8 incremental dump of HOSTNAME:SCRATCH_MNT based on level 7 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Dumping to file...
+xfsdump  -l9 -f DUMP_FILE -M stress_tape_media -L stress_567 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 9 incremental dump of HOSTNAME:SCRATCH_MNT based on level 8 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_567"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we start with:
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+12 file5
+12 file5_h1
+12 file5_h2
+12 file5_h3
+12 file5_h4
+12 file5_h5
+12 file6
+12 file6_h1
+12 file6_h2
+12 file6_h3
+12 file6_h4
+12 file6_h5
+12 file7
+12 file7_h1
+12 file7_h2
+12 file7_h3
+12 file7_h4
+12 file7_h5
+12 file8
+12 file8_h1
+12 file8_h2
+12 file8_h3
+12 file8_h4
+12 file8_h5
+12 file9
+12 file9_h1
+12 file9_h2
+12 file9_h3
+12 file9_h4
+12 file9_h5
+Look at what files are contained in the inc. dump
+
+restoring from df.level0
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 0
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file1
+dumpdir/file1_h1
+dumpdir/file1_h2
+dumpdir/file1_h3
+dumpdir/file1_h4
+dumpdir/file1_h5
+dumpdir/file2
+dumpdir/file2_h1
+dumpdir/file2_h2
+dumpdir/file2_h3
+dumpdir/file2_h4
+dumpdir/file2_h5
+dumpdir/file3
+dumpdir/file3_h1
+dumpdir/file3_h2
+dumpdir/file3_h3
+dumpdir/file3_h4
+dumpdir/file3_h5
+dumpdir/file4
+dumpdir/file4_h1
+dumpdir/file4_h2
+dumpdir/file4_h3
+dumpdir/file4_h4
+dumpdir/file4_h5
+dumpdir/file5
+dumpdir/file5_h1
+dumpdir/file5_h2
+dumpdir/file5_h3
+dumpdir/file5_h4
+dumpdir/file5_h5
+dumpdir/file6
+dumpdir/file6_h1
+dumpdir/file6_h2
+dumpdir/file6_h3
+dumpdir/file6_h4
+dumpdir/file6_h5
+dumpdir/file7
+dumpdir/file7_h1
+dumpdir/file7_h2
+dumpdir/file7_h3
+dumpdir/file7_h4
+dumpdir/file7_h5
+dumpdir/file8
+dumpdir/file8_h1
+dumpdir/file8_h2
+dumpdir/file8_h3
+dumpdir/file8_h4
+dumpdir/file8_h5
+dumpdir/file9
+dumpdir/file9_h1
+dumpdir/file9_h2
+dumpdir/file9_h3
+dumpdir/file9_h4
+dumpdir/file9_h5
+fakeroot
+
+restoring from df.level1
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 1
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file1
+dumpdir/file1_h1
+dumpdir/file1_h2
+dumpdir/file1_h3
+dumpdir/file1_h4
+dumpdir/file1_h5
+
+restoring from df.level2
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 2
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file2
+dumpdir/file2_h1
+dumpdir/file2_h2
+dumpdir/file2_h3
+dumpdir/file2_h4
+dumpdir/file2_h5
+
+restoring from df.level3
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 3
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file3
+dumpdir/file3_h1
+dumpdir/file3_h2
+dumpdir/file3_h3
+dumpdir/file3_h4
+dumpdir/file3_h5
+
+restoring from df.level4
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 4
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file4
+dumpdir/file4_h1
+dumpdir/file4_h2
+dumpdir/file4_h3
+dumpdir/file4_h4
+dumpdir/file4_h5
+
+restoring from df.level5
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 5
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file5
+dumpdir/file5_h1
+dumpdir/file5_h2
+dumpdir/file5_h3
+dumpdir/file5_h4
+dumpdir/file5_h5
+
+restoring from df.level6
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 6
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file6
+dumpdir/file6_h1
+dumpdir/file6_h2
+dumpdir/file6_h3
+dumpdir/file6_h4
+dumpdir/file6_h5
+
+restoring from df.level7
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 7
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file7
+dumpdir/file7_h1
+dumpdir/file7_h2
+dumpdir/file7_h3
+dumpdir/file7_h4
+dumpdir/file7_h5
+
+restoring from df.level8
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 8
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file8
+dumpdir/file8_h1
+dumpdir/file8_h2
+dumpdir/file8_h3
+dumpdir/file8_h4
+dumpdir/file8_h5
+
+restoring from df.level9
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 9
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/file9
+dumpdir/file9_h1
+dumpdir/file9_h2
+dumpdir/file9_h3
+dumpdir/file9_h4
+dumpdir/file9_h5
+Do the cumulative restores
+
+restoring from df.level0
+Restoring cumumlative from file...
+xfsrestore  -x -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 0
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+0 file1
+0 file1_h1
+0 file1_h2
+0 file1_h3
+0 file1_h4
+0 file1_h5
+0 file2
+0 file2_h1
+0 file2_h2
+0 file2_h3
+0 file2_h4
+0 file2_h5
+0 file3
+0 file3_h1
+0 file3_h2
+0 file3_h3
+0 file3_h4
+0 file3_h5
+0 file4
+0 file4_h1
+0 file4_h2
+0 file4_h3
+0 file4_h4
+0 file4_h5
+0 file5
+0 file5_h1
+0 file5_h2
+0 file5_h3
+0 file5_h4
+0 file5_h5
+0 file6
+0 file6_h1
+0 file6_h2
+0 file6_h3
+0 file6_h4
+0 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level1
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 1
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+0 file2
+0 file2_h1
+0 file2_h2
+0 file2_h3
+0 file2_h4
+0 file2_h5
+0 file3
+0 file3_h1
+0 file3_h2
+0 file3_h3
+0 file3_h4
+0 file3_h5
+0 file4
+0 file4_h1
+0 file4_h2
+0 file4_h3
+0 file4_h4
+0 file4_h5
+0 file5
+0 file5_h1
+0 file5_h2
+0 file5_h3
+0 file5_h4
+0 file5_h5
+0 file6
+0 file6_h1
+0 file6_h2
+0 file6_h3
+0 file6_h4
+0 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level2
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 2
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+0 file3
+0 file3_h1
+0 file3_h2
+0 file3_h3
+0 file3_h4
+0 file3_h5
+0 file4
+0 file4_h1
+0 file4_h2
+0 file4_h3
+0 file4_h4
+0 file4_h5
+0 file5
+0 file5_h1
+0 file5_h2
+0 file5_h3
+0 file5_h4
+0 file5_h5
+0 file6
+0 file6_h1
+0 file6_h2
+0 file6_h3
+0 file6_h4
+0 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level3
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 3
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+0 file4
+0 file4_h1
+0 file4_h2
+0 file4_h3
+0 file4_h4
+0 file4_h5
+0 file5
+0 file5_h1
+0 file5_h2
+0 file5_h3
+0 file5_h4
+0 file5_h5
+0 file6
+0 file6_h1
+0 file6_h2
+0 file6_h3
+0 file6_h4
+0 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level4
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 4
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+0 file5
+0 file5_h1
+0 file5_h2
+0 file5_h3
+0 file5_h4
+0 file5_h5
+0 file6
+0 file6_h1
+0 file6_h2
+0 file6_h3
+0 file6_h4
+0 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level5
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 5
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+12 file5
+12 file5_h1
+12 file5_h2
+12 file5_h3
+12 file5_h4
+12 file5_h5
+0 file6
+0 file6_h1
+0 file6_h2
+0 file6_h3
+0 file6_h4
+0 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level6
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 6
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+12 file5
+12 file5_h1
+12 file5_h2
+12 file5_h3
+12 file5_h4
+12 file5_h5
+12 file6
+12 file6_h1
+12 file6_h2
+12 file6_h3
+12 file6_h4
+12 file6_h5
+0 file7
+0 file7_h1
+0 file7_h2
+0 file7_h3
+0 file7_h4
+0 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level7
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 7
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+12 file5
+12 file5_h1
+12 file5_h2
+12 file5_h3
+12 file5_h4
+12 file5_h5
+12 file6
+12 file6_h1
+12 file6_h2
+12 file6_h3
+12 file6_h4
+12 file6_h5
+12 file7
+12 file7_h1
+12 file7_h2
+12 file7_h3
+12 file7_h4
+12 file7_h5
+0 file8
+0 file8_h1
+0 file8_h2
+0 file8_h3
+0 file8_h4
+0 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level8
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 8
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+12 file5
+12 file5_h1
+12 file5_h2
+12 file5_h3
+12 file5_h4
+12 file5_h5
+12 file6
+12 file6_h1
+12 file6_h2
+12 file6_h3
+12 file6_h4
+12 file6_h5
+12 file7
+12 file7_h1
+12 file7_h2
+12 file7_h3
+12 file7_h4
+12 file7_h5
+12 file8
+12 file8_h1
+12 file8_h2
+12 file8_h3
+12 file8_h4
+12 file8_h5
+0 file9
+0 file9_h1
+0 file9_h2
+0 file9_h3
+0 file9_h4
+0 file9_h5
+
+restoring from df.level9
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 9
+xfsrestore: session label: "stress_567"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 56 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+ls -l restore_dir
+0 fakeroot
+12 file1
+12 file1_h1
+12 file1_h2
+12 file1_h3
+12 file1_h4
+12 file1_h5
+12 file2
+12 file2_h1
+12 file2_h2
+12 file2_h3
+12 file2_h4
+12 file2_h5
+12 file3
+12 file3_h1
+12 file3_h2
+12 file3_h3
+12 file3_h4
+12 file3_h5
+12 file4
+12 file4_h1
+12 file4_h2
+12 file4_h3
+12 file4_h4
+12 file4_h5
+12 file5
+12 file5_h1
+12 file5_h2
+12 file5_h3
+12 file5_h4
+12 file5_h5
+12 file6
+12 file6_h1
+12 file6_h2
+12 file6_h3
+12 file6_h4
+12 file6_h5
+12 file7
+12 file7_h1
+12 file7_h2
+12 file7_h3
+12 file7_h4
+12 file7_h5
+12 file8
+12 file8_h1
+12 file8_h2
+12 file8_h3
+12 file8_h4
+12 file8_h5
+12 file9
+12 file9_h1
+12 file9_h2
+12 file9_h3
+12 file9_h4
+12 file9_h5
diff --git a/tests/xfs/568 b/tests/xfs/568
new file mode 100644
index 00000000..017e17a5
--- /dev/null
+++ b/tests/xfs/568
@@ -0,0 +1,213 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test No. 568
+#
+# Tests `xfsrestore -x` which handles an wrong inode in a dump, with the
+# multi-level dumps where we hit an issue during development.
+# This procedure is cribbed from:
+#   xfs/065: Testing incremental dumps and cumulative restores with
+#            different operations for each level
+
+. ./common/preamble
+_begin_fstest auto dump
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_cleanup_dump
+	cd /
+	rm -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/dump
+. ./common/quota
+
+#
+# list recursively the directory
+#
+# e.g. lstat output: src/lstat64 31056 -rwxr-xr-x 38403,0
+# Don't print out sizes of directories - which can vary - overwrite with XXX.
+#
+_list_dir()
+{
+	__dir=$1
+	find $__dir  -exec $here/src/lstat64 -t {} \; |\
+	sed -e 's/.*dumpdir/dumpdir/' -e '/^dumpdir /d' |\
+	sed -e 's/.*restoredir/restoredir/' -e '/^restoredir /d' |\
+	grep -E -v 'housekeeping|dirattr|dirextattr|namreg|state|tree|fakeroot' |\
+	awk '$3 ~ /^d/ { $2 = "XXX" } {print}' |\
+	LC_COLLATE=POSIX sort
+}
+
+# real QA test starts here
+_supported_fs xfs
+_fixed_by_git_commit xfsdump \
+	"XXXXXXXXXXXX xfsrestore: fix rootdir due to xfsdump bulkstat misuse"
+_require_xfs_io_command "falloc"
+_require_scratch
+_require_xfsrestore_xflag
+
+#
+# too much hassle to get output matching with quotas turned on
+# so don't run it
+#
+_scratch_mkfs_xfs >> $seqres.full
+_qmount_option noquota
+_scratch_mount
+$here/src/feature -U $SCRATCH_DEV && \
+	_notrun "UQuota enabled, test needs controlled xfsdump output"
+$here/src/feature -G $SCRATCH_DEV && \
+	_notrun "GQuota enabled, test needs controlled xfsdump output"
+$here/src/feature -P $SCRATCH_DEV && \
+	_notrun "PQuota enabled, test needs controlled xfsdump output"
+_scratch_unmount
+
+#
+# adding      - touch/echo, mkdir
+# deleting    - rm, rmdir
+# renaming    - mv
+# linking     - ln
+# unlinking   - rm
+# files and directories
+#
+
+# Create a filesystem which contains a fake root inode
+inums=($(_scratch_xfs_create_fake_root))
+root_inum=${inums[0]}
+fake_inum=${inums[1]}
+
+# Remove unnecessary files
+find $SCRATCH_MNT -not -inum $fake_inum -type f -delete
+# Rename a file root file to the static filename
+find $SCRATCH_MNT -inum $fake_inum -exec mv {} $SCRATCH_MNT/fakeroot \;
+
+mkdir -p $dump_dir || _fail "cannot mkdir \"$dump_dir\""
+cd $dump_dir
+
+echo "Do the incremental dumps"
+i=0
+num_dumps=8 # do some extra to ensure nothing changes
+while [ $i -le $num_dumps ]; do
+	cd $dump_dir
+	case $i in
+	0)
+		# adding
+		echo 'add0' >addedfile0
+		echo 'add1' >addedfile1
+		echo 'add2' >addedfile2
+		echo 'add3' >addedfile3
+		mkdir addeddir1
+		mkdir addeddir2
+		mkdir addeddir3
+		mkdir addeddir4
+		echo 'add4' >addeddir3/addedfile4
+		echo 'add5' >addeddir4/addedfile5
+		;;
+	1)
+		# deleting
+		rm addedfile2
+		rmdir addeddir2
+		rm -rf addeddir3
+		;;
+	2)
+		# renaming
+		mv addedfile1 addedfile2 # rename to previous existing file
+		mv addeddir4/addedfile5 addeddir4/addedfile4
+		mv addeddir4 addeddir6
+		mv addeddir1 addeddir2 # rename to previous existing dir
+		;;
+	3)
+		# linking
+		ln addedfile0 linkfile0
+		ln addedfile0 linkfile0_1  # have a 2nd link to file
+		ln addedfile2 linkfile2
+		ln addeddir6/addedfile4 linkfile64
+		;;
+	4)
+		# unlinking
+		rm linkfile0  # remove a link
+		rm addedfile2 # remove original link
+		rm linkfile64  # remove link
+		rm addeddir6/addedfile4 # remove last link
+		;;
+	5)  # link first - then onto 6)
+		rm -rf *
+		echo 'add6' >addedfile6
+		ln addedfile6 linkfile6_1
+		ln addedfile6 linkfile6_2
+		ln addedfile6 linkfile6_3
+		;;
+	6)  # then move the inode that the links point to
+			mv addedfile6 addedfile6_mv
+		rm linkfile6_1
+		rm linkfile6_2
+		rm linkfile6_3
+		ln addedfile6_mv linkfile6_mv_1
+		ln addedfile6_mv linkfile6_mv_2
+		ln addedfile6_mv linkfile6_mv_3
+		;;
+	esac
+	cd $here
+	sleep 2
+	_stable_fs
+
+	echo "Listing of what files we have at level $i:"
+	_list_dir $dump_dir	| tee $tmp.ls.$i
+
+	dumpfile=$tmp.df.level$i
+	_do_dump_file -f $dumpfile -l $i
+	# Set the wrong root inode number to the dump file
+	# as problematic xfsdump used to do.
+	$here/src/fake-dump-rootino $dumpfile $fake_inum
+
+	let i=$i+1
+done
+
+echo "Look at what files are contained in the inc. dump"
+i=0
+while [ $i -le $num_dumps ]; do
+	echo ""
+	echo "restoring from df.level$i"
+	_do_restore_toc -x -f $tmp.df.level$i | \
+		sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
+		-e "s/# to ${root_inum}/# to ROOTNO/g"
+	let i=$i+1
+done
+
+echo "Do the cumulative restores"
+_prepare_restore_dir
+i=0
+while [ $i -le $num_dumps ]; do
+	if [ $i -eq 0 ]; then
+		# The root inode is fixed at the first restore
+		opt='-x'
+	else
+		opt=
+	fi
+	echo ""
+	echo "restoring from df.level$i"
+	_do_restore_file_cum $opt -f $tmp.df.level$i | \
+		sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
+		-e "s/# to ${root_inum}/# to ROOTNO/g"
+	echo "list restore_dir"
+	_list_dir $restore_dir | _check_quota_file | tee $tmp.restorals.$i
+	let i=$i+1
+done
+
+echo ""
+echo "Do the ls comparison"
+i=0
+while [ $i -le $num_dumps ]; do
+	echo "Comparing ls of FS with restored FS at level $i"
+	diff -s $tmp.ls.$i $tmp.restorals.$i | sed "s#$tmp#TMP#g"
+	echo ""
+	let i=$i+1
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/568.out b/tests/xfs/568.out
new file mode 100644
index 00000000..42685883
--- /dev/null
+++ b/tests/xfs/568.out
@@ -0,0 +1,849 @@
+QA output created by 568
+Do the incremental dumps
+Listing of what files we have at level 0:
+dumpdir/addeddir1 XXX drwxr-xr-x 0,0
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir3 XXX drwxr-xr-x 0,0
+dumpdir/addeddir3/addedfile4 5 -rw-r--r-- 0,0
+dumpdir/addeddir4 XXX drwxr-xr-x 0,0
+dumpdir/addeddir4/addedfile5 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile1 5 -rw-r--r-- 0,0
+dumpdir/addedfile2 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l0 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: /var/xfsdump/inventory created
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 1:
+dumpdir/addeddir1 XXX drwxr-xr-x 0,0
+dumpdir/addeddir4 XXX drwxr-xr-x 0,0
+dumpdir/addeddir4/addedfile5 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile1 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l1 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 1 incremental dump of HOSTNAME:SCRATCH_MNT based on level 0 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 2:
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6/addedfile4 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile2 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l2 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 2 incremental dump of HOSTNAME:SCRATCH_MNT based on level 1 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 3:
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6/addedfile4 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile2 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+dumpdir/linkfile0 5 -rw-r--r-- 0,0
+dumpdir/linkfile0_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile2 5 -rw-r--r-- 0,0
+dumpdir/linkfile64 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l3 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 3 incremental dump of HOSTNAME:SCRATCH_MNT based on level 2 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 4:
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6 XXX drwxr-xr-x 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+dumpdir/linkfile0_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile2 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l4 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 4 incremental dump of HOSTNAME:SCRATCH_MNT based on level 3 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 5:
+dumpdir/addedfile6 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l5 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 5 incremental dump of HOSTNAME:SCRATCH_MNT based on level 4 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 6:
+dumpdir/addedfile6_mv 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l6 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 6 incremental dump of HOSTNAME:SCRATCH_MNT based on level 5 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 7:
+dumpdir/addedfile6_mv 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l7 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 7 incremental dump of HOSTNAME:SCRATCH_MNT based on level 6 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Listing of what files we have at level 8:
+dumpdir/addedfile6_mv 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_3 5 -rw-r--r-- 0,0
+Dumping to file...
+xfsdump  -l8 -f DUMP_FILE -M stress_tape_media -L stress_568 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 8 incremental dump of HOSTNAME:SCRATCH_MNT based on level 7 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_568"
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
+Look at what files are contained in the inc. dump
+
+restoring from df.level0
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 0
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 6 directories and 12 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/addeddir3/addedfile4
+dumpdir/addeddir4/addedfile5
+dumpdir/addedfile0
+dumpdir/addedfile1
+dumpdir/addedfile2
+dumpdir/addedfile3
+fakeroot
+
+restoring from df.level1
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 1
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 7 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+
+restoring from df.level2
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 2
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 4 directories and 8 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/addeddir6/addedfile4
+dumpdir/addedfile2
+
+restoring from df.level3
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 3
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 3 directories and 12 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/addeddir6/addedfile4
+dumpdir/addedfile0
+dumpdir/addedfile2
+dumpdir/linkfile0
+dumpdir/linkfile0_1
+dumpdir/linkfile2
+dumpdir/linkfile64
+
+restoring from df.level4
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 4
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 3 directories and 8 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/addedfile0
+dumpdir/linkfile0_1
+dumpdir/linkfile2
+
+restoring from df.level5
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 5
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 6 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/addedfile6
+dumpdir/linkfile6_1
+dumpdir/linkfile6_2
+dumpdir/linkfile6_3
+
+restoring from df.level6
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 6
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 2 directories and 6 entries processed
+xfsrestore: directory post-processing
+xfsrestore: reading non-directory files
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+dumpdir/addedfile6_mv
+dumpdir/linkfile6_mv_1
+dumpdir/linkfile6_mv_2
+dumpdir/linkfile6_mv_3
+
+restoring from df.level7
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 7
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 0 directories and 0 entries processed
+xfsrestore: directory post-processing
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+
+restoring from df.level8
+Contents of dump ...
+xfsrestore  -x -f DUMP_FILE -t
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 8
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 0 directories and 0 entries processed
+xfsrestore: directory post-processing
+xfsrestore: table of contents display complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+
+Do the cumulative restores
+
+restoring from df.level0
+Restoring cumumlative from file...
+xfsrestore  -x -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 0
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: found fake rootino #FAKENO, will fix.
+xfsrestore: fix root # to ROOTNO (bind mount?)
+xfsrestore: 6 directories and 12 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addeddir1 XXX drwxr-xr-x 0,0
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir3 XXX drwxr-xr-x 0,0
+dumpdir/addeddir3/addedfile4 5 -rw-r--r-- 0,0
+dumpdir/addeddir4 XXX drwxr-xr-x 0,0
+dumpdir/addeddir4/addedfile5 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile1 5 -rw-r--r-- 0,0
+dumpdir/addedfile2 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+
+restoring from df.level1
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 1
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 7 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addeddir1 XXX drwxr-xr-x 0,0
+dumpdir/addeddir4 XXX drwxr-xr-x 0,0
+dumpdir/addeddir4/addedfile5 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile1 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+
+restoring from df.level2
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 2
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 4 directories and 8 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6/addedfile4 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile2 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+
+restoring from df.level3
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 3
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 3 directories and 12 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6/addedfile4 5 -rw-r--r-- 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile2 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+dumpdir/linkfile0 5 -rw-r--r-- 0,0
+dumpdir/linkfile0_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile2 5 -rw-r--r-- 0,0
+dumpdir/linkfile64 5 -rw-r--r-- 0,0
+
+restoring from df.level4
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 4
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 3 directories and 8 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addeddir2 XXX drwxr-xr-x 0,0
+dumpdir/addeddir6 XXX drwxr-xr-x 0,0
+dumpdir/addedfile0 5 -rw-r--r-- 0,0
+dumpdir/addedfile3 5 -rw-r--r-- 0,0
+dumpdir/linkfile0_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile2 5 -rw-r--r-- 0,0
+
+restoring from df.level5
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 5
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 6 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addedfile6 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_3 5 -rw-r--r-- 0,0
+
+restoring from df.level6
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 6
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 2 directories and 6 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addedfile6_mv 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_3 5 -rw-r--r-- 0,0
+
+restoring from df.level7
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 7
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 0 directories and 0 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addedfile6_mv 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_3 5 -rw-r--r-- 0,0
+
+restoring from df.level8
+Restoring cumumlative from file...
+xfsrestore  -f DUMP_FILE -r RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 8
+xfsrestore: session label: "stress_568"
+xfsrestore: media label: "stress_tape_media"
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: using online session inventory
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 0 directories and 0 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+list restore_dir
+dumpdir/addedfile6_mv 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_1 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_2 5 -rw-r--r-- 0,0
+dumpdir/linkfile6_mv_3 5 -rw-r--r-- 0,0
+
+Do the ls comparison
+Comparing ls of FS with restored FS at level 0
+Files TMP.ls.0 and TMP.restorals.0 are identical
+
+Comparing ls of FS with restored FS at level 1
+Files TMP.ls.1 and TMP.restorals.1 are identical
+
+Comparing ls of FS with restored FS at level 2
+Files TMP.ls.2 and TMP.restorals.2 are identical
+
+Comparing ls of FS with restored FS at level 3
+Files TMP.ls.3 and TMP.restorals.3 are identical
+
+Comparing ls of FS with restored FS at level 4
+Files TMP.ls.4 and TMP.restorals.4 are identical
+
+Comparing ls of FS with restored FS at level 5
+Files TMP.ls.5 and TMP.restorals.5 are identical
+
+Comparing ls of FS with restored FS at level 6
+Files TMP.ls.6 and TMP.restorals.6 are identical
+
+Comparing ls of FS with restored FS at level 7
+Files TMP.ls.7 and TMP.restorals.7 are identical
+
+Comparing ls of FS with restored FS at level 8
+Files TMP.ls.8 and TMP.restorals.8 are identical
+
-- 
2.39.1

