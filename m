Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA713C9D9
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683254; cv=none; b=QQZnB2TeW6dmXUm7z9pGqnHVOtmVpoLASb7fSE6vef4ekgFIrreUX+OZhAAraoOmf0o72tFfiJ5YXXrHbreqcNdtw20dxaJ1eCbiuf/VYeXlL2LeaprywvolZk9k+TDqpEdaLW3Wzc7lWWVsmjxGfLfwpPvRwGpwe+Bvm+kpqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683254; c=relaxed/simple;
	bh=yrbAeZcHGwxIKMaPxcPfrO0FmQ9blzj5ASMWZUlD4I4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDTtO+gbmw1RicEm8MgBoD/JPKfzxB/qnisiSdSRQKfCELZfJbtt+5lbNlBQ2od/PQ2yPGLWa4PvaWX4n2UbkKXTA7dnAnWKfMYab/5txEW141Px+vYbZgUrWDtPrHzn8eNM9MsAbZ5czdBrEUtZnYXH4KLl2DZkZBPZV1jowUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Judm8D7U; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Judm8D7U"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso118270a12.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683252; x=1733288052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CswRdGJcaZYprnG/h2H6fs0YhxASIvmhxSuPCYlDdEA=;
        b=Judm8D7UbmlR1izV/IfW5djHvi5yQ/QhEHyC1FpWy6MLuRomVsOxYu5H5dX0G3iE8k
         +et43j138uJr5cmhZUnemnWqd5KOhk5Udn7rkRtCMZPVxZoJINQd/nezWEt3Y9q/6v38
         vBv78TD2LOuTCT1iWYM3xn/a0JSvocnHp/8/y1PXYYDTbmhAQwbguaSL/j5Z2GGKT731
         56FqjDkNJUTF36j7FU1wxGOFF04SewXANdD0hMVXcTl3F/O7AMTg+g8fYlQkznsJ6R1S
         iYauftELuBJ24EsLuyal8cJGC/NvS7S21wMSPbCPH5PUcxzdWS9WTOXdGfvEca4TyqQ+
         rUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683252; x=1733288052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CswRdGJcaZYprnG/h2H6fs0YhxASIvmhxSuPCYlDdEA=;
        b=QE40Z/nmzx8mQOX5HDAwK0XLRVVSG5uYJGda8pa4bydi9mli3pcRg1oCZURRCoWW4a
         eDkRCka/fPFGP/k2qQfPZJUl54qMWbr569trJiJ6bCT/beV+yQqnkmN4nx2XcByj2P9p
         JiFBv7MAFg9WIDoGXAD4mK+yO4/IROlgeRtrxkC7z/0/YPt0917pSh8zcGIUIPWMqnG3
         6ot7olYjQAOLp6DXzd6tsH943OgUkkD5X3ZwDu4ZldIxxQMjEAU7F0qKol+8wADHIlQd
         JoDKKp9bcQE2fPloseOiDGAZ66QWiXM7dBAEv2uvc5t/H1XZtrUjGWT671nyCzvXU3Bl
         OMxg==
X-Gm-Message-State: AOJu0Yz8h3hC8dGn4b+Qgy39ZLElzEBnh3o1RdPF+TBFeAwYKJMfGufk
	XH8f4TxI/ValE/hb+OuVf0A2wPTu91tytlPZZDjl3EpIdj+tq4BiZ6KHp/g3uN5Tfkd2FNnbGVl
	M
X-Gm-Gg: ASbGncscWDrgKiP2p6w30bpk9N+i97bGrloiYLKuw1JPkRfEYCnZELefGUQE2cEgb22
	H0S8Jxp4ruMZsja3gKPx3tT8wdrftN+V/wYeAyvsUuCDNgX+1o0rN08dRQCsRkLXb+QMYk5sZ8+
	MobDxXFXRsazwCGZzDR+c+pzED3qjgPl4EGgUuDu/W5Wf9mP31nLpmMunsBSAG4qDdPYrfn5gOW
	OOBsn2+0XToMiikdci9T8f4btB9UNdxF28CFr9rMDmzEVh8NaSxnU+6rMm4GMAbqFDF4OxC8rHS
	8p/GBeCxsf6Cvsmsu2oTh2uN
