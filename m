Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D643164DC
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968568; cv=none; b=NbFuo5lmTWDcl4rmbpZqk1fTJx5pyxrqkEC6TyF+U6JKUdDvXW/yEktB2VEXbM3k3GVe6YcbeTDSQtOYq6qKweZu8xBl4iyK8yt9Kem3PX32U7qfF7+a8/AV64WaOjJOLI2j3oMef2niYTAedprK066/PXKKGhxXPSDRRvUo/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968568; c=relaxed/simple;
	bh=SR8wCX30+QkB0iU+zrhcQQx/iJ+D3afz0RlNOaH+QT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4I6FL1Y5g9p9nDkemoBdzl9JMzbkrHPaisl12OVhkWX1PKrDPPmblBakN1jxrilPAVmvgA9nkC1H0jUwDZKzWInJPdL2MizpsqcqSowfObkBAP48VTtcdBNcVBuxQSQOE5YP2TZLgtRkQ6LBntHT6zOckZYqpelJVhYxPjQKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8PYHREH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8PYHREH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=875p7D2Av8YvXf4a6psXikjfo7RpKmIN6rgx7UM8SmI=;
	b=L8PYHREHvWrDRW8cJG2uDVgLS4ZNLg4Bf94JkK4TkvflU1RI/SdeYSu2NQsxgnxY0GtgGk
	E+1m56gA2V4kqvQ76n6n4Fif2idmbN4fuWMmHNF7ZQUALpZhEdmFwpZJgji7uAGTwo322L
	9H3bZBZloLdrWQ4sPvwJFLeeTv15+QY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-or34tQ0KMeyycQ_UAoVi6Q-1; Mon, 20 Oct 2025 09:56:03 -0400
X-MC-Unique: or34tQ0KMeyycQ_UAoVi6Q-1
X-Mimecast-MFC-AGG-ID: or34tQ0KMeyycQ_UAoVi6Q_1760968562
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-472ce95ed1dso9569475e9.3
        for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 06:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968562; x=1761573362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=875p7D2Av8YvXf4a6psXikjfo7RpKmIN6rgx7UM8SmI=;
        b=Ec5MSbR1wwmlnSsnKA78Ra0BAUufMwx6J6CD4cGOKUE10JYabV94r3KPOSCLzB6rIM
         YecJIrxcn6IYRFVUPPcbMM+VT+fGAvfgr0LZflK99MGjuSZXx5fA7lMdg4fbIZs4XYlp
         +m/stCAZjUd2UqhszVQ1CGO9y5gT63MBoNVPpRgjlp6rBrjDHtXQorP0hSrhWJYElLJe
         bKDLtmzFMvbT1Kr7fxxVhJ68w2LlEIUX6eQEt9ypU2K8S/1dhG7CmTNE6RCYxyDjGRhL
         pFiY/OS63eW1CtU8pgLC0gneWXD6P8w1M9CiBXkl4thYEsMnfYvVLXc7kOAw+uk5z2Pv
         r6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUVsfNRnBer+diiGUYjNh8iTAspvg3Qpv7U7DL+1AhecG6l8EzfblCtAADJZP3NRPQ6OUaEGXEb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3c5XNLO/lh1AQtWeb1Tyb1VbptKlrME6boU7TaP0yejntn1Ru
	G0IxYh7Oh+ixzLhSOteubMPolZ7wdPblCHW81+Q2F3wg98nMukHd16Oth0qcb56ZruB5Gxv8cZW
	/Iecum8i9g+kFDpnT1vCxkj5VMm1GR3IDq7trzKpKgF/WNTgrKmSKGafY9g==
X-Gm-Gg: ASbGncvMMfVH+edxcCqsqDUbciO2mtxG40vqQhSeDyJVKsPFVax9O7/lRvJJfEpmhPm
	+YfwBdQDy6z1HzgBXUs4uCfSq+8SqLKBKseVrNQ2UHy4EfoVcV0FEU20ZVlE7LB4mjyujoc7ntr
	BXDrdQikpbjQphYorW2rcV/z06WI65H6nnTSUl2znmgivHn0B0Qz7rTy1l+P029GxZ9j1FmWnB0
	8K4ppn8JKmDBJMxCUleMgrnnPeJub6XQoLTiWMWd8CXoGFQzwt2mqHvVt/y0YCSLBGzRIsVX0i9
	O0WwOUVXCMrwt1iGXJrhNg2WgtONOrZwoghUfn6GIBsyhzLidS8vk18hbKXvaBHlhPyhiyI2t/w
	k2XspClmxqtVdCx9J60H+1nveGbX7NwoRTg==
