Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261AEA41
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683612; cv=none; b=sJbdTePC8DyB80wZWIEAWNjx/ck9krnc64iM/N5ZfDUpaLAXo4+wsazNb1nNQrpQsw8OS9HIiXH4Wm/A4541VEFrG9Vw46fgGaKeKrNVQKevZhuClrEvWtyjSpDJJ1OSuffEjHpc4c9OUaM5cjnFB3WqYfSVmqiI34VsfS7568M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683612; c=relaxed/simple;
	bh=lRFeb6yMAsD9VkPpbgKeBOkdSn5In1X0XHihMeFqH+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlvKUr0V0/tnc+sgVDDqkVca3oOqyAVN0x+dyD9ifGplp4dJcW22UHw5bC3bXZP23yIPlE+Z/EHEXP7Kr0PLg8rY7bpmCMNU5ZHQfLUzT1Ei24QnvSA1eeCx9h5WNpXnz/IX+jGbpMSS475fULCE5vI/eB2au0V6YCcxKQehOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WHdejhpR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WHdejhpR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so5071435a12.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 21:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683610; x=1733288410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsQlWwV60sL+2ry2al+hCZ3ERzMnFh7RVOrbXT0yeSY=;
        b=WHdejhpR6Nc7aRp2y8ksmJ9d6104mj68rZ0mVZmpIBzjohh7q4oqsDIHQCYKHKlVd9
         SdRe0LoVNrad3/3AiGQBrlHP1My9Tzpnqfm9CTxvwVYjqmnHk+S/mhaF7F5vM0rdXuV7
         U9cHPAaRtrIXEAvnf/G5bMIuw/CpLLAiSv5ga/iDioCzXrwK+eLNFL7+RZqYZOiu2W9n
         kFZXl1LTQXxsGnDVuxywkZXkmtRdpp9ngqNAoQ2CW8RLKZsUG94VTEwS0I8zxhBQNtqN
         2YwMXmDVGlQobP02ansRS5qwSUbpyl4pj5/sySStQJFicFfMwAfzVl+VxiBQQZLjKjMo
         Zfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683610; x=1733288410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsQlWwV60sL+2ry2al+hCZ3ERzMnFh7RVOrbXT0yeSY=;
        b=oRTaxQNiJDldSgInH6ZfnPRJ2MFTp+yv7kMZdHc8JQLMZeDbJiuMdK5CWiGRKZ63l1
         22nK7A655POSNtbPfSH10APKCDEp1Q1cpndJ1FU13TggohrpJmwFS0dCbquZyTKM2+4Y
         Bggv41LDLOMMmR5/CuOldSiTZE+pfca9xMZzxWTkO8/qj3SY+dGgGWaHoP8t6jWMdMNx
         6Wp97NmEwP9buEvLdUBRtXbfxuqSHjEgh47EKLIH9cDFymgsduuQo52Vr0CyTvSj0y5w
         O7nE24pXBFsjsLsb3QhTV5cPPwe37psg4l6qj7Q1MPaCexcnpOQQOhkRGBMG0AWgtL3o
         fZ0g==
X-Gm-Message-State: AOJu0YwvdK0wsvP12oRwND+x4v4Pr0VU50YkEwIwng4zoCNpXTL1FFfD
	PndGMVIg6Lnsmh4lgRw2NeqMWE3hnz2GQeiB0rqMNZFfOcw5sJDHtn/c0ucobuYNivDoUFxXo/u
	m
X-Gm-Gg: ASbGncvVnlAo3vrBBYahTq0XUZyyrhnvc/5noVo1B1+k7NVzVx9epQ+opB2I9jQM3yN
	WOrzSPlM6TCAOa847OLYb+h3u1YOt2gSORTvzYjZWCGcN+W9CWJgP7OvsOeQXgzSpbZLzR+fF5u
	o8t4351zUjs32V/img4Dvy2n26RX8Qa74V1/h1Dor9SuwGSrqe1KChQtn0T45e0OchnkHsRLI4I
	UN/pUa79+yC0xUX54NgXkXzaI2ez08t672DWRMUB/HSl8etWj2DNTvkNKGCm8J76YdMZtpCMMjR
	Ttcy+XqZv135tQ==
