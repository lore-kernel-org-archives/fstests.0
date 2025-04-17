Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BA1BBBD4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859537; cv=none; b=geVVrlRgmBt3LjzXJG107zInnuM9J5W7x99XMGdrYcpNSRAGfzyCiuCyN8oAVsiSO1ydwgNHrzRlB3GU9V8nfbmwEP+rtbjYX1F7C5GX3bWrkt2n6h46VoXFNa9fFR8Dt+PBAbFgB1TZH2egBISLCitHr7iHQQyYDA5YMFqmTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859537; c=relaxed/simple;
	bh=VJLz1F2baILgaQ3tcxoFOkHMtwUPiOQ98bG3BH4owzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftSMivwgNa/3nfRH3X83iH0Gb3w+jQc3j87D/UUcvTBI0JmgV28nQ5RU8qxxNaRGmwuRYQDKXD1l7C0RHbYOpGzY2bFTOcK9ZEkayVpLVSCwGT2/VEzNcT1PTtU417587i2Qa8tibfVB0FWRApCfqXFdKKbP86DyVLke6i13kYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CfLvUB0P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CfLvUB0P"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736bfa487c3so207434b3a.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859534; x=1745464334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekCTygUa+sBXB5CK222bi+0rZwTf3JmYIotRRdR5V1s=;
        b=CfLvUB0Pca64LZ5rqEGeLMHzHSntKP3/yJAxrW0B17WNq3lwh4aDDMpCUeb4wjsff9
         vdMLFw1UZHqbm8ge83rQjF1RlLEx6p4XmMXfGq2gLXLzA7k4+eDmk3ea/qxqxZ4vvwGC
         KzNJfJfU8AB/CvnuBFMPkUr4IH4U6+khTFkxcL/ev1FOsyaBrxtrQ6yY0rJJUMksMZoT
         I/5NAyhEdayT50GyCqgeSFmd/MgSXSRI1nObZGwSJy4WkL2zyL7pTC1HwdaO13RPMaHz
         UVYVUbSDBcJykwWacsznjsiyZoAyojJ9ffCI8pnGLdkZpCqpJ+uKXDFedtSOSLJdptO1
         TiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859534; x=1745464334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekCTygUa+sBXB5CK222bi+0rZwTf3JmYIotRRdR5V1s=;
        b=nlEr3JrI3gjG+jUJaeh4MPCXhj1kFI649TrJfdH2sarL6I3VOI1VJS2To38YcUR/w4
         2NyqUt2dWPw+2wsDlAx45FjZBYSITsb+U8SgGKX/nukcVaWSbZx6Ga472cAs1aIeoi0A
         XyC5j/CC1/i0B2aiOw9btEvZagzT1Sc3gvNkFJm8szN6yj9jdbn2+bFY7oCeFgN5bBPZ
         illh4J4Kh3biBec+Ux+7b7nTgUD+kspOJvKfDg+D20x1buB1Qxed83xey3jIiK6AOHyY
         MnSVomzkcZfa3pntq9DYFGan9FrrfGZBDSBJEaoF8//tk6aUST5XCy8kMSsrztV5xMYL
         Fyqw==
X-Gm-Message-State: AOJu0YzuiCYeriENx2EtOYcwf5zYZWSJoOIptjq358yHRvc2MAlcu+oU
	yPlQvqGQ4oCcAoKhOWP8xE3f+32Zf4OWnZm8B+oCrVqL1Ma/JRtzaPKMfn3WqCMM5vSHtERGUc0
	b
X-Gm-Gg: ASbGncsEkE0okAp06FefCyfE2dHVxYP3/jkDKxKYuBjQmrYlmGT08bP31eB/1gC4ut4
	VBJ1q3aCaGAItTyp9uSJ68d+ljjqn+32+eMC7j7QX354JXx2qHvUWqzOvLphLSvf53kGb5x375K
	+p+eJqKzIAjPnfAzX6FeR37ArCZpAiQVed3dHnWSsEiPZzg2KzeHpqaw1Cn9tjCg6QlogiqIQIq
	gIqfSzXxxu/unX+ufKGSjc7ydoow/M9G7a1D71RVeKjxnKnQeLa9JTmxXuP3lDLL2l1DmO/5eNQ
	VH7gXUk6ldERUYZ1UNOAQKLZock1t0m/I0WqGMfmRVzFN036sRnFXAiG8TBhoJIXihqzPxSLsaC
	B72LpEFf9LvVW