X-Received: by 2002:a05:600c:1907:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-4711791c3b0mr109779505e9.28.1760968562185;
        Mon, 20 Oct 2025 06:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk/qhIVnAGUF8Og48owJjB6JYq3M5I50Lf8HpYpZqugR4s0ScDAGYP0s0KJX3z7TImCYbOrQ==
X-Received: by 2002:a05:600c:1907:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-4711791c3b0mr109779165e9.28.1760968561520;
        Mon, 20 Oct 2025 06:56:01 -0700 (PDT)
Received: from thinky.redhat.com (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm151404645e9.6.2025.10.20.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:56:01 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: djwong@kernel.org,
	zlang@redhat.com,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 3/3] generic/772: split this test into 772 and 773 for regular and special files
Date: Mon, 20 Oct 2025 15:55:30 +0200
Message-ID: <20251020135530.1391193-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020135530.1391193-1-aalbersh@kernel.org>
References: <20251020135530.1391193-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all filesystem support setting file attributes on special files. The
syscalls would still work for regular files. Let's split this test into
two to make it obvious if only special files support is missing.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/772     | 38 +-------------------
 tests/generic/772.out | 14 --------
 tests/generic/773     | 84 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/773.out | 20 +++++++++++
 4 files changed, 105 insertions(+), 51 deletions(-)
 create mode 100755 tests/generic/773
 create mode 100644 tests/generic/773.out

diff --git a/tests/generic/772 b/tests/generic/772
index bdd55b10f310..0d5c4749b010 100755
--- a/tests/generic/772
+++ b/tests/generic/772
@@ -4,7 +4,7 @@
 #
 # FS QA Test No. 772
 #
-# Test file_getattr/file_setattr syscalls
+# Test file_getattr() and file_setattr() syscalls on regular files
 #
 . ./common/preamble
 _begin_fstest auto
@@ -13,7 +13,6 @@ _begin_fstest auto
 
 # Modify as appropriate.
 _require_scratch
-_require_test_program "af_unix"
 _require_test_program "file_attr"
 _require_symlinks
 _require_mknod
@@ -21,29 +20,16 @@ _require_mknod
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 _require_file_attr
-_require_file_attr_special
 
 file_attr () {
 	$here/src/file_attr $*
 }
 
-create_af_unix () {
-	$here/src/af_unix $* || echo af_unix failed
-}
-
 projectdir=$SCRATCH_MNT/prj
 
 # Create normal files and special files
 mkdir $projectdir
-mkfifo $projectdir/fifo
-mknod $projectdir/chardev c 1 1
-mknod $projectdir/blockdev b 1 1
-create_af_unix $projectdir/socket
 touch $projectdir/foo
-ln -s $projectdir/foo $projectdir/symlink
-touch $projectdir/bar
-ln -s $projectdir/bar $projectdir/broken-symlink
-rm -f $projectdir/bar
 
 echo "Error codes"
 # wrong AT_ flags
@@ -59,37 +45,15 @@ file_attr --set --new-fsx-flag $projectdir ./foo
 
 echo "Initial attributes state"
 file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
-file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
-file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
-file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
-file_attr --get $projectdir ./socket | _filter_file_attributes ~d
 file_attr --get $projectdir ./foo | _filter_file_attributes ~d
-file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
 
 echo "Set FS_XFLAG_NODUMP (d)"
 file_attr --set --set-nodump $projectdir
-file_attr --set --set-nodump $projectdir ./fifo
-file_attr --set --set-nodump $projectdir ./chardev
-file_attr --set --set-nodump $projectdir ./blockdev
-file_attr --set --set-nodump $projectdir ./socket
 file_attr --set --set-nodump $projectdir ./foo
-file_attr --set --set-nodump $projectdir ./symlink
 
 echo "Read attributes"
 file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
-file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
-file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
-file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
-file_attr --get $projectdir ./socket | _filter_file_attributes ~d
 file_attr --get $projectdir ./foo | _filter_file_attributes ~d
