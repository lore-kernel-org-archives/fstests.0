Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C44689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683570; cv=none; b=pqdB/BNQW4grrbfe0zCyCJt16WmisLEPGHLfKZws4Bfw1r+yyM8Rnc83FLaI5YJ61kPtwE5Peo3TV6WwbXhu/i4/KbS4+iBC9cxafmP/NOQiI4SbJ+riq9AqZoum53H1V6Md85jq5eBNNq3if7Y25GcLZFJE7Y9Q0WxuL9QgWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683570; c=relaxed/simple;
	bh=++7fozUmms/ppKTp63+6ZGXyROWVpqRR6H0bzZuHPxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS2ULPLU9N1HMI6NZCh3PXgY6E8EuoMG7kG/Uvw2ReRF03W7K3E38pLxnksqOvf5eyQO2sW+2ctLw7BxxOG2jPsbo9Qe2YPwPGjYZQBxamA5NkcEo2E9a94biZfLWoJ1P2y4izOIhIO7c0dM0XeItI9a7WVoTU8HJOS2G8jrX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Vrd7etST; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Vrd7etST"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f8b01bd40dso333542a12.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683569; x=1733288369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UEtav4jvo3xmiP8Wb5ihw9RJ6U2RCGLJkgCDkUUrHE=;
        b=Vrd7etST0vAyLDpTpFDfjhcgmUEcTFHyFW1BxhKYjii+9QDHeiqrbt/2RyoAnh7g/N
         kuIjelwz6IHBJuJB1wVX83S/C9wieb/JcFPWiAbz8t981HSa6NWSkIZrgaIeXKD/OwYz
         Rv7LqyaaZJNLEiy64hMh+fw4ueiGcgfL4rhQXZ0aiiWp4wGfFInOXgmDt9yVl1nXXJCK
         eLc4Fn3wgPpRbOF1I+iRaKTTy9fXwjok+4V4fRLup8HSqKbYFXqYxC7j8rdBFcfy68io
         r8Q0HdLAvyAmTQjw9BGYTwCuo+qpqzbTZiKUib+4+yG1U6NpUpzOpYn4hFxdM0EhCK5W
         vO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683569; x=1733288369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UEtav4jvo3xmiP8Wb5ihw9RJ6U2RCGLJkgCDkUUrHE=;
        b=uH2IAT6lXpPR/4GDSbo1AjirK12L7qlHPqTnlLEygLyUBfhKpXuDl5EY69eYvFE+Lu
         SxWNq4FZFCk9uuVkAjN+4GyG2MCUSeAJYishaMlhhz97YZUYBw5cU4eaFDjRY4zwHWSp
         DKUNmEzprXzhO9iKoKDI1IVI+vIAx5SG1e6i8OBKfM0he6F3CmXDTQ8kkCVyLSD+wwD3
         uG8kPrW+S00TU1hu0Wm0GR0K8PTr/oKlGUq9T8vu3EHj8N5wBBei/9peeGA0jgiiH2PQ
         2tiOTCGmaS0rULF4eO71IaNOA64phbIlLa9Kuz2+i4ligFQVxqled7A9Yh0glskc/MJX
         9vJw==
X-Gm-Message-State: AOJu0YzEUB24AfigWbuuCLyxV9F2gu5bnRVKGUyJ1YlXEGjNvVMDwMtO
	CvifEqot7t+/rzOETLPHnjllnaxq6cfk0zFwPlH59pZbESDKL2B4LHj4x8vQWCZJqOV/OLnOR+k
	b
X-Gm-Gg: ASbGncuyszFJFxSo32k9vRBVsr0e/2JFque8csRUKVNKRq+HHBA9KDh/7jFqwuRw0lU
	0ZrPwQ071jI4aUS8eyYFttR/fw9/ZfadSa4lWJqjrEEi4V7WKs3SzP+10C+iOtBc5m38p9B99Rg
	xOTuu4kEs4bZjIIBlTYuT2LyEHk+Rb6PDGekrAEXUtYb/rOS8piE9wJOsCa87JWiGzNb3MKRZw2
	Bbouz96T1NeIj8V3/V2iYUZCnhQDDSkvnjyW5L0xkZLEFVMscLk6J9ynq6hzcwYl6m4C3pa8ftZ
	IU6FGfcDHkXMYQ==
X-Google-Smtp-Source: AGHT+IFnPlbr21+IqC+3jBCGGtpxckZxH6dZnzsuvIZ549aO7+f6HEO00XJ2KavLlB9atttTrv8bDw==
X-Received: by 2002:a17:902:e549:b0:211:74be:c09b with SMTP id d9443c01a7336-214e6ec3d8amr91512515ad.12.1732683568819;
        Tue, 26 Nov 2024 20:59:28 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba60dfsm93734975ad.106.2024.11.26.20.59.28
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:28 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVk-3HJl
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfr-3tBo
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 30/40] fstests: don't use directory stacks
Date: Wed, 27 Nov 2024 15:52:00 +1100
Message-ID: <20241127045403.3665299-31-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Using bash directory stacking (pushd, popd, etc) seems to be
somewhat unreliable. I've been seeing occasional random failures
from both pushd and popd commands that cause the test to fail, and
there does not appear to be any reason for the failures occurring.

