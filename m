Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C72DEA74
	for <fstests@vger.kernel.org>; Fri,  3 Oct 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484126; cv=none; b=F/gwWH68elGtmf2vUtFjgUhwOEQZ53yD5cLEKoWoiZ8KBNb6Hyl2ymD3xhUEPsuttyieR1aJO9YEM3KxDFEguP7/+02KW4vOGNWzLkqlASBPokrAh2VxbvHqBB0oARWD6GArLMGP6EieyFwX+X0Hx5KJrS5Q8OT801MwTP/u2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484126; c=relaxed/simple;
	bh=iP704VcV9TwuIpm8jhivhPESkzrVpMnittyD2c4PXZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sgr4EINgzPAidRhIc7kiSP4tMk70vJHFV1LHPol+ptax31fjho2HEwGeByPiiStlN8wGiX+LcyHIDNFWIgbF+6GNbQGU0WI03zcDAMiljz4zoTeVsE/bOlV6AL/eEQI/dyzwDFuZqsrU6Vvq7b1OR8EyG+UgJbHrIJkSj29UvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCdewMEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCdewMEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759484123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PoxSHvCbr1UV4RUhVsu0NexP55KnHGnjc+JW7ihq9M=;
	b=eCdewMEwu/MT32DoSPmqRJR9eWYRIs1PpxzMGx4rewBnbptiXbvjMh9XQolwxAZYmImFZG
	KSLK3x2cJhFhfyEGrNMVbe2xXZQzvNC/3SKPU8AgIqw7PxSi3rfifcLxM5isAF8TbLw/uU
	Mr9GC64I2+jK4n8P0qOW9v49Wninkpw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Q02Tb0WlMxOBIr9Uf-l47Q-1; Fri, 03 Oct 2025 05:35:19 -0400
X-MC-Unique: Q02Tb0WlMxOBIr9Uf-l47Q-1
X-Mimecast-MFC-AGG-ID: Q02Tb0WlMxOBIr9Uf-l47Q_1759484118
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so13917285e9.2
        for <fstests@vger.kernel.org>; Fri, 03 Oct 2025 02:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484117; x=1760088917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PoxSHvCbr1UV4RUhVsu0NexP55KnHGnjc+JW7ihq9M=;
        b=fMJ2RHaiDVTU8slmmlSBLDKvWTPTYtaMg8MReWpfiKT+0eZAzi7dWMpVPkZS74NwaB
         vYhPtRJ9UdAM58F+KktyffOpZq+lVUDVV9xX9fNx0EGd3b3VLQuOoi5oCHeJBzXLzliG
         6rT8XiaOTElBwMROB14b9Jds5mezv5A2hMUIS6AaHe/4XATVHgGiGq5FZ7JtQZ+OBx0f
         DVzEGOzlU4MseGfiVU5rmg9EDtmsUgoaGHvzEXoBSWn4p6sEC3xdFP2MwgCt74rRWLKW
         ibbdHAGuHC71qc4N91COA/rF9uZqWrAhaoUk0LGEB4l98wVZWgouLrVb82Q+QM33yTSK
         UDyg==
X-Gm-Message-State: AOJu0Yw8lfGzChDUtU+F9sJgICv1k+y8y7It8lBkTPZ5Qzlwahy8tcJc
	pc37AEdpmZDqDKlVgA+dsy6M8SxrMS/QljDoXjBRirh2pcd++nZoXZIAzsoonyamZ2m2RuPDDXJ
	qj5MTdKzdyf1SJteHD0KWWiStzGbFvn9y/AzQa0+ayNBWO/85Ct2hpJs25Q==
X-Gm-Gg: ASbGncsmjkcZQs43DGep/+4xd1gEPg5NH1kRdWuHCXlVsBK1gaFc76CowgBIRHmCvYy
	bBsIi+ZpAzOf/dx+NkEVboRqu0d4ksR3VHJuce8O2wX+dJERXTSymkudtx1ANQPZNPhpRGJ1O24
	kodZ+HKwBav3d/L+J0gzsPOiLofyuMDWM+lZDXjNGeA/HMqMTxAdTX+1Vo4Ik71Via1QjHd2L3G
	BDIZ0t44bTlyCQDbBdXWAsbS1XH57dVi/R33qUX+I7GoIgTPEIpsJm6GtKk6kZBZ1/QCkYXQbZ+
	zxnKkbw3DHef0ZOjkBg1OZUtTqqG8PF4AAC+JoczmPfmU/8x0FOAvSSN5FYelpD5x1psu16E
