Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121E4689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683569; cv=none; b=SSUfWMelYmqgODeavEw2qaK9IyHJe7WLXSjb76n1laEozWfgb23k3ggnfN32xedhslEn9jDcOtuAjFI36hjC6fPWa9AXeLGjdSTK7TVRK9GLXF2a+mopVbXoV7NjTkTGloDppFGycqCclOE7dMdB0Xmalpo8b6fbIvc9Qv7/v9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683569; c=relaxed/simple;
	bh=hoUyhGZ3dEP6UU2SOVVtCF3Uzsj2Uyy/tRqRhwYGol4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVfudHzLcyvpIhsvIzMEb9P9ipl/iaUeLBlgHS0MgAKdUkCVi1ayIj3tJ/pEj+kfSzSG79PLjJmDZGIfCWfU74z1NtdxhSxPI/CsCTZUIJtd/r8gUizSoQNA3JOJK/yePbriEDlxgqMFCeaPX9gK2sEyjiYFna6I9uzDBBD7VyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jnlEas55; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jnlEas55"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-723f37dd76cso6252480b3a.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683566; x=1733288366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsbHLOgvrvxHz7aOM9wuCQbYRzWapgwkUHVG3eVzOPc=;
        b=jnlEas55DMICriCXShkJXe09+7+KOBzFYNxL1o1reUThsHEnYoQ4ybUG0hZrv3zbzG
         44ArjXlZ2WCGPPfklfv9v+YOvDOANh0mBfNMZmmSk27YJswVB9QCy6ozb7avFm0k+VTw
         TJkSiNFLCA73FUP6YyxDsSCk+1D5vIFnmCzQFz4WMfZ3hRtPO+WKk7PGw/P6Ifdzta0c
         muAPT/DngpPJSVgFD4dh75gCN9104+e49M0xw5t8uQhi1WlO+mFMxMPn0vHKBuX9I6UO
         QHYBEEOmDNKcpz1pU3fzTOXaWAsP6kocj40Pe+6LaEZGF8376irnO8JGvJ9YzT3Lrn/j
         p/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683566; x=1733288366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsbHLOgvrvxHz7aOM9wuCQbYRzWapgwkUHVG3eVzOPc=;
        b=adQD0jILdd/hapwqijN2enI92kqJOEHH9nWZRzNv4FBzMg/vT1Ci3upnoKl57FYhZJ
         +blyeIf1V/zDZG1wR+1470BeYeG8H7mg24pHOVZ2Z0zCZ7CsZZXgkKyandC+RezpSv1W
         DKX1VSsBH6y38kgmpdKPAAqtYK9enO5VreFS3lu5ngOWXZClRct1hDkPdbV1f1H9yu2n
         OHwNl2efZoBCvCrEXEutIonxAIQobAQ9ap/kNakusLLIEkckLMA+xbPM1w1nK9qp9/0C
         BAyxz0hOmvVzCFjBWivO5x2cb3IRCEQ7sHPwy69P3XHiAnpr+v3fF9iy6n0yY75XAXtZ
         VPNQ==
X-Gm-Message-State: AOJu0YwkCo1BskCLkwA39WA1vmKsieRSxMt3kOFSGtGlSeC1F5w7IxHF
	DgmMkjflqla88RMarIvkm9GQR5c5XUz3CU7buaOuUFuICAz1MItwvmxVBmK9wM/f8kVqrXZC0gx
	r
X-Gm-Gg: ASbGncth8iZYF/2ov6ntiAAuXpsEds9aHbwJEdQKZx5X8yJ+T5RNBVZF+B64CBSII6y
	Az2rK2REK3HvGmrswVRDyKIgBI8eoidrUwc2ULkj3K+SJhfUsJU9GwHsXXK1MsTVRvomkfqbcE8
	bQSIcvpgpxMsEHKAIsPwPpSe4zLoyGEeA9FfWnb7Em6Jk0Nc3a6ggp6Y6aDwmULYkJlttGoF+Qj
	Kt73kBux3Q+nJEHIotTyDwB425UBDOs0zMOQPFDHmfYurkWJoNBD2kyiQOCWhsiUlyR6e1ig7ru
	wdhtzHmYCKF/nw==