-file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
-
-echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
-file_attr --set --set-nodump $projectdir ./broken-symlink
-file_attr --get $projectdir ./broken-symlink
-
-file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
-file_attr --get --no-follow $projectdir ./broken-symlink | _filter_file_attributes ~d
 
 cd $SCRATCH_MNT
 touch ./foo2
diff --git a/tests/generic/772.out b/tests/generic/772.out
index f7c23d94da4a..c89dbcf5d630 100644
--- a/tests/generic/772.out
+++ b/tests/generic/772.out
@@ -9,25 +9,11 @@ Can not get fsxattr on ./foo: Invalid argument
 Can not set fsxattr on ./foo: Invalid argument
 Initial attributes state
 ----------------- SCRATCH_MNT/prj
------------------ ./fifo
------------------ ./chardev
------------------ ./blockdev
------------------ ./socket
 ----------------- ./foo
------------------ ./symlink
 Set FS_XFLAG_NODUMP (d)
 Read attributes
 ------d---------- SCRATCH_MNT/prj
-------d---------- ./fifo
-------d---------- ./chardev
-------d---------- ./blockdev
-------d---------- ./socket
 ------d---------- ./foo
-------d---------- ./symlink
-Set attribute on broken link with AT_SYMLINK_NOFOLLOW
-Can not get fsxattr on ./broken-symlink: No such file or directory
-Can not get fsxattr on ./broken-symlink: No such file or directory
-------d---------- ./broken-symlink
 Initial state of foo2
 ----------------- ./foo2
 Set attribute relative to AT_FDCWD
diff --git a/tests/generic/773 b/tests/generic/773
new file mode 100755
index 000000000000..f633706a1455
--- /dev/null
+++ b/tests/generic/773
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat.  All Rights Reserved.
+#
+# FS QA Test 773
+#
+# Test file_getattr() and file_setattr() syscalls on special files (fifo,
+# socket, chardev...)
+#
+. ./common/preamble
+_begin_fstest quick
+
+# Import common functions.
+. ./common/filter
+
+# Modify as appropriate.
+_require_scratch
+_require_test_program "af_unix"
+_require_test_program "file_attr"
+_require_symlinks
+_require_mknod
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+_require_file_attr_special
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
+echo "Initial attributes state"
+file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
+file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
+file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
+file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
+file_attr --get $projectdir ./socket | _filter_file_attributes ~d
+file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
+
+echo "Set FS_XFLAG_NODUMP (d)"
+file_attr --set --set-nodump $projectdir
+file_attr --set --set-nodump $projectdir ./fifo
+file_attr --set --set-nodump $projectdir ./chardev
+file_attr --set --set-nodump $projectdir ./blockdev
+file_attr --set --set-nodump $projectdir ./socket
+file_attr --set --set-nodump $projectdir ./symlink
+
+echo "Read attributes"
+file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
+file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
+file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
+file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
+file_attr --get $projectdir ./socket | _filter_file_attributes ~d
+file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
+
+echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
+file_attr --set --set-nodump $projectdir ./broken-symlink
+file_attr --get $projectdir ./broken-symlink
+
+file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
+file_attr --get --no-follow $projectdir ./broken-symlink | _filter_file_attributes ~d
+
+# optional stuff if your test has verbose output to help resolve problems
+#echo
+#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
+
+# success, all done
+_exit 0
diff --git a/tests/generic/773.out b/tests/generic/773.out
new file mode 100644
index 000000000000..46ea3baa66fd
--- /dev/null
+++ b/tests/generic/773.out
@@ -0,0 +1,20 @@
+QA output created by 773
+Initial attributes state
+----------------- SCRATCH_MNT/prj
+----------------- ./fifo
+----------------- ./chardev
+----------------- ./blockdev
+----------------- ./socket
+----------------- ./symlink
+Set FS_XFLAG_NODUMP (d)
+Read attributes
+------d---------- SCRATCH_MNT/prj
+------d---------- ./fifo
+------d---------- ./chardev
+------d---------- ./blockdev
+------d---------- ./socket
+------d---------- ./symlink
+Set attribute on broken link with AT_SYMLINK_NOFOLLOW
+Can not get fsxattr on ./broken-symlink: No such file or directory
+Can not get fsxattr on ./broken-symlink: No such file or directory
+------d---------- ./broken-symlink
-- 
2.50.1