X-Google-Smtp-Source: AGHT+IF+yiBf+KY92XTiquQIWXrvI7Imo38lgwFEKL44UxZQV5obnMinCVontUvcVxlsq2RkQHu5+Q==
X-Received: by 2002:a05:6a21:32a5:b0:1cf:651c:52f1 with SMTP id adf61e73a8af0-1e0d664eb46mr9777657637.0.1732683252210;
        Tue, 26 Nov 2024 20:54:12 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3fae30sm9648906a12.76.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZU9-3UVS
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3w-0000000FQdp-42dq
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 05/40] fstests: per-test dmerror instances
Date: Wed, 27 Nov 2024 15:51:35 +1100
Message-ID: <20241127045403.3665299-6-david@fromorbit.com>
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

We can't run two tests that use dmerror at the same time because
the device name is the same. hence they interfere with each other.
Give dmerror devices their own per-test names to avoid this
problem.

Note that we need a hack to pass the test sequence number through
to src/dmerror as used by generic/441 so that it can construct the
dmerror name correctly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmerror    | 70 +++++++++++++++++++++++++----------------------
 src/dmerror       |  6 +++-
 tests/generic/441 |  2 +-
 3 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/common/dmerror b/common/dmerror
index 3494b6dd3..97796b38e 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -4,6 +4,10 @@
 #
 # common functions for setting up and tearing down a dmerror device
 
