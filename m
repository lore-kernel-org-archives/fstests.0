Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019A82D66
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683251; cv=none; b=s8Y7ar43xoduskniiaFg6BE3kJ/MlzGf+UZpcTpY8xgLdpzEjiBsiPlRyXA/eO9rvdnqiBit0WNaN5I1wWoL1yV+yn9p7matgwFMYonmFzz6D84uM9RdjQU86Xy3ICWyF94js0xy42T4fmlTD+/53ye3IaQ6ftaCJCoA5GIw2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683251; c=relaxed/simple;
	bh=Hod13QZkImKDJX7MYTYn/s7zXtiIaGjSn6BfU7wMwwM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbiGkkkOxg7JevWXP+sq5etH6dDp6s/YPEZzkuONZ93zOuunKYh9vdmM1lFlrJEEzDVbIpOnVrUHBJ3LKLNuVzDZOHGKQa25joMXKTt0eM2MX+yLoV+bytD5AEdheOezBipqu+tf7tYTal7xfO2EvvVk2rHasePpEnmBBfTbCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=rRHxuZqx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rRHxuZqx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea6d689d22so5000367a91.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683249; x=1733288049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiBK6qpVXJRXgGlUJIO5e/7E7v+qgDlPAlQ4WFGhHD8=;
        b=rRHxuZqxY4ijhLq+zgKyonIKpQdRV8LSzi7gDy+DZ5BbymlFdONazjW/rSj9TkIUJX
         rz7eX8LeK8BjEVUugJF5Gvlg2O0kq2vr7hGN6mFbs8lfnCi1Ina2JOUOl6L4JLurG7Ah
         BvF/lorIC1P6wJEgBQOUKB2Sen0bjjKRKfocYFpeN0wVVs8I7Z6+V7sJViqSDb1cEqiN
         ZUF6pKICHOceF5+sTvXckfwd7ZhntQYQVmUxI3agFZ0gvDIjgb0JDhik4YjHok2Uttx5
         CUttUf44QNxXDgfVn+UDz9/wrzKUOB3ibExTPOa5voEAgVrSlKAZEZ2g7t6Udo6Rjyer
         Djuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683249; x=1733288049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiBK6qpVXJRXgGlUJIO5e/7E7v+qgDlPAlQ4WFGhHD8=;
        b=ZRnPXRFysjmHRHQEhimvH7AC7glOV124MyjjSiToKWsuHdg+wN43ev9nAzrl3pGv16
         PcyfU04SgSxgEQAyp/IoGPKpHo5Z4b8mH31T8limlJH2MMzVnfAuOF1JRv8kPw4Th6XG
         vxweGWbB7ekpLrNn3AYYxGwrKXQZfBi3pzbe7I10HFBJWi7qqQ5DBM69k7+RMqf+Fsab
         QXlxMdHCwM0vGDSvRzGfSsjTBbRv71JJbOHSBvjU48T3cyGB5WW8EkM5qxhUgATddEha
         ZJcR+otrzMDQ2he5NA+H1/Z87EqZj991dpURYFXCmgv3X3/eKCQZbD8P7JccsBPsmZTZ
         01ew==
X-Gm-Message-State: AOJu0YyOP5bGSuip55EOVx6ywtHSMlklLClroK4yk1exY4uZDz/F4u5e
	Rq0AFpuNQoGlz4r6pHvdPTdW84Kz4D1FJ2qDAIVBoQ5RWM9CtMJ61/tpwl9YNFO8cbrfRPXsJN2
	j
X-Gm-Gg: ASbGncs3UFG4Z34JfZLE75IfULBx08EU5bFGASq/2T10dObXWgNJzGpnFq5JqW+zp5a
	miKoZ2OZOFYkK3tGV5jjf1muP84QeJqQSvtureB+CTzjP5K11Qyq+QYotg4mTcgaYZ4kUaXUMH8
	KTvGs34vKqeQOmtQTzVboSlNxvbSwIN8oMWZyFFxs5Fi/H1zAfBkM9oRcAMNKaks0Ump9M2K2B/
	H1CCXQXz9tX90d2xiXXmD05a/9aA9g2p4jeO8ARb64OSDepoTAxRYpbihGaJENf1EoKmmJWhHy7
	SGi4X49yvR3UyKRVq3CUDP82
