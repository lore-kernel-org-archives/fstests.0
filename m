Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BF2DC78E
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149737; cv=none; b=cfDRhGxR+rCNEZ/T5N/bOrS2AiDQF0gTGz5Q2fDhPPjfAn/45AbHa4WFlwSQ8ycoyc5LCR5Y/VElfRy02O63Un5j0f1vilhgmDkj+FiD43eyKXdA1f5mL0SXR+YGwY/j4nuVFBGNlImosqv5HvK9Gr8oOmi5XBMisSmeKe3I2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149737; c=relaxed/simple;
	bh=j6twI5SqQGvOPFdhGNQNuBtlelBO6pkQcYFTuqJo4NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMpglcz3LUD6n7g9xxng2tzGTkujz/YT5U0wjbwx0IHnnEyaHNowQY9rmtPkiadQbwfKF9T/F4hpwsidVMWMCPAn51JKOPtHwh5OF3O8vAYPqA39I1ShyQEQgRhr7Vqw9cWCl1j5oxXjUc0KV9bR6ZW6QJZkTTQ4PWbe5HSKpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeuOC15F; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeuOC15F"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso3554710a12.3
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 11:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763149734; x=1763754534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tv0IKvKJcdm09lOdehlfWwQJkkukI0ZDKzc1jq3HU1E=;
        b=QeuOC15FC1dM+LjGtYm2+HJJi+ZcdX+7R4qy5YOj6SHK4K4BXQsSUK4+gZ76QGDxG+
         6IZDXnVMDR6uhv62oj3gMvVrcsdDI/a7yT5CLTTrMKcIY+sHM+EFJy341C5GX7N3mBUX
         S+Q6waWwjTLRT+fsfSQs9yirxmKEJxLCDHUwedUX+n3Urxnasu3+M0eGSslkaAQI9DWe
         zi5ebipEpC0SXK8yz+Do/DtG+B+QjwvXDsldufLAITQrl9v86nA3JtGldl2GprtA/E1B
         Az3GQ8/7ZOF4Vt2e4P/hE9mB7wMRFEUPYefm7D3BSgNS9/Hz1PM95oqgb+x7I9ZfexUM
         nkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763149734; x=1763754534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv0IKvKJcdm09lOdehlfWwQJkkukI0ZDKzc1jq3HU1E=;
        b=KSmnI2Obm6ansVdRMCT4Cwv/j70czZ1MI9ejsWpHSHCaXCJ39tEvnSx5QF4nXmlY8E
         wgRpkli2aAJLCpFutlsSdqYjOQX/tAe1UPZB0u2kWhe9YX8WWDGqulGwf5OAMt118pSs
         96lI6j3EXQ86cwPoPFaVqp2KbU2rGJ+gf1mdbxuTE7I5LbfVvmNeqwrwPirwNcOBgycv
         g/M9OPSWrCscyF4C5pef6qBVbTR6Y4ITpPJ16V1EzASS8WhR6yUlfB+yVUwM4vBD9Aeu
         2ziG3uooeUTsqZ7Euy3yqTQKwkhab/m7kMnKsjkBjjfnQImK/Yr73PoMsdxgGg7dWtGB
         aOTw==
X-Forwarded-Encrypted: i=1; AJvYcCWxLjSLRdhqgWYWJe84WQdnDbmepgO7yUlRK7W1bW3ktuAzNqTt/wrQBQlOar++wfX7BJUe9V1B@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmzw6yq557Rw+dN3TX5IJYMU49Tcw5ybbHOmpbHT7bwNkYT6uj
	6xe8PJnP2MsOl5g4P4WUUDUkcdOK284/cf4ao/D+yapJ97nat0a6R26D