+export DMERROR_NAME="error-test.$seq"
+export DMERROR_RTNAME="error-rttest.$seq"
+export DMERROR_LOGNAME="error-logtest.$seq"
+
 _dmerror_setup_vars()
 {
 	local backing_dev="$1"
@@ -31,7 +35,7 @@ _dmerror_setup()
 	done
 
 	# Scratch device
-	export DMERROR_DEV='/dev/mapper/error-test'
+	export DMERROR_DEV="/dev/mapper/$DMERROR_NAME"
 	_dmerror_setup_vars $SCRATCH_DEV
 
 	# Realtime device.  We reassign SCRATCH_RTDEV so that all the scratch
@@ -41,7 +45,7 @@ _dmerror_setup()
 			# Set up the device switch
 			local dm_backing_dev=$SCRATCH_RTDEV
 			export NON_ERROR_RTDEV="$SCRATCH_RTDEV"
-			SCRATCH_RTDEV='/dev/mapper/error-rttest'
+			SCRATCH_RTDEV="/dev/mapper/$DMERROR_RTNAME"
 		else
 			# Already set up; recreate tables
 			local dm_backing_dev="$NON_ERROR_RTDEV"
@@ -57,7 +61,7 @@ _dmerror_setup()
 			# Set up the device switch
 			local dm_backing_dev=$SCRATCH_LOGDEV
 			export NON_ERROR_LOGDEV="$SCRATCH_LOGDEV"
-			SCRATCH_LOGDEV='/dev/mapper/error-logtest'
+			SCRATCH_LOGDEV="/dev/mapper/$DMERROR_LOGNAME"
 		else
 			# Already set up; recreate tables
 			local dm_backing_dev="$NON_ERROR_LOGDEV"
@@ -71,19 +75,19 @@ _dmerror_init()
 {
 	_dmerror_setup "$@"
 
-	_dmsetup_remove error-test
-	_dmsetup_create error-test --table "$DMLINEAR_TABLE" || \
+	_dmsetup_remove $DMERROR_NAME
+	_dmsetup_create $DMERROR_NAME --table "$DMLINEAR_TABLE" || \
 		_fatal "failed to create dm linear device"
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		_dmsetup_remove error-rttest
-		_dmsetup_create error-rttest --table "$DMLINEAR_RTTABLE" || \
+		_dmsetup_remove $DMERROR_RTNAME
+		_dmsetup_create $DMERROR_RTNAME --table "$DMLINEAR_RTTABLE" || \
 			_fatal "failed to create dm linear rt device"
 	fi
 
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		_dmsetup_remove error-logtest
-		_dmsetup_create error-logtest --table "$DMLINEAR_LOGTABLE" || \
+		_dmsetup_remove $DMERROR_LOGNAME
+		_dmsetup_create $DMERROR_LOGNAME --table "$DMLINEAR_LOGTABLE" || \
 			_fatal "failed to create dm linear log device"
 	fi
 }
@@ -102,15 +106,15 @@ _dmerror_unmount()
 
 _dmerror_cleanup()
 {
-	test -n "$NON_ERROR_LOGDEV" && $DMSETUP_PROG resume error-logtest &>/dev/null
-	test -n "$NON_ERROR_RTDEV" && $DMSETUP_PROG resume error-rttest &>/dev/null
-	$DMSETUP_PROG resume error-test > /dev/null 2>&1
+	test -n "$NON_ERROR_LOGDEV" && $DMSETUP_PROG resume $DMERROR_LOGNAME &>/dev/null
+	test -n "$NON_ERROR_RTDEV" && $DMSETUP_PROG resume $DMERROR_RTNAME &>/dev/null
+	$DMSETUP_PROG resume $DMERROR_NAME > /dev/null 2>&1
 
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
 
-	test -n "$NON_ERROR_LOGDEV" && _dmsetup_remove error-logtest
-	test -n "$NON_ERROR_RTDEV" && _dmsetup_remove error-rttest
-	_dmsetup_remove error-test
+	test -n "$NON_ERROR_LOGDEV" && _dmsetup_remove $DMERROR_LOGNAME
+	test -n "$NON_ERROR_RTDEV" && _dmsetup_remove $DMERROR_RTNAME
+	_dmsetup_remove $DMERROR_NAME
 
 	unset DMERROR_DEV DMLINEAR_TABLE DMERROR_TABLE
 
@@ -145,45 +149,45 @@ _dmerror_load_error_table()
 	# Suspend the scratch device before the log and realtime devices so
 	# that the kernel can freeze and flush the filesystem if the caller
 	# wanted a freeze.
-	$DMSETUP_PROG suspend $suspend_opt error-test
+	$DMSETUP_PROG suspend $suspend_opt $DMERROR_NAME
 	[ $? -ne 0 ] && _fail  "dmsetup suspend failed"
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		$DMSETUP_PROG suspend $suspend_opt error-rttest
+		$DMSETUP_PROG suspend $suspend_opt $DMERROR_RTNAME
 		[ $? -ne 0 ] && _fail "failed to suspend error-rttest"
 	fi
 
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		$DMSETUP_PROG suspend $suspend_opt error-logtest
+		$DMSETUP_PROG suspend $suspend_opt $DMERROR_LOGNAME
 		[ $? -ne 0 ] && _fail "failed to suspend error-logtest"
 	fi
 
 	# Load new table
-	$DMSETUP_PROG load error-test --table "$DMERROR_TABLE"
+	$DMSETUP_PROG load $DMERROR_NAME --table "$DMERROR_TABLE"
 	load_res=$?
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		$DMSETUP_PROG load error-rttest --table "$DMERROR_RTTABLE"
+		$DMSETUP_PROG load $DMERROR_RTNAME --table "$DMERROR_RTTABLE"
 		[ $? -ne 0 ] && _fail "failed to load error table into error-rttest"
 	fi
 
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		$DMSETUP_PROG load error-logtest --table "$DMERROR_LOGTABLE"
+		$DMSETUP_PROG load $DMERROR_LOGNAME --table "$DMERROR_LOGTABLE"
 		[ $? -ne 0 ] && _fail "failed to load error table into error-logtest"
 	fi
 
 	# Resume devices in the opposite order that we suspended them.
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		$DMSETUP_PROG resume error-logtest
+		$DMSETUP_PROG resume $DMERROR_LOGNAME
 		[ $? -ne 0 ] && _fail  "failed to resume error-logtest"
 	fi
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		$DMSETUP_PROG resume error-rttest
+		$DMSETUP_PROG resume $DMERROR_RTNAME
 		[ $? -ne 0 ] && _fail  "failed to resume error-rttest"
 	fi
 
-	$DMSETUP_PROG resume error-test
+	$DMSETUP_PROG resume $DMERROR_NAME
 	resume_res=$?
 
 	[ $load_res -ne 0 ] && _fail "dmsetup failed to load error table"
@@ -206,45 +210,45 @@ _dmerror_load_working_table()
 	# Suspend the scratch device before the log and realtime devices so
 	# that the kernel can freeze and flush the filesystem if the caller
 	# wanted a freeze.
-	$DMSETUP_PROG suspend $suspend_opt error-test
+	$DMSETUP_PROG suspend $suspend_opt $DMERROR_NAME
 	[ $? -ne 0 ] && _fail  "dmsetup suspend failed"
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		$DMSETUP_PROG suspend $suspend_opt error-rttest
+		$DMSETUP_PROG suspend $suspend_opt $DMERROR_RTNAME
 		[ $? -ne 0 ] && _fail "failed to suspend error-rttest"
 	fi
 
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		$DMSETUP_PROG suspend $suspend_opt error-logtest
+		$DMSETUP_PROG suspend $suspend_opt $DMERROR_LOGNAME
 		[ $? -ne 0 ] && _fail "failed to suspend error-logtest"
 	fi
 
 	# Load new table
-	$DMSETUP_PROG load error-test --table "$DMLINEAR_TABLE"
+	$DMSETUP_PROG load $DMERROR_NAME --table "$DMLINEAR_TABLE"
 	load_res=$?
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		$DMSETUP_PROG load error-rttest --table "$DMLINEAR_RTTABLE"
+		$DMSETUP_PROG load $DMERROR_RTNAME --table "$DMLINEAR_RTTABLE"
 		[ $? -ne 0 ] && _fail "failed to load working table into error-rttest"
 	fi
 
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		$DMSETUP_PROG load error-logtest --table "$DMLINEAR_LOGTABLE"
+		$DMSETUP_PROG load $DMERROR_LOGNAME --table "$DMLINEAR_LOGTABLE"
 		[ $? -ne 0 ] && _fail "failed to load working table into error-logtest"
 	fi
 
 	# Resume devices in the opposite order that we suspended them.
 	if [ -n "$NON_ERROR_LOGDEV" ]; then
-		$DMSETUP_PROG resume error-logtest
+		$DMSETUP_PROG resume $DMERROR_LOGNAME
 		[ $? -ne 0 ] && _fail  "failed to resume error-logtest"
 	fi
 
 	if [ -n "$NON_ERROR_RTDEV" ]; then
-		$DMSETUP_PROG resume error-rttest
+		$DMSETUP_PROG resume $DMERROR_RTNAME
 		[ $? -ne 0 ] && _fail  "failed to resume error-rttest"
 	fi
 
-	$DMSETUP_PROG resume error-test
+	$DMSETUP_PROG resume $DMERROR_NAME
 	resume_res=$?
 
 	[ $load_res -ne 0 ] && _fail "dmsetup failed to load error table"
diff --git a/src/dmerror b/src/dmerror
index cde2b4284..96611b101 100755
--- a/src/dmerror
+++ b/src/dmerror
@@ -2,6 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017, Jeff Layton <jlayton@redhat.com>
 
+# hackity hack hack - first arg is the test number, second arg is op.
+# This is needed so that dmerror names the dm dev correctly.
+seq=$1
+
 . ./common/config
 . ./common/dmerror
 
@@ -10,7 +14,7 @@ if [ -z "$DMERROR_DEV" ]; then
 	exit 1
 fi
 
-case $1 in
+case $2 in
 load_error_table)
 	_dmerror_load_error_table
 	;;
diff --git a/tests/generic/441 b/tests/generic/441
index 9851ac219..6b48fc9ed 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -59,7 +59,7 @@ _require_fs_space $SCRATCH_MNT 65536
 testfile=$SCRATCH_MNT/fsync-err-test
 
 echo "$here/src/fsync-err $sflag -d $here/src/dmerror $testfile" >> $seqres.full
-$here/src/fsync-err $sflag -d $here/src/dmerror $testfile
+$here/src/fsync-err $sflag -d "$here/src/dmerror $seq" $testfile
 
 # success, all done
 _dmerror_load_working_table
-- 
2.45.2

