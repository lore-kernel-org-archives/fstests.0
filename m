Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2617BED0
	for <fstests@vger.kernel.org>; Fri,  8 Aug 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681542; cv=none; b=R2hpk+s1ky5s9X66/w6xbBXMosBTMuOcmzGySIVLMF2JDzUFObmTGSyVM4Ttg6nfdlioXsU/I4oHV/d4XvTnzxv3ZM+Vt0u/ArxlnFA4s1JfB+2aYNk02wqcIIvBmpt2OxjITioNtAfxquDTZA5QfsesZcR5tjwcPI7aDwQyRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681542; c=relaxed/simple;
	bh=plaTtuQnRmWgM48fnGmtDOucRd+m6YR/8tSDjJ3yGEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctI7ONdCbCz7+JSv+j3ydAyIDxmzvP65MGSqPr/LMJ2QcnaiLjKxQVqhMwoVn0aYlh0uGGWYPAKqPcoiWIysnC0uxxRTQyv4WaqeGvi5oxcSzhCeVmj7y5PonRW9Y/RYTxFe+uPs6Hj+W5XnKVp63Ft4TNREKW+6DZ/g0qXhGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFiS7SSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFiS7SSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RAYwUmVRutOytAMApm6QOTB180QV4zbsyVGr1FDRzE=;
	b=IFiS7SSYqAVrlI/TLfxctTWMtKBUiLewavexW0I1bAw3HEtHhVX3D3yrysxHC7WP93WyIN
	Cwx+S+oA+yHfqvrPZZABBk++uZNzPymWq5sOQNLyO3NUOqjyZnwTCMRxUsETLHubUlBtsS
	pmdeLNYLMy8BGVfky8y9wFN/uHBbiRk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-XZLxNZkyO6qmWL-p5vmd-Q-1; Fri, 08 Aug 2025 15:32:17 -0400
X-MC-Unique: XZLxNZkyO6qmWL-p5vmd-Q-1
X-Mimecast-MFC-AGG-ID: XZLxNZkyO6qmWL-p5vmd-Q_1754681536
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d665a87aso19141345e9.1
        for <fstests@vger.kernel.org>; Fri, 08 Aug 2025 12:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681536; x=1755286336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RAYwUmVRutOytAMApm6QOTB180QV4zbsyVGr1FDRzE=;
        b=cbpngo+4xR9GsnWuJ4y2mo7PEO2lfBP4EY18k6wwbnCqvcgMX50Qbhk4+vBIyud12o
         aVpS2SqtKbA0qY3Gs08aWIU+o5SBedfSHdtC+OHflxdGBZeWgL8Y/idI6WZEBGTI3Sxg
         tHgSZIkrhc7QyTYOsXjZXbEobgjGlWLcjJHsn8+nAFdykRpZw7LMLJw8X2wC3f79mHnA
         F5Luz93Ox71RRgWeEZQfoQW663KNGj+p3M6NPrsNNfuhJjyjx1qvF4iVvv8FiOH28gd4
         6tVPkWYCwgSdJCq6CReo55DqR9T+v+EXipSCa59mu7uXDT8lbdd+EjJrF1rg60WUYpdi
         460A==
X-Gm-Message-State: AOJu0Yy+CEByJ/h48gVYSEv/jOowPPP0t6pNHVTP4zK9VNXAvK9wk5Og
	asg50gLTprxYGmZZLXB4z2JH2lVp3XTNX/pwhH7ZyyqE3lqBfvIi+03z6l95tcD5x3nEoa8Rx/a
	LluuC6GIhGucE222YayiKCsaqommvfu4ugbBMzk67r5eBU2Jtoxm/cEordltTzyFAqUOVa2ZVjV
	+31U5B6oSE68qIHK8oVfQvmCyCi7a/sTD255tuFAd0pA==
X-Gm-Gg: ASbGnctEg6CaieQQKOV12vOPVAYreXa73aUdAQs3udTD+s0QkTvHHRgd4Vrxsh28cUK
	F31OYEWO1rqB5unh0C5MXM7uyzwUmPoYMHIfCwx08Bl3aUwae/LBQrVGbJgyTocxtxoRDshx3hZ
	qsuE9bw9RSe5AGSflLpECvwbbaW5nfL0Tvdy2ZA/M59NHwdXqoVqMWO2OmPXfS5E/IQ7k+yc3Ew
	IK9DFG4Fs+s0pzHxW17uYtg6jbmmY18+rahyeJEgumm0U8OBM2qHHJ1KzQfBC3FhJsyS6X6V+9/
	DViYIw8wJGO8Tk8+jzTx+u8GMKgJZMxQSx5blsIsVFufdQ==
X-Received: by 2002:a05:600c:4449:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-459f4f2e2c1mr37916245e9.33.1754681535789;
        Fri, 08 Aug 2025 12:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuwt870vmGOcNEdEU1nivjuGCazvfx/iqBh+iw0Tbp+KMHhMx1C7ibV5K/scZCbTiJYZp7Ew==
X-Received: by 2002:a05:600c:4449:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-459f4f2e2c1mr37915975e9.33.1754681535259;
        Fri, 08 Aug 2025 12:32:15 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm164906135e9.17.2025.08.08.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:32:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:31:57 +0200
Subject: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5375; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=plaTtuQnRmWgM48fnGmtDOucRd+m6YR/8tSDjJ3yGEc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYF7HWQWmrzetn18GeXjxtxxUnW2aR/uS5jv7ozj
 bPgmfVax4kdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJpLixMiw2eztMR/htj9m
 xjbquSfecIb+efH4ZIboe5HKFX17En8XMTLc+epSUz/v5ULer8yhK7kveH8WDp6nycuS3yGaurR
 uDTcXACHBRi4=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to test basic functionality of file_getattr() and