X-Gm-Gg: ASbGncv5gyK06+1cLEv5jhK2nOLQLqsWedZKct4WUcollBCACBRJeoET2TT/R9s2EnU
	9ns17aRo1MPpike3YOW2aJVv3UoIOi5KKganx6sj/Qy8ntoAK31tNO30aHOnAXWDOB5jQfPWokb
	n75WPXPjlfb9K76gbkcd4rgN7wolpByNMYyLPJs0+FIdMRB+IekuyUMXeLb+F3k3SfmGbjVVmDA
	DXOuEHQQ4JzVPpIgFRCYB6jVd4XdWt4HIeZoXOJrppqBr3lAjCAM4B4SqjGkCXgJPSe2eIylYfX
	cZHAIwqmDjnoWq+InU0hsZgqY0SC4DQktmdIyN1O5Tjqhanfc5Ohu8QMSfC87U1zEmveyUdodhK
	3G0IOTI1yS895o50xpz5zFPtZrYxQgABSh8AUFgYAO7ngZnHv1ue6hRg3Cdg9QWs6ICTfy3o4p9
	3DoSARE1p8UA1/IsGx9CRL9hwAc0mP7rQVo9GTY07m+zQdJKnnzDIPyw+vZIhqNfs+QCb5Nb49h
	yFziw==
X-Google-Smtp-Source: AGHT+IH9/VmrpBDdC3X+Pu/jasW2eLDwTI8VLT3G+6FDxr+TM96Do/OesjkQl9u7f62ZGK9sRCOZvQ==
X-Received: by 2002:a17:907:1b20:b0:b6d:3fc9:e60c with SMTP id a640c23a62f3a-b736780c131mr435172766b.20.1763149733822;
        Fri, 14 Nov 2025 11:48:53 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-9bc7-e3f9-3583-f90e.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:9bc7:e3f9:3583:f90e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad41cesm443604066b.16.2025.11.14.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:48:53 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] overlay: add tests for casefolded layers
Date: Fri, 14 Nov 2025 20:48:52 +0100
Message-ID: <20251114194852.1344740-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Overalyfs did not allow mounting layers with casefold capable fs
until kernel v6.17 and did not allow casefold enabled layers
until kernel v6.18.

Since kernel v6.18, overalyfs allows this kind of setups,
as long as the layers have consistent encoding and all the directories
in the subtree have consistent casefolding.

Create test cases for the following scenarios:
- Mounting overlayfs with casefold disabled
- Mounting overlayfs with casefold enabled
- Lookup subdir in overlayfs with mismatch casefold to parent dir
- Change casefold of underlying subdir while overalyfs is mounted
- Mounting overlayfs with strict enconding, but casefold disabled
- Mounting overlayfs with strict enconding casefold enabled
- Mounting overlayfs with layers with inconsistent UTF8 version

Co-developed-by: André Almeida <andrealmeid@igalia.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Zorro,

I fixed the bug you found with tmpfs.

Please note that I did not assign a sequential test number because
I wanted to let you assign a non conflicting number when you merge it.

Thanks,
Amir.