X-Google-Smtp-Source: AGHT+IH5981QQw6vY22SEHM+4UKD2tOobn8iOl2wdyjJhiB2GecGo+n2t+79KMichkfOJQT+P0eDdA==
X-Received: by 2002:a05:6a00:ac0b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-73c266ba584mr6319812b3a.4.1744859533668;
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e31dsm11535522b3a.141.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:12 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9t-0jRW;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEa-1afJ;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 09/28] check-parallel: allow FSTYP selection from the CLI
Date: Thu, 17 Apr 2025 13:00:50 +1000
Message-ID: <20250417031208.1852171-10-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Add a CLI option to specify the initial FSTYP to test. If this is
not specified the the default of "xfs" will be used. This option is
different to the way check has FSTYP specified as check-parallel
has no infrastructure to support non block device based filesystems
and hence we have to reject virtual or network based filesysetms
are this point in time.

Note: This patch only implements default mkfs parameter support for
the test device. Config sections can be used to override this as
check will then format the test device when the section that defines
non-default test device mkfs options is selected.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/check-parallel b/check-parallel
index 5fee62f37..19f2d2b0c 100755
--- a/check-parallel
+++ b/check-parallel
@@ -18,7 +18,7 @@ run_section=""
 
 tmp=/tmp/check-parallel.$$
 
-export FSTYP=xfs
+FSTYP=
 
 . ./common/exit
 . ./common/test_names
@@ -35,6 +35,7 @@ check options
     -r			randomize test order
     --exact-order	run tests in the exact order specified
     -s section		run only specified section from config file
+    -f <FSTYPE>		specify the filesystem type to test
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -66,16 +67,39 @@ external_file argument is a path to a single file containing a list of tests
 to exclude in the form of <test dir>/<test name>.
 
 examples:
- check-parallel -D /mnt xfs/001
- check-parallel -D /mnt -g quick
+ check-parallel -f xfs -D /mnt xfs/001
+ check-parallel -f ext4 -D /mnt -g quick
  check-parallel -D /mnt -g xfs/quick
  check-parallel -D /mnt -x stress xfs/*
- check-parallel -D /mnt -X .exclude -g auto
- check-parallel -D /mnt -E ~/.xfstests.exclude
+ check-parallel -f btrfs -D /mnt -X .exclude -g auto
+ check-parallel -f udf -D /mnt -E ~/.xfstests.exclude
 '
 	    exit 1
 }
 
+# Only support block device based filesystems with generic mkfs support
+# at the moment.
+is_supported_fstype()
+{
+	local fstype=$1
+
+	case $fstype in
+	xfs)		;;
+	ext2|ext3|ext4)	;;
+	udf)		;;
+	jfs)		;;
+	f2fs)		;;
+	btrfs)		;;
+	bcachefs)	;;
+	gfs2)		;;
+	ocfs2)		;;
+	*)
+		echo "unsupported FSTYPE: $fstype"
+		usage
+		;;
+	esac
+}
+
 # Process command arguments first.
 while [ $# -gt 0 ]; do
 	case "$1" in
@@ -92,6 +116,8 @@ while [ $# -gt 0 ]; do
 	--exact-order) _tl_setup_ordered ;;
 	-n)	show_test_list="yes" ;;
 
+	-f)	is_supported_fstype $2 ; FSTYP=$2; shift ;;
+
 	-s)	run_section="$run_section -s $2"; shift ;;
 
 	-*)	usage ;;
@@ -109,6 +135,8 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+export FSTYP=${FSTYP:=xfs}
+
 if [ ! -d "$basedir" ]; then
 	echo "Invalid basedir specification"
 	usage
@@ -225,8 +253,6 @@ runner_go()
 	xfs_io -f -c 'truncate 8g' $_scratch
 	xfs_io -f -c 'truncate 1g' $_logwrites
 
-	mkfs.xfs -f $_test > /dev/null 2>&1
-
 	export TEST_DEV=$(_create_loop_device $_test)
 	export TEST_DIR=$me/test
 	export SCRATCH_DEV=$(_create_loop_device $_scratch)
@@ -240,6 +266,10 @@ runner_go()
 	mkdir -p $RESULT_BASE
 	rm -f $RESULT_BASE/check.*
 
+	# Only supports default mkfs parameters right now
+	wipefs -a $TEST_DEV > /dev/null 2>&1
+	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV > /dev/null 2>&1
+
 #	export DUMP_CORRUPT_FS=1
 
 	# Run the tests in it's own mount namespace, as per the comment below
-- 
2.45.2

