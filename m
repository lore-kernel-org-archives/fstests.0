Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EBC46467
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjAJWCE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjAJWCC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:02:02 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3124436C
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:01:59 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4c131bede4bso172033587b3.5
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ld8iu05LQcCDkF9K6YHuIIxei5NrYq4Vlznh790k0=;
        b=JTe96x1PTv4xXOrz5nG8lG1lTPA+xoY7plcnTGf11ZGgd/cGC8Pkxj0e+OirPN1Dcg
         zNHabvuPRpc9zyLm1UO7k7yPrUbsdoZ3PeNQhO10rld+bZJTkPjT0xk5YsfKDG9JDRcL
         bk81u1v/iCZ/r3tO6p9FCT0sKdzH14oYtHKxjA2hIv/E4hJgx1AHfsNWMREa2MvgdnBh
         iHHeOzvPOjZWcAtmupv32uDgDlqj7jM3fXQkpDZVtoEfcFf5qxY1OpttWmEOrzYnNztx
         mb/6UNrPF/vXpGTV6K1oeIzwrJ4QhHmX2M91cFfAl00VEgusSvmi1jZrfrWxzxqxWHmi
         ZpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ld8iu05LQcCDkF9K6YHuIIxei5NrYq4Vlznh790k0=;
        b=qKOlMZWjTb8ulD/0ghUn+J7fnpswnf37mF6ZuGcnrTWzTvPMwS3HUeMZyux1lIbkyH
         Bk6TlANhmmaaNxGY7ssqclgOKxQpL0buN5B7RttqIkEfmuSvMW43/Q3bdX4pl6LMu5Am
         05eD+XdpX5+VV0Tx8oK5AxAKs2+EC+apiVOgK6qpUR6yQvMDNW3yDQ3mCnMumHPfB4VL
         7TbQGIlOEHH5N4wqQ7GmKmTGKxa+80y9VgNlLHHm/nzXXadKgZNvfJ90ATAMUA+TRFd8
         wK5VUE7rwM4fmFhOWG69AjKCCg6uSiMdgn+Q/l2O04F1d4WhbCRYN6VDeiOhhLMpb+jM
         HsGQ==
X-Gm-Message-State: AFqh2krVhaqQv4sH8idWwoucjsDcRDcf/gikGuxbB3QPCqsVJDeOq31J
        SeiEdbD+trK65h7yU0HmfMKVAKTetjI=
X-Google-Smtp-Source: AMrXdXvGRBhwZ6dWoHYXoFVkWclqur+05ZLfCNdgWWieoACr3ExXM1UrxGka5PSPSJJ6Yw00izbwuQ==
X-Received: by 2002:a0d:d913:0:b0:461:bc41:3c84 with SMTP id b19-20020a0dd913000000b00461bc413c84mr18491623ywe.22.1673388118326;
        Tue, 10 Jan 2023 14:01:58 -0800 (PST)
Received: from shiina-laptop.hsd1.ma.comcast.net ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006fc7302cf89sm7936709qkp.28.2023.01.10.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:01:57 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH 2/2] xfs: test xfsrestore on multi-level dumpfiles with wrong root
Date:   Tue, 10 Jan 2023 17:00:58 -0500
Message-Id: <20230110220058.139131-3-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110220058.139131-1-shiina.hironori@fujitsu.com>
References: <20230110220058.139131-1-shiina.hironori@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test 'xfsrestore -x' to correct a wrong root in multi-level dump files.
A root inode number can be wrong in a dump created by problematic
xfsdump (v3.1.7 - v3.1.9) because of bulkstat misuse.

Signed-off-by: Hironori Shiina <shiina.hironori@fujitsu.com>
---
 tests/xfs/560     |  125 ++++
 tests/xfs/560.out | 1517 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1642 insertions(+)
 create mode 100644 tests/xfs/560
 create mode 100644 tests/xfs/560.out

diff --git a/tests/xfs/560 b/tests/xfs/560
new file mode 100644
index 00000000..f4be8ef1
--- /dev/null
+++ b/tests/xfs/560
@@ -0,0 +1,125 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test No. 560
+#
+# Create a filesystem which contains an inode with a lower number
+# than the root inode. Set the lower number to dump files as the root inode
+# and ensure that 'xfsrestore -x' handles this wrong inode for multi-level
+# dumps. This procedure is cribbed from xfs/064
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
+inums=($(_xfs_create_fake_root))
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
+	dump_file=$tmp.df.level$i
+	_do_dump_file -f $dump_file -l $i
+	# Set the wrong root inode number to the dump file
+	# as problematic xfsdump used to do.
+	$here/src/fake-dump-rootino $dump_file $fake_inum
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
diff --git a/tests/xfs/560.out b/tests/xfs/560.out
new file mode 100644
index 00000000..0f2236a6
--- /dev/null
+++ b/tests/xfs/560.out
@@ -0,0 +1,1517 @@
+QA output created by 560
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
+xfsdump  -l0 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l1 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 1 incremental dump of HOSTNAME:SCRATCH_MNT based on level 0 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l2 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 2 incremental dump of HOSTNAME:SCRATCH_MNT based on level 1 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l3 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 3 incremental dump of HOSTNAME:SCRATCH_MNT based on level 2 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l4 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 4 incremental dump of HOSTNAME:SCRATCH_MNT based on level 3 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l5 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 5 incremental dump of HOSTNAME:SCRATCH_MNT based on level 4 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l6 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 6 incremental dump of HOSTNAME:SCRATCH_MNT based on level 5 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l7 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 7 incremental dump of HOSTNAME:SCRATCH_MNT based on level 6 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l8 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 8 incremental dump of HOSTNAME:SCRATCH_MNT based on level 7 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsdump  -l9 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 9 incremental dump of HOSTNAME:SCRATCH_MNT based on level 8 dump begun DATE
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
+xfsrestore: session label: "stress_560"
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
-- 
2.39.0