X-Google-Smtp-Source: AGHT+IF0WTSriABadVi/+yLK3ImrM2hL95JtSv8pUlKQ88KEyvh0oJbNWkak0yzhlDDBfcInqPzDLA==
X-Received: by 2002:a05:6a20:430f:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1e0e0ac3139mr3359447637.7.1732683565614;
        Tue, 26 Nov 2024 20:59:25 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fab815csm490563a91.48.2024.11.26.20.59.24
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:25 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUq-1NHN
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQek-1wAi
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 16/40] fstests: use udevadm wait in preference to settle
Date: Wed, 27 Nov 2024 15:51:46 +1100
Message-ID: <20241127045403.3665299-17-david@fromorbit.com>
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

When running lots of tests in parallel, there are lots of
filesystems and block devices changing state. This generates a lot
of udev events when means the udev event queue is rarely empty.
Unfortunately, an empty event queue is what udev settling waits
upon. Hence calling UDEV_SETTLE_PROG can mean waiting for a lot of
time for other tests to stop generating udev events.

For the majority of cases, what we care about is that udev has
performed device node addition or removal, not that there are no
udev events pending. Recent(-ish) systemd releases support 'udevadm
wait' to wait for a specific file to be created or unlinked rather
than waiting for the event that does that work to be completed.

Hence we don't have to wait for the udev event queue to empty,
just for the udev event that does the device node manipulation to
complete.

Introduce detection of 'udevadm wait' support and a _udev_wait()
wrapper function to use it if it is available. If it isn't, the use
the existing UDEV_SETTLE_PROG behaviour.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/config     | 35 +++++++++++++++++++++++++----------
 common/rc         | 25 ++++++++++++++++---------
 tests/btrfs/291   |  5 +++--
 tests/generic/081 |  6 +++---
 tests/generic/108 |  7 +++----
 tests/generic/459 |  6 +++---
 6 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/common/config b/common/config
index fcff0660b..41b8f29d1 100644
--- a/common/config
+++ b/common/config
@@ -165,7 +165,7 @@ export XFS_MDRESTORE_PROG="$(type -P xfs_mdrestore)"
 export XFS_ADMIN_PROG="$(type -P xfs_admin)"
 export XFS_GROWFS_PROG=$(type -P xfs_growfs)
 export XFS_SPACEMAN_PROG="$(type -P xfs_spaceman)"
-export XFS_SCRUB_PROG="$(type -P xfs_scrub)"
+#export XFS_SCRUB_PROG="$(type -P xfs_scrub)"
 export XFS_PARALLEL_REPAIR_PROG="$(type -P xfs_prepair)"
 export XFS_PARALLEL_REPAIR64_PROG="$(type -P xfs_prepair64)"
 export __XFSDUMP_PROG="$(type -P xfsdump)"
@@ -236,18 +236,30 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 
-# use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
-# newer systems have udevadm command but older systems like RHEL5 don't.
-# But if neither one is available, just set it to "sleep 1" to wait for lv to
-# be settled
-UDEV_SETTLE_PROG="$(type -P udevadm)"
-if [ "$UDEV_SETTLE_PROG" == "" ]; then
-	# try udevsettle command
+# udev wait functions.
+#
+# This is how we wait for udev to create or remove device nodes after running a
+# device create/remove command for logical volumes (e.g. lvm or dm).
+#
+# We can wait for the udev queue to empty via "settling". This, however, has
+# major issues when running tests in parallel - the udev queue takes a long time
+# to reach empty state. Hence if we have udev > 2.51 installed we use device
+# waiting instead. This waits for the device node to appear/disappear rather
+# than waiting for the udev queue to empty.
+#
+# If none of these methods are available, fall back to a simple delay (sleep 1)
+# and hope this is sufficient.
+UDEVADM_PROG="$(type -P udevadm)"
+if [ -z "$UDEVADM_PROG" ]; then
 	UDEV_SETTLE_PROG="$(type -P udevsettle)"
 else