Rather than wasting time chasing ghosts, just get rid of the
directory stacking altogether.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/099 |  8 +++-----
 tests/generic/109 |  5 +----
 tests/generic/135 | 24 +++++++++++-------------
 tests/generic/707 |  7 ++++---
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/tests/generic/099 b/tests/generic/099
index c7d5932b6..980fd38f3 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -253,15 +253,13 @@ echo ""
 echo "=== Recursive change ACL ==="
 rm -fr root
 mkdir root
-pushd root >/dev/null
 # create an arbitrary little tree
-for i in 1 2 3 4 5 6 7 8 9 0
-do
+( cd root ; for i in 1 2 3 4 5 6 7 8 9 0; do
 	mkdir -p a/$i
 	mkdir -p b/c$i/$i
 	touch a/$i/mumble
-done
-popd >/dev/null
+done )
+
 chown -R 12345:54321 root
 echo "Change #1..."
 _runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
diff --git a/tests/generic/109 b/tests/generic/109
index 2b0b438cf..894e07167 100755
--- a/tests/generic/109
+++ b/tests/generic/109
@@ -54,10 +54,7 @@ _scratch_mount >> $seqres.full 2>&1
 # Test different directory sizes to test various directory formats
 for f in 1 2 3 4 5 8 12 18 27 40 60 90 135 202 303 454 681 1020 1530 2295; do
 	mkdir $SCRATCH_MNT/dir$f
-	pushd $SCRATCH_MNT/dir$f >/dev/null
-	filldir $f
-	renamedir
-	popd >/dev/null
+	( cd $SCRATCH_MNT/dir$f ; filldir $f ; renamedir )
 done
 
 status=0
diff --git a/tests/generic/135 b/tests/generic/135
index 30c52af72..cb9407fdf 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -21,30 +21,28 @@ _scratch_mount
 cd $SCRATCH_MNT
 
 # create file with async I/O
-$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x12 0 4k' async_file > /dev/null
+$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x12 0 4k' $SCRATCH_MNT/async_file > /dev/null
 
 # create file with sync I/O
-$XFS_IO_PROG -f -s -c 'pwrite -b 4k -S 0x34 0 4k' sync_file > /dev/null
+$XFS_IO_PROG -f -s -c 'pwrite -b 4k -S 0x34 0 4k' $SCRATCH_MNT/sync_file > /dev/null
 
 # create file with direct I/O
-$XFS_IO_PROG -f -d -c 'pwrite -b 4k -S 0x56 0 4k' direct_file > /dev/null
+$XFS_IO_PROG -f -d -c 'pwrite -b 4k -S 0x56 0 4k' $SCRATCH_MNT/direct_file > /dev/null
 
 # create file, truncate and then dirty again
-$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x78 0 4k' trunc_file > /dev/null
-$XFS_IO_PROG -f -c 'truncate 2k' trunc_file > /dev/null
-$XFS_IO_PROG -c 'pwrite 1k 0 1k' trunc_file > /dev/null
+$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x78 0 4k' $SCRATCH_MNT/trunc_file > /dev/null
+$XFS_IO_PROG -f -c 'truncate 2k' $SCRATCH_MNT/trunc_file > /dev/null
+$XFS_IO_PROG -c 'pwrite 1k 0 1k' $SCRATCH_MNT/trunc_file > /dev/null
 
-pushd / > /dev/null
 _scratch_cycle_mount
-popd > /dev/null
 
 # check file size and contents
-od -Ad -x async_file
-od -Ad -x sync_file
-od -Ad -x direct_file
-od -Ad -x trunc_file
+od -Ad -x $SCRATCH_MNT/async_file
+od -Ad -x $SCRATCH_MNT/sync_file
+od -Ad -x $SCRATCH_MNT/direct_file
+od -Ad -x $SCRATCH_MNT/trunc_file
 
-rm -f async_file sync_file direct_file trunc_file
+rm -f $SCRATCH_MNT/*
 
 status=0
 exit 
diff --git a/tests/generic/707 b/tests/generic/707
index fd02eacf9..3d8fac4bd 100755
--- a/tests/generic/707
+++ b/tests/generic/707
@@ -42,7 +42,7 @@ create_files()
 	# We use slightly longer file name to make directory grow faster and
 	# hopefully convert between various types
 	for (( i = 0; i < $files; i++ )); do
-		touch somewhatlongerfilename$i
+		echo -n > somewhatlongerfilename$i
 	done
 }
 
@@ -50,12 +50,13 @@ for (( i = 0; i <= $moves; i++ )); do
 	mkdir $SCRATCH_MNT/dir$i
 done
 
+start_dir=$PWD
 for (( l = 0; l < $loops; l++ )); do
 	mkdir $SCRATCH_MNT/dir0/dir
-	pushd $SCRATCH_MNT/dir0/dir &>/dev/null
+	cd $SCRATCH_MNT/dir0/dir
 	create_files &
 	BGPID=$!
-	popd &>/dev/null
+	cd $start_dir
 	for (( i = 0; i < $moves; i++ )); do
 		mv $SCRATCH_MNT/dir$i/dir $SCRATCH_MNT/dir$((i+1))/dir
 	done
-- 
2.45.2