Chages since v1:
- Fix test run with tmpfs (needed _scratch_mount_casefold_strict)
- unmount MNT1/MNT2 in cleanup
- Use _mount _unmount helpers

 tests/generic/999     | 242 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  13 +++
 2 files changed, 255 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..c315b8ba
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,242 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 CTERA Networks. All Rights Reserved.
+#
+# FS QA Test 999
+#
+# Test overlayfs error cases with casefold enabled layers
+#
+# Overalyfs did not allow mounting layers with casefold capable fs
+# until kernel v6.17 and with casefold enabled until kernel v6.18.
+# Since kernel v6.17, overalyfs allows the mount, as long as casefolding
+# is disabled on all directories.
+# Since kernel v6.18, overalyfs allows the mount, as long as casefolding
+# is consistent on all directories and encoding is consistent on all layers.
+#
+. ./common/preamble
+_begin_fstest auto quick mount casefold
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	_unmount $merge 2>/dev/null
+	_unmount $MNT1 2>/dev/null
+	_unmount $MNT2 2>/dev/null
+	rm -r -f $tmp.*
+}
+
+
+# Import common functions.
+. ./common/filter
+. ./common/casefold
+
+_exclude_fs overlay
+_require_extra_fs overlay
+
+_require_scratch_casefold
+
+# Create casefold capable base fs
+_scratch_mkfs_casefold >>$seqres.full 2>&1
+_scratch_mount_casefold
+
+# Create lowerdir, upperdir and workdir without casefold enabled
+lowerdir="$SCRATCH_MNT/ovl-lower"
+upperdir="$SCRATCH_MNT/ovl-upper"
+workdir="$SCRATCH_MNT/ovl-work"
+merge="$SCRATCH_MNT/ovl-merge"
+
+mount_casefold_version()
+{
+	option="casefold=$1"
+	_mount -t tmpfs -o $option tmpfs $2
+}
+
+mount_overlay()
+{
+	local lowerdirs=$1
+
+	_mount -t overlay overlay $merge \
+		-o lowerdir=$lowerdirs,upperdir=$upperdir,workdir=$workdir
+}
+
+unmount_overlay()
+{
+	_unmount $merge 2>/dev/null
+}
+
+# Try to mount an overlay with casefold enabled layers.
+# On kernels older than v6.18 expect failure and skip the test
+mkdir -p $merge $upperdir $workdir $lowerdir
+_casefold_set_attr $upperdir >>$seqres.full
+_casefold_set_attr $workdir >>$seqres.full
+_casefold_set_attr $lowerdir >>$seqres.full
+mount_overlay $lowerdir >>$seqres.full 2>&1 || \
+	_notrun "overlayfs does not support casefold enabled layers"
+unmount_overlay
+
+# Re-create casefold disabled layers with lower subdir
+casefolddir=$lowerdir/casefold
+rm -rf $upperdir $workdir $lowerdir
+mkdir -p $upperdir $workdir $lowerdir $casefolddir
+
+# Try to mount an overlay with casefold capable but disabled layers.
+# Since we already verified that overalyfs supports casefold enabled layers
+# this is expected to succeed.
+echo Casefold disabled
+mount_overlay $lowerdir >>$seqres.full 2>&1 || \
+	echo "Overlayfs mount with casefold disabled layers failed (1)"
+ls $merge/casefold/ >>$seqres.full
+unmount_overlay
+
+# Use new upper/work dirs for each test to avoid ESTALE errors
+# on mismatch lowerdir/upperdir (see test overlay/037)
+rm -rf $upperdir $workdir
+mkdir $upperdir $workdir
+
+# Try to mount an overlay with casefold disabled layers and
+# enable casefold on lowerdir root after mount - expect ESTALE error on lookup.
+echo Casefold enabled after mount
+mount_overlay $casefolddir >>$seqres.full || \
+	echo "Overlayfs mount with casefold disabled layers failed (2)"
+_casefold_set_attr $casefolddir >>$seqres.full
+mkdir $casefolddir/subdir
+ls $merge/subdir |& _filter_scratch
+unmount_overlay
+
+# Try to mount an overlay with casefold enabled lowerdir root - expect EINVAL.
+# With libmount version >= v1.39, we expect the following descriptive error:
+# mount: overlay: case-insensitive directory on .../ovl-lower/casefold not supported
+# but we want the test to run with older libmount, so we so not expect this output
+# we just expect a mount failure.
+echo Casefold enabled lower dir
+mount_overlay $casefolddir >>$seqres.full 2>&1 && \
+	echo "Overlayfs mount with casefold enabled lowerdir should have failed" && \
+	unmount_overlay
+
+# Changing lower layer root again
+rm -rf $upperdir $workdir
+mkdir $upperdir $workdir
+
+# Try to mount an overlay with casefold disabled layers, but with
+# casefold enabled subdir in lowerdir - expect EREMOTE error on lookup.
+echo Casefold enabled lower subdir
+mount_overlay $lowerdir >>$seqres.full
+ls $merge/casefold/subdir |& _filter_scratch
+unmount_overlay
+
+# workdir needs to be empty to set casefold attribute
+rm -rf $workdir/*
+
+_casefold_set_attr $upperdir >>$seqres.full
+_casefold_set_attr $workdir >>$seqres.full
+
+echo Casefold enabled upper dir
+mount_overlay $lowerdir >>$seqres.full 2>&1 && \
+	echo "Overlayfs mount with casefold enabled upperdir should have failed" && \
+	unmount_overlay
+
+# lowerdir needs to be empty to set casefold attribute
+rm -rf $lowerdir/*
+_casefold_set_attr $lowerdir >>$seqres.full
+mkdir $casefolddir
+
+# Try to mount an overlay with casefold enabled layers.
+# On kernels older than v6.18 expect failure and skip the rest of the test
+# On kernels v6.18 and newer, expect success and run the rest of the test cases.
+echo Casefold enabled
+mount_overlay $lowerdir >>$seqres.full 2>&1 || \
+	echo "Overlayfs mount with casefold enabled layers failed (1)"
+ls $merge/casefold/ >>$seqres.full
+unmount_overlay
+
+# Try to mount an overlayfs with casefold enabled layers. After the mount,
+# disable casefold on the lower layer and try to lookup a file. Should return
+# -ESTALE
+echo Casefold disabled on lower after mount
+mount_overlay $lowerdir >>$seqres.full 2>&1 || \
+	echo "Overlayfs mount with casefold enabled layers failed (2)"
+rm -rf $lowerdir/*
+_casefold_unset_attr $lowerdir >>$seqres.full
+mkdir $lowerdir/dir
+ls $merge/dir/ |& _filter_scratch
+unmount_overlay
+
+# cleanup
+rm -rf $lowerdir/*
+_casefold_set_attr $lowerdir >>$seqres.full
+
+# Try to mount an overlayfs with casefold enabled layers. After the mount,
+# disable casefold on a subdir in  the lower layer and try to lookup it.
+# Should return -EREMOTE
+echo Casefold disabled on subdir after mount
+mkdir $lowerdir/casefold/
+mount_overlay $lowerdir >>$seqres.full 2>&1 || \
+	echo "Overlayfs mount with casefold enabled layers failed (3)"
+_casefold_unset_attr $lowerdir/casefold/
+mkdir $lowerdir/casefold/subdir
+ls $merge/casefold/subdir |& _filter_scratch
+unmount_overlay
+
+# cleanup
+rm -rf $lowerdir/*
+
+# Test strict enconding, but casefold not enabled. Should work
+_scratch_umount_idmapped
+
+_scratch_mkfs_casefold_strict >>$seqres.full 2>&1
+_scratch_mount_casefold_strict
+
+mkdir -p $merge $upperdir $workdir $lowerdir
+
+mount_overlay $lowerdir >>$seqres.full 2>&1 || \
+	echo "Overlayfs mount with strict casefold disabled layers failed"
+unmount_overlay
+
+# Test strict enconding, with casefold enabled. Should fail
+# dmesg: overlayfs: strict encoding not supported
+rm -rf $upperdir $workdir
+mkdir $upperdir $workdir
+
+_casefold_set_attr $upperdir >>$seqres.full
+_casefold_set_attr $workdir >>$seqres.full
+_casefold_set_attr $lowerdir >>$seqres.full
+
+mount_overlay $lowerdir >>$seqres.full 2>&1 && \
+	echo "Overlayfs mount with strict casefold enabled should have failed" && \
+	unmount_overlay
+
+# Test inconsistent casefold version. Should fail
+# dmesg: overlayfs: all layers must have the same encoding
+
+# use tmpfs to make easier to create two different mount points with different
+# utf8 versions
+testdir="$SCRATCH_MNT/newdir/"
+mkdir $testdir
+
+MNT1="$testdir/mnt1"
+MNT2="$testdir/mnt2"
+
+mkdir $MNT1 $MNT2 "$testdir/merge"
+
+mount_casefold_version "utf8-12.1.0" $MNT1
+mount_casefold_version "utf8-11.0.0" $MNT2
+
+mkdir "$MNT1/dir" "$MNT2/dir"
+
+_casefold_set_attr "$MNT1/dir"
+_casefold_set_attr "$MNT2/dir"
+
+mkdir "$MNT1/dir/lower" "$MNT2/dir/upper" "$MNT2/dir/work"
+
+upperdir="$MNT2/dir/upper"
+workdir="$MNT2/dir/work"
+lowerdir="$MNT1/dir/lower"
+
+mount_overlay $lowerdir >>$seqres.full 2>&1  && \
+	echo "Overlayfs mount different unicode versions should have failed" && \
+	unmount_overlay
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..ce383d94
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,13 @@
+QA output created by 999
+Casefold disabled
+Casefold enabled after mount
+ls: cannot access 'SCRATCH_MNT/ovl-merge/subdir': Stale file handle
+Casefold enabled lower dir
+Casefold enabled lower subdir
+ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
+Casefold enabled upper dir
+Casefold enabled
+Casefold disabled on lower after mount
+ls: cannot access 'SCRATCH_MNT/ovl-merge/dir/': Stale file handle
+Casefold disabled on subdir after mount
+ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
-- 
2.51.1