-	# udevadm is available, add 'settle' as subcommand
-	UDEV_SETTLE_PROG="$UDEV_SETTLE_PROG settle"
+	UDEV_SETTLE_PROG="$UDEVADM_PROG settle"
+	$UDEVADM_PROG help | grep -q "Wait for device or device symlink"
+	if [ $? -eq 0 ]; then
+		UDEV_WAIT_PROG="$UDEVADM_PROG wait"
+	fi
 fi
+
 # neither command is available, use sleep 1
 #
 # Udev events are sent via netlink to userspace through
@@ -258,8 +270,11 @@ fi
 # exist or always be 0. We check for /proc/net to see CONFIG_NET was enabled.
 if [[ "$UDEV_SETTLE_PROG" == "" || ! -d /proc/net ]]; then
 	UDEV_SETTLE_PROG="sleep 1"
+	unset UDEV_WAIT_PROG
 fi
 export UDEV_SETTLE_PROG
+export UDEVADM_PROG
+export UDEV_WAIT_PROG
 
 # Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
 # modprobe removal to run forever trying to remove a module.
diff --git a/common/rc b/common/rc
index 3f35da7fe..fdd18a386 100644
--- a/common/rc
+++ b/common/rc
@@ -5191,22 +5191,29 @@ _require_label_get_max()
 	dummy=$(_label_get_max)
 }
 