X-Google-Smtp-Source: AGHT+IEzQoqPKnbcJLKpsqPuRN5h8PLn0X7i9yge39xjgGn55toG1TvhN277nn2G7Y/ICXugFnHD3w==
X-Received: by 2002:a17:90b:3847:b0:2ea:6f19:1804 with SMTP id 98e67ed59e1d1-2ee097bd204mr2095831a91.25.1732683249170;
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03b1sm486134a91.35.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:07 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZU5-3IDH
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3w-0000000FQdk-3q7j
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 04/40] fstests: per-test dmflakey instances
Date: Wed, 27 Nov 2024 15:51:34 +1100
Message-ID: <20241127045403.3665299-5-david@fromorbit.com>
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

We can't run two tests that use dmflakey at the same time because
the device name is the same. hence they interfere with each other.
Given dmflakey devices their own per-test names to avoid this
problem.

Also, drop_and_remount is about to fail the fs during unmount, so
ensure the filesystem is going to fail the IO during unmount rather
than retrying forever.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmflakey | 56 ++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/common/dmflakey b/common/dmflakey
index 52da3b100..75a0a67c8 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -8,15 +8,19 @@ FLAKEY_ALLOW_WRITES=0
 FLAKEY_DROP_WRITES=1
 FLAKEY_ERROR_WRITES=2
 
+export FLAKEY_NAME="flakey-test.$seq"
+export FLAKEY_RTNAME="flakey-rttest.$seq"
+export FLAKEY_LOGNAME="flakey-logtest.$seq"
+
 _init_flakey()
 {
 	# Scratch device
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
-	FLAKEY_DEV=/dev/mapper/flakey-test
+	export FLAKEY_DEV="/dev/mapper/$FLAKEY_NAME"
 	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
 	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
 	FLAKEY_TABLE_ERROR="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 error_writes"
-	_dmsetup_create flakey-test --table "$FLAKEY_TABLE" || \
+	_dmsetup_create $FLAKEY_NAME --table "$FLAKEY_TABLE" || \
 		_fatal "failed to create flakey device"
 
 	# Realtime device
@@ -25,7 +29,7 @@ _init_flakey()
 			# Set up the device switch
 			local backing_dev="$SCRATCH_RTDEV"
 			export NON_FLAKEY_RTDEV="$SCRATCH_RTDEV"
-			SCRATCH_RTDEV=/dev/mapper/flakey-rttest
+			SCRATCH_RTDEV=/dev/mapper/$FLAKEY_RTNAME
 		else
 			# Already set up; recreate tables
 			local backing_dev="$NON_FLAKEY_RTDEV"
@@ -34,7 +38,7 @@ _init_flakey()
 		FLAKEY_RTTABLE="0 $BLK_DEV_SIZE flakey $backing_dev 0 180 0"
 		FLAKEY_RTTABLE_DROP="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 drop_writes"
 		FLAKEY_RTTABLE_ERROR="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 error_writes"
-		_dmsetup_create flakey-rttest --table "$FLAKEY_RTTABLE" || \
+		_dmsetup_create $FLAKEY_RTNAME --table "$FLAKEY_RTTABLE" || \
 			_fatal "failed to create flakey rt device"
 	fi
 
@@ -44,7 +48,7 @@ _init_flakey()
 			# Set up the device switch
 			local backing_dev="$SCRATCH_LOGDEV"
 			export NON_FLAKEY_LOGDEV="$SCRATCH_LOGDEV"
-			SCRATCH_LOGDEV=/dev/mapper/flakey-logtest
+			SCRATCH_LOGDEV=/dev/mapper/$FLAKEY_LOGNAME
 		else
 			# Already set up; recreate tables
 			local backing_dev="$NON_FLAKEY_LOGDEV"
@@ -53,7 +57,7 @@ _init_flakey()
 		FLAKEY_LOGTABLE="0 $BLK_DEV_SIZE flakey $backing_dev 0 180 0"
 		FLAKEY_LOGTABLE_DROP="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 drop_writes"
 		FLAKEY_LOGTABLE_ERROR="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 error_writes"
-		_dmsetup_create flakey-logtest --table "$FLAKEY_LOGTABLE" || \
+		_dmsetup_create $FLAKEY_LOGNAME --table "$FLAKEY_LOGTABLE" || \
 			_fatal "failed to create flakey log device"
 	fi
 }