X-Received: by 2002:a05:600c:3b0a:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46e71140bbemr14206195e9.23.1759484116837;
        Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfbd3Ro3K1biENsTxKxXhS4/gs2QzktTtVsOnNuk3kWFxKAkDjJiRqxFPJQlkIu74ous66XQ==
X-Received: by 2002:a05:600c:3b0a:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46e71140bbemr14206035e9.23.1759484116280;
        Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm121695005e9.10.2025.10.03.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:15 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 03 Oct 2025 11:32:45 +0200
Subject: [PATCH v4 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-xattrat-syscall-v4-2-1cfe6411c05f@kernel.org>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
In-Reply-To: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6564; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=iP704VcV9TwuIpm8jhivhPESkzrVpMnittyD2c4PXZg=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMu7PuKgWMC+IR/2ErFGLHN8WUZnjTKUWB2v37JdnO
 H9vWvb0RYs7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATMQgmpGh12H2wvfGa7u/
 ncz4NuPvqh2Xs9+umR0eb2XjxD1fI0N3IsNPxuN7TuQ2P/XKdJCbdmzmkzm6ccemKm74VBX8j/u
 X8yJGdgDdH0iv
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to test basic functionality of file_getattr() and
file_setattr() syscalls. Most of the work is done in file_attr
utility.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/filter          |  15 +++++++
 tests/generic/2000     | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++++++++++++
 3 files changed, 161 insertions(+)

diff --git a/common/filter b/common/filter
index bbe13f4c8a8d..b330b27827d0 100644
--- a/common/filter
+++ b/common/filter
@@ -683,5 +683,20 @@ _filter_sysfs_error()
 	sed 's/.*: \(.*\)$/\1/'
 }
 
+# Filter file attributes (aka lsattr/chattr)
+# To filter X:
+# 	... | _filter_file_attributes X
+# Or to filter all except X
+# 	... | _filter_file_attributes ~X
+_filter_file_attributes()
+{
+	if [[ $1 == ~* ]]; then
+		regex=$(echo "[aAcCdDeEFijmNPsStTuxVX]" | tr -d "$1")
+	else
+		regex="$1"
+	fi
+	awk "{ printf \"%s \", gensub(\"$regex\", \"-\", \"g\", \$1) } {print \$2}"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/2000 b/tests/generic/2000
new file mode 100755
index 000000000000..16045829031a
--- /dev/null
+++ b/tests/generic/2000
@@ -0,0 +1,109 @@
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
+. ./common/filter
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
+file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
+file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
+file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
+file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
+file_attr --get $projectdir ./socket | _filter_file_attributes ~d
+file_attr --get $projectdir ./foo | _filter_file_attributes ~d
+file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
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
+file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
+file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
+file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
+file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
+file_attr --get $projectdir ./socket | _filter_file_attributes ~d
+file_attr --get $projectdir ./foo | _filter_file_attributes ~d
+file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
+
+echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
+file_attr --set --set-nodump $projectdir ./broken-symlink
+file_attr --get $projectdir ./broken-symlink
+
+file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
+file_attr --get --no-follow $projectdir ./broken-symlink | _filter_file_attributes ~d
+
+cd $SCRATCH_MNT
+touch ./foo2
+echo "Initial state of foo2"
+file_attr --get --at-cwd ./foo2 | _filter_file_attributes ~d
+echo "Set attribute relative to AT_FDCWD"
+file_attr --set --at-cwd --set-nodump ./foo2
+file_attr --get --at-cwd ./foo2 | _filter_file_attributes ~d
+
+echo "Set attribute on AT_FDCWD"
+mkdir ./bar
+file_attr --get --at-cwd ./bar | _filter_file_attributes ~d
+cd ./bar
+file_attr --set --at-cwd --set-nodump ""
+file_attr --get --at-cwd . | _filter_file_attributes ~d
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/2000.out b/tests/generic/2000.out
new file mode 100644
index 000000000000..e6fc7381709b
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
+----------------- SCRATCH_MNT/prj
+----------------- ./fifo
+----------------- ./chardev
+----------------- ./blockdev
+----------------- ./socket
+----------------- ./foo
+----------------- ./symlink
+Set FS_XFLAG_NODUMP (d)
+Read attributes
+------d---------- SCRATCH_MNT/prj
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
2.50.1