file_setattr() syscalls. Most of the work is done in file_attr
utility.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000.out |  37 ++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/tests/generic/2000 b/tests/generic/2000
new file mode 100755
index 000000000000..b4410628c241
--- /dev/null
+++ b/tests/generic/2000
@@ -0,0 +1,113 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 2000
+#
+# Test file_getattr/file_setattr syscalls
+#
+. ./common/preamble
+_begin_fstest auto
+
+# Import common functions.
+# . ./common/filter
+
+_wants_kernel_commit xxxxxxxxxxx \
+	"fs: introduce file_getattr and file_setattr syscalls"
+
+# Modify as appropriate.
+_require_scratch
+_require_test_program "af_unix"
+_require_test_program "file_attr"
+_require_symlinks
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+file_attr () {
+	$here/src/file_attr $*
+}
+
+create_af_unix () {
+	$here/src/af_unix $* || echo af_unix failed
+}
+
+projectdir=$SCRATCH_MNT/prj
+
+# Create normal files and special files
+mkdir $projectdir
+mkfifo $projectdir/fifo
+mknod $projectdir/chardev c 1 1
+mknod $projectdir/blockdev b 1 1
+create_af_unix $projectdir/socket
+touch $projectdir/foo
+ln -s $projectdir/foo $projectdir/symlink
+touch $projectdir/bar
+ln -s $projectdir/bar $projectdir/broken-symlink
+rm -f $projectdir/bar
+
+echo "Error codes"
+# wrong AT_ flags
+file_attr --get --invalid-at $projectdir ./foo
+file_attr --set --invalid-at $projectdir ./foo
+# wrong fsxattr size (too big, too small)
+file_attr --get --too-big-arg $projectdir ./foo
+file_attr --get --too-small-arg $projectdir ./foo
+file_attr --set --too-big-arg $projectdir ./foo
+file_attr --set --too-small-arg $projectdir ./foo
+# out of fsx_xflags mask
+file_attr --set --new-fsx-flag $projectdir ./foo
+
+echo "Initial attributes state"
+file_attr --get $projectdir
+file_attr --get $projectdir ./fifo
+file_attr --get $projectdir ./chardev
+file_attr --get $projectdir ./blockdev
+file_attr --get $projectdir ./socket
+file_attr --get $projectdir ./foo
+file_attr --get $projectdir ./symlink
+
+echo "Set FS_XFLAG_NODUMP (d)"
+file_attr --set --set-nodump $projectdir
+file_attr --set --set-nodump $projectdir ./fifo
+file_attr --set --set-nodump $projectdir ./chardev
+file_attr --set --set-nodump $projectdir ./blockdev
+file_attr --set --set-nodump $projectdir ./socket
+file_attr --set --set-nodump $projectdir ./foo
+file_attr --set --set-nodump $projectdir ./symlink
+
+echo "Read attributes"
+file_attr --get $projectdir
+file_attr --get $projectdir ./fifo
+file_attr --get $projectdir ./chardev
+file_attr --get $projectdir ./blockdev
+file_attr --get $projectdir ./socket
+file_attr --get $projectdir ./foo
+file_attr --get $projectdir ./symlink
+
+echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
+file_attr --set --set-nodump $projectdir ./broken-symlink
+file_attr --get $projectdir ./broken-symlink
+
+file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
+file_attr --get --no-follow $projectdir ./broken-symlink
+
+cd $SCRATCH_MNT
+touch ./foo2
+echo "Initial state of foo2"
+file_attr --get --at-cwd ./foo2
+echo "Set attribute relative to AT_FDCWD"
+file_attr --set --at-cwd --set-nodump ./foo2
+file_attr --get --at-cwd ./foo2
+
+echo "Set attribute on AT_FDCWD"
+mkdir ./bar
+file_attr --get --at-cwd ./bar
+cd ./bar
+file_attr --set --at-cwd --set-nodump ""
+file_attr --get --at-cwd .
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/2000.out b/tests/generic/2000.out
new file mode 100644
index 000000000000..51b4d84e2bae
--- /dev/null
+++ b/tests/generic/2000.out
@@ -0,0 +1,37 @@
+QA output created by 2000
+Error codes
+Can not get fsxattr on ./foo: Invalid argument
+Can not get fsxattr on ./foo: Invalid argument
+Can not get fsxattr on ./foo: Argument list too long
+Can not get fsxattr on ./foo: Invalid argument
+Can not get fsxattr on ./foo: Argument list too long
+Can not get fsxattr on ./foo: Invalid argument
+Can not set fsxattr on ./foo: Invalid argument
+Initial attributes state
+----------------- /mnt/scratch/prj 
+----------------- ./fifo 
+----------------- ./chardev 
+----------------- ./blockdev 
+----------------- ./socket 
+----------------- ./foo 
+----------------- ./symlink 
+Set FS_XFLAG_NODUMP (d)
+Read attributes
+------d---------- /mnt/scratch/prj 
+------d---------- ./fifo 
+------d---------- ./chardev 
+------d---------- ./blockdev 
+------d---------- ./socket 
+------d---------- ./foo 
+------d---------- ./symlink 
+Set attribute on broken link with AT_SYMLINK_NOFOLLOW
+Can not get fsxattr on ./broken-symlink: No such file or directory
+Can not get fsxattr on ./broken-symlink: No such file or directory
+------d---------- ./broken-symlink 
+Initial state of foo2
+----------------- ./foo2 
+Set attribute relative to AT_FDCWD
+------d---------- ./foo2 
+Set attribute on AT_FDCWD
+----------------- ./bar 
+------d---------- . 

-- 
2.49.0

