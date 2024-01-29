Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD052F62
	for <fstests@vger.kernel.org>; Mon, 29 Jan 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572293; cv=none; b=oUlKgijsoFe2cROcB3iAKgk+mNzOIRucWJi0mlVgGXW5hSvOMc7yGFY9qdcmqhA2f1y2iDKeXNpVy83UZKRZQQYeRCvYyT/Zdb9s9IPHGecHn8CjumS08kXLGSQZBK4e1fO4Y5dbMSRokXaV8e0Ixde/pgevp8ylMJyyCOlrELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572293; c=relaxed/simple;
	bh=UAmv95obHpeljHLYSpHoc6MpMzuUXb9jBy4NPRlclGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/jeaROIScDzia6RDePAfsfCWd5/NMggdZyKhonGuRS8VnLv2lh0uYUjaPzbzzcOAwS9FfLPg9aCMha0zqPp8bPyAQIZQFkpCcZyougtsTvhkg66b/MNT95X5TrtkU+6BDUj+bwtEL2ne8F+9QxWTpdlM1Gt1TrA1N+EXdE6z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G5CLwVx4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G5CLwVx4"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d057b6ddfdso3441641fa.2
        for <fstests@vger.kernel.org>; Mon, 29 Jan 2024 15:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706572287; x=1707177087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPF03DMZrpEk+A2boueXts4iBVUFr9a1IQP1C3/+w5Q=;
        b=G5CLwVx41QKabTbUx5NJVdZjx5TBjUdLQt+lINVeWPzi4hLMf6Zo/0U4oXLo1L4a8M
         u/BuMHFCUn7d7Z/RXlCJEx0B80Kc0xfpV9PsdmdfiCb6UPFVGcdiL4iMLcgwEhIKu9PX
         lgna7Gkt7eCyeJtH89d1oB6lWMxGN44dSz5L1b9gOziOI9s7BNtpftO1DWQasL3rORHR
         H8o0IwIwD5bfMkZZD0BasvtnC5yiQXH7dn3JJzxMzOfZrGfYFB6sMyUMBQMTWzz1Yp2f
         lkFUkphRO4xvdHgUX+OZ21KTid/b0zLctNFzny8qYiS0XLSNfYzPGlTcd2GQU1dp2xRO
         SAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572287; x=1707177087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPF03DMZrpEk+A2boueXts4iBVUFr9a1IQP1C3/+w5Q=;
        b=mFQwXNwXsCe94dfzzcfJX4LDmlBzHZ/BIim1T9cteOIejq46oC6po84+bXopb84T2J
         zH3/b8y/QSW/RRNId3yOvyQkFrE/nCr0x/7i9B5bO+aU5vm4pjMy/LBTgQeUrbhmKeXB
         gIByG552Kve04kQcunJelC67/cEwg4xb30qcTP1iHeGDaro2oEMjQxO5BtJDMDLXIeAf
         LrQpZno6ny90JP5SrRLIVImAq0+EKKXJ/R90Wdnjmz4+noIaCQKRz8ghoQVIeO/DQL97
         kGnAaj2ksAhOpL2OoJBRyRK5xUQmUv8CXXLBHQo0SWu7FsbwHAqapxNfRYFJinQoTqmG
         ggmw==
X-Gm-Message-State: AOJu0YzI0HUdJ00ifUgSR/pGRhqOa7mQur4twoC+qOFwjmDRP8Gp4giP
	cwqP90Byco1363qo19caH2ahCnZ+x7w8ZGSmwQkZh9M9KzLgegXu/Yv7SBYpmULW2C+0gV7yaNJ
	TqvLA3A==
X-Google-Smtp-Source: AGHT+IGbBCWDH0aKd/gv8c6qcpv8SikUTBsEg/d3GiuUeQMe5vbA+yfGtKiAO36usD9RRvZnPhulxQ==
X-Received: by 2002:a2e:a378:0:b0:2cc:d4ae:c2ce with SMTP id i24-20020a2ea378000000b002ccd4aec2cemr4275692ljn.38.1706572287363;
        Mon, 29 Jan 2024 15:51:27 -0800 (PST)