@@ -74,15 +78,15 @@ _cleanup_flakey()
 {
 	# If dmsetup load fails then we need to make sure to do resume here
 	# otherwise the umount will hang
-	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume flakey-logtest &> /dev/null
-	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume flakey-rttest &> /dev/null
+	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
+	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null
 	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
 
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
 
-	_dmsetup_remove flakey-test
-	test -n "$NON_FLAKEY_LOGDEV" && _dmsetup_remove flakey-logtest
-	test -n "$NON_FLAKEY_RTDEV" && _dmsetup_remove flakey-rttest
+	_dmsetup_remove $FLAKEY_NAME
+	test -n "$NON_FLAKEY_LOGDEV" && _dmsetup_remove $FLAKEY_LOGNAME
+	test -n "$NON_FLAKEY_RTDEV" && _dmsetup_remove $FLAKEY_RTNAME
 
 	if [ -n "$NON_FLAKEY_LOGDEV" ]; then
 		SCRATCH_LOGDEV="$NON_FLAKEY_LOGDEV"
@@ -125,54 +129,58 @@ _load_flakey_table()
 	# Suspend the scratch device before the log and realtime devices so
 	# that the kernel can freeze and flush the filesystem if the caller
 	# wanted a freeze.
-	$DMSETUP_PROG suspend $suspend_opt flakey-test
-	[ $? -ne 0 ] && _fatal "failed to suspend flakey-test"
+	$DMSETUP_PROG suspend $suspend_opt $FLAKEY_NAME
+	[ $? -ne 0 ] && _fatal "failed to suspend $FLAKEY_NAME"
 
 	if [ -n "$NON_FLAKEY_RTDEV" ]; then
-		$DMSETUP_PROG suspend $suspend_opt flakey-rttest
+		$DMSETUP_PROG suspend $suspend_opt $FLAKEY_RTNAME
 		[ $? -ne 0 ] && _fatal "failed to suspend flakey-rttest"
 	fi
 
 	if [ -n "$NON_FLAKEY_LOGDEV" ]; then
-		$DMSETUP_PROG suspend $suspend_opt flakey-logtest
+		$DMSETUP_PROG suspend $suspend_opt $FLAKEY_LOGNAME
 		[ $? -ne 0 ] && _fatal "failed to suspend flakey-logtest"
 	fi
 
 	# There may be multiple dm targets in the table, and these dm targets
 	# will be joined by the newline ("\n"). Option --table can not cope with
 	# the multiple-targets case, so get them by reading from standard input.
-	echo -e "$table" | $DMSETUP_PROG load flakey-test
-	[ $? -ne 0 ] && _fatal "failed to load table into flakey-test"
+	echo -e "$table" | $DMSETUP_PROG load $FLAKEY_NAME
+	[ $? -ne 0 ] && _fatal "failed to load table into $FLAKEY_NAME"
 
 	if [ -n "$NON_FLAKEY_RTDEV" ]; then
-		echo -e "$rttable" | $DMSETUP_PROG load flakey-rttest
+		echo -e "$rttable" | $DMSETUP_PROG load $FLAKEY_RTNAME
 		[ $? -ne 0 ] && _fatal "failed to load table into flakey-rttest"
 	fi
 
 	if [ -n "$NON_FLAKEY_LOGDEV" ]; then
-		echo -e "$logtable" | $DMSETUP_PROG load flakey-logtest
+		echo -e "$logtable" | $DMSETUP_PROG load $FLAKEY_LOGNAME
 		[ $? -ne 0 ] && _fatal "failed to load table into flakey-logtest"
 	fi
 
 	# Resume devices in the opposite order that we suspended them.
 	if [ -n "$NON_FLAKEY_LOGDEV" ]; then
-		$DMSETUP_PROG resume flakey-logtest
+		$DMSETUP_PROG resume $FLAKEY_LOGNAME
 		[ $? -ne 0 ] && _fatal  "failed to resume flakey-logtest"
 	fi
 
 	if [ -n "$NON_FLAKEY_RTDEV" ]; then
-		$DMSETUP_PROG resume flakey-rttest
+		$DMSETUP_PROG resume $FLAKEY_RTNAME
 		[ $? -ne 0 ] && _fatal  "failed to resume flakey-rttest"
 	fi
 
-	$DMSETUP_PROG resume flakey-test
-	[ $? -ne 0 ] && _fatal  "failed to resume flakey-test"
+	$DMSETUP_PROG resume $FLAKEY_NAME
+	[ $? -ne 0 ] && _fatal  "failed to resume $FLAKEY_NAME"
 }
 
 # Silently drop all writes and unmount/remount to simulate a crash/power
 # failure.
 _flakey_drop_and_remount()
 {
+	# If the full environment is set up, configure ourselves for shutdown
+	type _prepare_for_eio_shutdown &>/dev/null && \
+		_prepare_for_eio_shutdown $FLAKEY_DEV
+
 	_load_flakey_table $FLAKEY_DROP_WRITES
 	_unmount_flakey
 
@@ -188,7 +196,7 @@ _require_flakey_with_error_writes()
 {
 	local SIZE
 	local TABLE
-	local NAME=flakey-test
+	local NAME=$FLAKEY_NAME
 
 	_require_dm_target flakey
 
-- 
2.45.2

