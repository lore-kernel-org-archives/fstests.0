Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1E350D52
	for <fstests@vger.kernel.org>; Tue,  9 Sep 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431567; cv=none; b=jWriHpxNa+xz92IljvaMStvNLa9npQsmecJp1xzGARZVy/qR2lSYFaqaJ52fLBLBBmR0tBypodUCUcqeIa2yDUCR1ZSGC3oEjqJedjzMGq5h38XhrMWQTb9Wc1XFnoSaG9ghcTe+Tsr4UnbE7vwPCzro0YUjXvsb0Lrtvtb21LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431567; c=relaxed/simple;
	bh=FK9ckZlUIT5NP6l4ajjq7S2PGhEFaswizWRppgSgHXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aucdNw/OgJO12KusjgCc8a7xzeCdJUUoV3VcDYUJbQfVcwnNkLmyGDdCgzCz1eph/ceNoo1B4CjYQdiVX7Q/m5NcrkhBURRg1UCtjW2PoU5elRBao+LkQpMRf0ZqEgGER0EZQ/TCEJigp/XJ4v8b1no4KAz3XDsWMXGiPjjoMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNplObjz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNplObjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MR82k89loQqbpWRhbWbGHqwEmrwV8ovuS9azBDHWF0g=;
	b=WNplObjzZslbj+hEDhAa1MfxQc6ShawRRKBvIcPXALW9kx8X9wNuKdcexQxKbBIhcDJd7j
	1eavz7jlogNlGsGCGOX/+zIBC77gu+RgvW5j2PeXcNFucxibZgo9iul6jhcqgmsUeb3IRi
	S4E+oyX4/67UQcB85sX+AymlFZWkklU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-nw5wDaztMXeszE0Wm5J8_g-1; Tue, 09 Sep 2025 11:26:03 -0400
X-MC-Unique: nw5wDaztMXeszE0Wm5J8_g-1
X-Mimecast-MFC-AGG-ID: nw5wDaztMXeszE0Wm5J8_g_1757431562
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de27bf706so13487335e9.0
        for <fstests@vger.kernel.org>; Tue, 09 Sep 2025 08:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431562; x=1758036362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR82k89loQqbpWRhbWbGHqwEmrwV8ovuS9azBDHWF0g=;
        b=ATF3Mb2/XePfblhWwv/6l6AYrvziF5prx/+MAx90lgBZ/NcfBjZ/J5Or+5UCoSdFX7
         v2T6Pc8H4ih5uXuaFOcS7lkrW9kNtYy48u15uIpD4Mph+urrgytS5opR6dRSXgYfWiWR
         4y+xX1J3of1WK1gZguEVNLEGR0CtLGSs1UQOU4bXEgKvrMsxOmi2MUCCKXFpIJdEtCWd
         SjpL0Dc5Ny7TeWlfepyegIi3WlsunNS/MzPYB0YVl02WucK81VqIKEaOBZuayhp8duGy
         hrfLRVlZw4qq1aW8nr/Q29XDOCUyXTjkUJPVoawOU/yh+IC4j/uPRLZZcHjeHo0sHIYc
         is9A==
X-Gm-Message-State: AOJu0YwX1g0uV2Im/w12mf8ssZFdBh09EW6Ui5OJF5WXXM0Sjy/uIFlv
	1F9zHPA1MwiLMyFAz1zF+X9N/lHg6HiXZUUpKkkYgyKM4zJ/HGXhTVjOz0LdnMlwNF/ykUQantM
	iL85XjfaSMtyOltTwL86st9tGeRsBMt99MkicRDVg+oj2QFSrSj+fV7uQpg==
X-Gm-Gg: ASbGnctE9w3GgQiHqgEuX4qvnLQYcFn+7XRNEOHVRu2OgoJtKZrjng4Hpsqk/yfu99e
	mi8UQS41juNnS+p+b0wBINZpJ23MaBLbk7izSSA83uHtBmww9so3QJZm7T0pdGH4KL7CaqTNGRL
	BdNHoYNuIz7OhoPvGD1ciiAe1M37xwx+0NcNOO04th4Uvs1qIMMk0oRITyxR/eG4ehjPlusfFXA
	9sxgETnVkuLtOi0uCnfbyW1OMbLU3KgcttHIwIyaSNNEQ1vQCFowA1yDjdk3cU02JsNpzjqSQZ4
	oWzOkIqohqKiSR6zV26GZTFIyY3j5QG9FrMFpLc=
X-Received: by 2002:a05:600c:630e:b0:458:bd31:2c27 with SMTP id 5b1f17b1804b1-45dddee9c7fmr100645805e9.23.1757431562412;
        Tue, 09 Sep 2025 08:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCnPMWACOsDM1uMYMYJeKmOJ1pT+RNybfKT+ByO64ivr4ZEE5yLV7x2NlpjEG+APPAEop5iQ==
X-Received: by 2002:a05:600c:630e:b0:458:bd31:2c27 with SMTP id 5b1f17b1804b1-45dddee9c7fmr100645575e9.23.1757431562023;
        Tue, 09 Sep 2025 08:26:02 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm348550005e9.21.2025.09.09.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:26:01 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 09 Sep 2025 17:25:57 +0200
Subject: [PATCH v3 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-xattrat-syscall-v3-2-9ba483144789@kernel.org>
References: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
In-Reply-To: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5333; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=FK9ckZlUIT5NP6l4ajjq7S2PGhEFaswizWRppgSgHXo=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg64s+9IPbX0rIfrtMWar+IkOpa9yFDpb9/ssdN1o
 uHXlnP91Wc6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATGSXDCPD1gkztpjVJnhc
 WOvGJJ1TarZHP2q++Pv3iy9s43l9c+Z7VkaG0x8+PMxK7HN6fLzwk6zixD0b0+Ya9cxOjZjDadG
 auec9IwC51UmP
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to test basic functionality of file_getattr() and
file_setattr() syscalls. Most of the work is done in file_attr
utility.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/2000     | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++++++++++++
 2 files changed, 146 insertions(+)

diff --git a/tests/generic/2000 b/tests/generic/2000
new file mode 100755
index 000000000000..b03e9697bb14
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
+file_attr --get $projectdir | _filter_scratch
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
+file_attr --get $projectdir | _filter_scratch
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
index 000000000000..11b1fcbb630b
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