Received: from localhost.localdomain ([195.245.241.170])
        by smtp.gmail.com with ESMTPSA id p16-20020a63e650000000b005d553239b16sm6647461pgj.20.2024.01.29.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:51:26 -0800 (PST)
From: Su Yue <glass.su@suse.com>
X-Google-Original-From: Su Yue <l@damenly.org>
To: fstests@vger.kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	l@damenly.org,
	bfoster@redhat.com,
	Su Yue <glass.su@suse.com>
Subject: [PATCH v4 1/2] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
Date: Tue, 30 Jan 2024 07:51:03 +0800
Message-ID: <20240129235104.8976-1-l@damenly.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Yue <glass.su@suse.com>

mkfs.bcachefs supports force overwrite when option '-f' is given:
$ mkfs.bcachefs --help | grep force
  -f, --force

There are some tests which call _scratch_mkfs multiple times
e.g. tests/generic/171. Without '-f' in MKFS_OPTIONS,
these tests just hang in overwrite confirmation.
After this commit, MKFS_BCACHEFS_PROG will contains ' -f' so
we don't have to add '-f' to MKFS_OPTIONS manually to make
these tests pass.

It also fixes generic/466 which unsets MKFS_OPTIONS causing
that test hangs in mfks.bcachefs waiting for confirmation of
the force overwrite.

Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
changelog:
v4:
    No change.
v3:
    Add Brian's Reviewed-by.
v2:
    Add more details about why MKFS_BCACHEFS_PROG should contain '-f'.
    
 common/config |  3 ++-
 common/rc     | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/common/config b/common/config
index c9771ff934cb..1f9edceec57a 100644
--- a/common/config
+++ b/common/config
@@ -105,7 +105,7 @@ set_mkfs_prog_path_with_opts()
 	# Note: mkfs.f2fs doesn't support the --help option yet, but it doesn't
 	# matter since it also prints the help when an invalid option is given.
 	if [ "$p" != "" ] && \
-		$p --help |& grep -q "[[:space:]]-f[[:space:]|]"; then
+		$p --help |& grep -q "[[:space:]]-f[[:space:]|,]"; then
 		echo "$p -f"
 	else
 		echo $p
@@ -313,6 +313,7 @@ export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
 export E2FSCK_PROG=$(type -P e2fsck)
 export TUNE2FS_PROG=$(type -P tune2fs)
 export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
+export MKFS_BCACHEFS_PROG=$(set_mkfs_prog_path_with_opts bcachefs)
 
 # SELinux adds extra xattrs which can mess up our expected output.
 # So, mount with a context, and they won't be created.
diff --git a/common/rc b/common/rc
index 524ffa02aa6a..31c21d2a8360 100644
--- a/common/rc
+++ b/common/rc
@@ -611,6 +611,9 @@ _test_mkfs()
     xfs)
 	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    bcachefs)
+    $MKFS_BCACHEFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -753,6 +756,10 @@ _scratch_mkfs()
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
 		;;
+    bcachefs)
+		mkfs_cmd="$MKFS_BCACHEFS_PROG"
+		mkfs_filter="cat"
+		;;
 	*)
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
@@ -1044,7 +1051,7 @@ _scratch_mkfs_sized()
 		export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
 		;;
 	bcachefs)
-		$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
+		$MKFS_BCACHEFS_PROG $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
 		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
@@ -1128,8 +1135,7 @@ _scratch_mkfs_blocksized()
 						-C $blocksize $SCRATCH_DEV
 		;;
 	bcachefs)
-		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize \
-								$SCRATCH_DEV
+		_scratch_mkfs --block_size=$blocksize
 		;;
 	udf)
 		_scratch_mkfs -b $blocksize
-- 
2.43.0