X-Google-Smtp-Source: AGHT+IHTPhccw4nb+Qbgk5kxZD1BfVCJeE0nTSlyjzeFxXjqM8731GkPzdr3XI15bXfGJPm6TlWrTA==
X-Received: by 2002:a05:6a21:3989:b0:1db:a33e:2c6 with SMTP id adf61e73a8af0-1e0e0b206dfmr3689969637.18.1732683610511;
        Tue, 26 Nov 2024 21:00:10 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de573d37sm9277655b3a.174.2024.11.26.21.00.10
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:00:10 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVt-3cK8
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQg2-4ArB
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 32/40] fstests: clean up termination of various tests
Date: Wed, 27 Nov 2024 15:52:02 +1100
Message-ID: <20241127045403.3665299-33-david@fromorbit.com>
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

Accumulated minor fixes to improve reliablity of the termination
of various tests when interrupted.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/084 | 12 +++++++++---
 tests/generic/464 | 10 +++++-----
 tests/generic/650 |  8 ++++----
 tests/xfs/013     |  1 +
 tests/xfs/558     |  1 +
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tests/generic/084 b/tests/generic/084
index 137ba23cf..fe758f118 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -12,6 +12,15 @@
 . ./common/preamble
 _begin_fstest auto metadata quick
 
+_cleanup()
+{
+	[ -n "$link_pids" ] && kill $link_pids
+	[ -n "$open_pid" ] && kill $open_pid
+	wait
+	cd /
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -57,9 +66,6 @@ done &
 sleep 5
 kill $! >/dev/null 2>&1
 
-kill $open_pid $link_pids >/dev/null 2>&1
-wait $open_pid $link_pids
-
 # all done, no oops/hang expected, _check_filesystems checks SCRATCH_DEV after test
 status=0
 exit
diff --git a/tests/generic/464 b/tests/generic/464
index f114208f9..ebf475094 100755
--- a/tests/generic/464
+++ b/tests/generic/464
@@ -66,22 +66,22 @@ _scratch_mount
 # for each operation and runs for $LOOP_TIME seconds, and check filesystem
 # consistency after each iteration
 for i in `seq 1 $LOOP_CNT`; do
-	rm -f $stop
+	touch $stop
 	for j in `seq 1 $PROC_CNT`; do
-		while [ ! -e $stop ]; do
+		while [ -e $stop ]; do
 			do_write
 		done &
 
-		while [ ! -e $stop ]; do
+		while [ -e $stop ]; do
 			do_append
 		done &
 
-		while [ ! -e $stop ]; do
+		while [ -e $stop ]; do
 			do_writeback
 		done &
 	done
 	sleep $LOOP_TIME
-	touch $stop
+	rm -f $stop
 	wait
 
 	_scratch_unmount
diff --git a/tests/generic/650 b/tests/generic/650
index 36a23e48d..60f86fdf5 100755
--- a/tests/generic/650
+++ b/tests/generic/650
@@ -52,8 +52,6 @@ nr_hotplug_cpus="${#hotplug_cpus[@]}"
 test "$nr_hotplug_cpus" -gt 0 || _notrun "CPU hotplugging not supported"
 
 stress_dir="$TEST_DIR/$seq"
-rm -r -f "$stress_dir"
-mkdir -p "$stress_dir"
 
 echo "Silence is golden."
 
@@ -79,12 +77,14 @@ fsstress_args+=(--duration="$((SOAK_DURATION / 10))")
 nr_ops=$((2500 * TIME_FACTOR))
 fsstress_args+=(-n $nr_ops)
 for ((i = 0; i < 10; i++)); do
-	_run_fsstress_bg -w "${fsstress_args[@]}"
-	_wait_for_fsstress
+	rm -rf "$stress_dir"
+	mkdir -p "$stress_dir"
+	_run_fsstress "${fsstress_args[@]}"
 	_test_cycle_mount
 done
 
 rm -f $sentinel_file
+wait
 
 # success, all done
 status=0
diff --git a/tests/xfs/013 b/tests/xfs/013
index 5a92ef084..fd011445d 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -120,6 +120,7 @@ _kill_fsstress
 # clean out the competing fsstress allocations, then everything else
 rm -rf $SCRATCH_MNT/fsstress
 rm -rf $SCRATCH_MNT/dir*
+wait
 
 _scratch_unmount
 
diff --git a/tests/xfs/558 b/tests/xfs/558
index ba137ae8d..c594d8ccd 100755
--- a/tests/xfs/558
+++ b/tests/xfs/558
@@ -193,6 +193,7 @@ wait_for_errortag &
 $XFS_IO_PROG -c "pwrite -S 0x56 $((2 * blksz)) $((2 * blksz))" \
 	-c 'fsync' $SCRATCH_MNT/file >> $seqres.full
 rm -f $sentryfile
+wait
 
 cat "$tracefile" >> $seqres.full
 grep -q iomap_invalid "$tracefile"
-- 
2.45.2

