Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278EFC677F1
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjAJWvC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjAJWt6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:49:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B365370
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:49:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so13963583pju.3
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GywMSbUNbObTd9MZjb+pI5tfXCpGm+fRZqmLUIidfc=;
        b=BO3cwDnenTXl19qPyLLGUKubATFGbOzGrV5nxUhFO/eGnMbgvNVgerc2L+e/n7LARw
         7u4GX8wRYSoOElDTQkeiRc9yTM0khDcpZRfCE+mQnRLJELfyxoGozeYGZHzKDTNV+svu
         q0SmweSQLMgdkmm8k3/ec+88oSnGJOGyNphkeMGbeN1n9Uh/g+hroz3i3Rggq8Fw1wl7
         zn24nkJhkr96ann0OfF1KBAkyMVnYDJIiFZ5Io9mWcvjpahy7WPyKyoMC0WlLfBaQ5ct
         2ICIVb/MNr+ySzgxK4ar6iesn1iALC/60avxZAWSPHOflHOhZ8xM6u8E/EmxKjCGTHn/
         rvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GywMSbUNbObTd9MZjb+pI5tfXCpGm+fRZqmLUIidfc=;
        b=hBBwcu9jj6DwZuKFmVj5IgiCMiC8SyZJJbRjmIPnOsbywthFiUEQHUl1N3iAtRse6p
         0IADiMHTgJJNknwA8jm2zS5Nzxocuy/4Fdn+c1WdWkpUH3AvXvLz2qIhn33W7GTEoq1T
         Z05HSUfuj8cv1a6BMUOtYWj57b8vLKbeBD7RcHhbCuy3oY+qyul16bOD2hAedW9qg91O
         xZu6/J/7mott7rUEtNcWC0oouXHVC2+hB4vChIKDpWXENsjhriptrvinbhVSEib42eZt
         JlR8CsP8+wNdd6gl6yuRDXrCMwTYJbnkUTC27AiAGb9xYHzIbnFrk/4yUpmUuKaGmMtC
         ilqw==
X-Gm-Message-State: AFqh2kpnQczgru9Qw0roeCY6ofAv0WUMRhq5aLTyuNsefOsX4X+ONWuW
        wMKKbwNabLlJigyRN7lHUZZjq9zoca819ZF6
X-Google-Smtp-Source: AMrXdXu+x8eekwrYaWSA+M+EGD8ZF8UPBui19cAQSv0LLvtkaY7ZVqqoU3fr3mxdgkRGTr6OnlJL1Q==
X-Received: by 2002:a17:902:e3d5:b0:192:6a20:3cb1 with SMTP id r21-20020a170902e3d500b001926a203cb1mr49145715ple.51.1673390952281;
        Tue, 10 Jan 2023 14:49:12 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b0018999a3dd7esm8641705plg.28.2023.01.10.14.49.11
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:49:11 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pFNQa-001YlA-DM
        for fstests@vger.kernel.org; Wed, 11 Jan 2023 09:49:08 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pFNQa-004unT-1I
        for fstests@vger.kernel.org;
        Wed, 11 Jan 2023 09:49:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/3] xfs/294: performance is unreasonably slow
Date:   Wed, 11 Jan 2023 09:49:06 +1100
Message-Id: <20230110224906.1171483-4-david@fromorbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110224906.1171483-1-david@fromorbit.com>
References: <20230110224906.1171483-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This creates a bunch of files in a dir, then deletes 97% of them
attempting to leave 1 allocated inode per inode chunk so that they
aren't freed. Performance is badly limited by task creation and
destruction for each inode created. Fix this by using "echo -n >
file" rather than touch so that the shell creates the empty files
without needing to fork/exec a separate task for each creation.

This reduces runtime from 45s down to 15s.

Also add more debug with inode counts and internal superblock
counter information for determining why this test may ENOSPC on the
final creation loop.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/294 | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/294 b/tests/xfs/294
index d381e2c85..1ce0d1cc5 100755
--- a/tests/xfs/294
+++ b/tests/xfs/294
@@ -28,6 +28,13 @@ _require_test_program "punch-alternating"
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 
+dump_freespace()
+{
+	df $SCRATCH_MNT
+	df -i $SCRATCH_MNT
+	$XFS_IO_PROG -rc "statfs -c" $SCRATCH_MNT
+}
+
 # We want to mkfs with a very specific geometry
 MKFS_OPTIONS=""
 _scratch_mkfs "-d size=512m -n size=8192 -i size=1024" >> $seqres.full 2>&1 \
@@ -37,7 +44,7 @@ _scratch_mount
 # Make a ton of mostly-empty inode clusters so we can always
 # make more inodes
 mkdir $SCRATCH_MNT/tmp
-for I in `seq 1 10000`; do touch $SCRATCH_MNT/tmp/$I; done
+for I in `seq 1 10000`; do echo -n > $SCRATCH_MNT/tmp/$I; done
 
 # These mostly-empty clusters will live here:
 mkdir $SCRATCH_MNT/clusters
@@ -50,7 +57,7 @@ rm -rf $SCRATCH_MNT/tmp
 mkdir $SCRATCH_MNT/testdir
 # roughly 20 chars per file
 for I in `seq 1 100`; do
-	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
+	echo -n > $SCRATCH_MNT/testdir/12345678901234567890$I;
 done
 
 # File to fragment:
@@ -63,7 +70,7 @@ space=$(stat -f -c '%f * %S * 95 / 100' $SCRATCH_MNT | $BC_PROG)
 $XFS_IO_PROG -f -c "falloc 0 $space" $SCRATCH_MNT/fillfile ||
 	_fail "Could not allocate space"
 
-df -h $SCRATCH_MNT >> $seqres.full 2>&1
+dump_freespace >> $seqres.full 2>&1
 
 # Fill remaining space; let this run to failure
 dd if=/dev/zero of=$SCRATCH_MNT/spacefile1 oflag=direct >> $seqres.full 2>&1
@@ -75,12 +82,16 @@ $here/src/punch-alternating $SCRATCH_MNT/fragfile >> $seqres.full 2>&1
 # (and then some for good measure)
 dd conv=fsync if=/dev/zero of=$SCRATCH_MNT/spacefile2 bs=1M count=64 >> $seqres.full 2>&1
 
+dump_freespace >> $seqres.full 2>&1
+
 # Now populate the directory so that it must allocate these
 # fragmented blocks
 for I in `seq 1 1400`; do
-	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
+	echo -n > $SCRATCH_MNT/testdir/12345678901234567890$I;
 done
 
+dump_freespace >> $seqres.full 2>&1
+
 # Now traverse that ugly thing!
 find $SCRATCH_MNT/testdir | sort | _filter_scratch | md5sum
 
-- 
2.38.1