+_udev_wait()
+{
+	local args="$*"
+
+	if [ -z "$UDEV_WAIT_PROG" ]; then
+		$UDEV_SETTLE_PROG >/dev/null 2>&1
+	else
+		$UDEV_WAIT_PROG $args
+	fi
+}
+
 _dmsetup_remove()
 {
-	$UDEV_SETTLE_PROG >/dev/null 2>&1
-	$DMSETUP_PROG remove --retry "$@" >>$seqres.full 2>&1
-	$UDEV_SETTLE_PROG >/dev/null 2>&1
+	[ $# -le 0 ] && return
+
+	$DMSETUP_PROG remove --deferred "$@" >>$seqres.full 2>&1
+	_udev_wait --removed /dev/mapper/$1
 }
 
 _dmsetup_create()
 {
-	# Wait for udev to settle so that the dm creation doesn't fail because
-	# some udev subprogram opened one of the block devices mentioned in the
-	# table string w/ O_EXCL.  Do it again at the end so that an immediate
-	# device open won't also fail.
-	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG create "$@" >>$seqres.full 2>&1 || return 1
-	$UDEV_SETTLE_PROG >/dev/null 2>&1
+	_udev_wait /dev/mapper/$1
 }
 
 _require_btime()
diff --git a/tests/btrfs/291 b/tests/btrfs/291
index c31de3a96..122aeaa5d 100755
--- a/tests/btrfs/291
+++ b/tests/btrfs/291
@@ -21,6 +21,7 @@ _cleanup()
 	cd /
 	_log_writes_cleanup &> /dev/null
 	$LVM_PROG vgremove -f -y $vgname >>$seqres.full 2>&1
+	_udev_wait --removed /dev/mapper/$vgname-$lvname
 	losetup -d $loop_dev >>$seqres.full 2>&1
 	rm -f $img
 	_restore_fsverity_signatures
@@ -106,7 +107,7 @@ snap_dev=/dev/mapper/vg_replay-$snapname
 $LVM_PROG vgcreate -f $vgname $loop_dev >>$seqres.full 2>&1 || _fail "failed to vgcreate $vgname"
 $LVM_PROG lvcreate -L "$replay_bytes"B -n $lvname $vgname -y >>$seqres.full 2>&1 || \
 	_fail "failed to lvcreate $lvname"
-$UDEV_SETTLE_PROG >>$seqres.full 2>&1
+_udev_wait /dev/mapper/$vgname-$lvname
 
 replay_log_prog=$here/src/log-writes/replay-log
 num_entries=$($replay_log_prog --log $LOGWRITES_DEV --num-entries)
@@ -125,7 +126,7 @@ do
 
 	$LVM_PROG lvcreate -s -L 4M -n $snapname $vgname/$lvname >>$seqres.full 2>&1 || \
 		_fail "Failed to create snapshot"
-	$UDEV_SETTLE_PROG >>$seqres.full 2>&1
+	_udev_wait /dev/mapper/$vgname-$snapname
 
 	orphan=$(count_item $snap_dev ORPHAN)
 	[ $state -eq 0 ] && [ $orphan -gt 0 ] && state=1
diff --git a/tests/generic/081 b/tests/generic/081
index df17ab6c1..37137d937 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -38,7 +38,7 @@ _cleanup()
 		$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 		$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
 		pv_ret=$?
-		$UDEV_SETTLE_PROG
+		_udev_wait --removed /dev/mapper/$vgname-$lvname
 		test $pv_ret -eq 0 && break
 		sleep 2
 	done
@@ -70,8 +70,8 @@ $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
 yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1
-# wait for lvcreation to fully complete
-$UDEV_SETTLE_PROG >>$seqres.full 2>&1
+_udev_wait /dev/mapper/$vgname-$lvname
+
 
 # _mkfs_dev exits the test on failure, this can make sure lv is created in
 # above vgcreate/lvcreate steps
diff --git a/tests/generic/108 b/tests/generic/108
index 2709472f6..f630450ec 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -20,8 +20,8 @@ _cleanup()
 	echo running > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
 	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
 	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
-	$LVM_PROG pvremove -f $SCRATCH_DEV $SCSI_DEBUG_DEV >>$seqres.full 2>&1
-	$UDEV_SETTLE_PROG
+	 pvremove -f $SCRATCH_DEV $SCSI_DEBUG_DEV >>$seqres.full 2>&1
+	_udev_wait --removed /dev/mapper/$vgname-$lvname
 	_put_scsi_debug_dev
 	rm -f $tmp.*
 }
@@ -57,8 +57,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # (like 2.02.95 in RHEL6) don't support --yes option
 yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
 	>>$seqres.full 2>&1
-# wait for lv creation to fully complete
-$UDEV_SETTLE_PROG >>$seqres.full 2>&1
+_udev_wait /dev/mapper/$vgname-$lvname
 
 # _mkfs_dev exits the test on failure, this makes sure test lv is created by
 # above vgcreate/lvcreate operations
diff --git a/tests/generic/459 b/tests/generic/459
index daccc80ce..1986c2e8f 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -31,7 +31,7 @@ _cleanup()
 	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
 	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
-	$UDEV_SETTLE_PROG
+	_udev_wait --removed /dev/mapper/$vgname-$lvname
 }
 
 # Import common functions.
@@ -88,8 +88,7 @@ $LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
 $LVM_PROG lvcreate  --virtualsize $virtsize \
 		    -T $vgname/$poolname \
 		    -n $lvname >>$seqres.full 2>&1
-
-$UDEV_SETTLE_PROG &>/dev/null
+_udev_wait /dev/mapper/$vgname-$lvname
 _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
 
 # Running the test over the original volume doesn't reproduce the problem
@@ -97,6 +96,7 @@ _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
 # reproducible, so, create a snapshot and run the test over it.
 $LVM_PROG lvcreate  -k n -s $vgname/$lvname \
 		    -n $snapname >>$seqres.full 2>&1
+_udev_wait /dev/mapper/$vgname-$snapname
 
 # Catch mount failure so we don't blindly go an freeze the root filesystem
 # instead of lvm volume.
-- 
2.45.2

