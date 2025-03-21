Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F21E7C0B
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587862; cv=none; b=Mb6q225UKeXw4bktMkkeBIhZFQb0lslR1cv3+Ssdcj5RPXerNaHUtkFCTAwNDUH17tABn48IJ5ZuNARI7nO6bA6aXZrDFkuX3mXCe6v0oF83PHGR2Wey+Jsas/Po15bNSFmsWGjzQSioD3MWt9AjtEnGP5WkqgdusLm5MaCEHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587862; c=relaxed/simple;
	bh=oOPQ6/FgNe8xAoejXal9JbrsT39OlpFqGdIqimkiL4o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhDkMdqjthU5kBv+4SO+00J1TAgCow1/bRXZNQvK0pP1C3OZbBCUIx1RN12lJkv/QLXzFnQKeeO6j+xerR1V7z9/E424P64N+L+N+T/e0YS5yIEH4d2K13753y+7g9HvUku59ocvU98Cppy42yIjLlqQkowln5LYzwXa6wegEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EixWT6RN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EixWT6RN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742587859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iWeFyem8KMe+GU0KjrrkPALKgqB3QBPA9QpSHRJD69M=;
	b=EixWT6RNa4Pna89vUdAJvDef6tuZGodHppzhzXheK7pFJCKnYkHzcmimtNICD/ZeCUvy+o
	SHgT3Mwf6CcdrsPuG6hNRxoV0shYyfgo8Tq94tt+84vSFWfjuQFtvW5526eBuwVMPgOuwA
	cOJ9L7o0LAyyxUJewXpRnoXZppNj/No=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-7HCGq1krP8-Tg_TUhTDquA-1; Fri, 21 Mar 2025 16:10:58 -0400
X-MC-Unique: 7HCGq1krP8-Tg_TUhTDquA-1
X-Mimecast-MFC-AGG-ID: 7HCGq1krP8-Tg_TUhTDquA_1742587857
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39131851046so1036256f8f.0
        for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 13:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587857; x=1743192657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWeFyem8KMe+GU0KjrrkPALKgqB3QBPA9QpSHRJD69M=;
        b=uepH516lFQun6F61vDQQNRjRAyYIOjEiywisnrnbROkxIZODaKAZwwDYkHBUQHQL2C
         j68GzzKHhTkzFIqH1x5GZBg4xe4PH7T4H/HRa17zDyHwfL1TRo7q8KQxZvIr77xD9CAh
         iTDLc1l/g8u6LseE9R5LFgE+xEfwe0RCuqWe6ISPgphq6qFGRQEU9CFLm7fn6SnfUEtT
         Ux+rM/BR5qtWOpCMaRnkaLU5O23Duh/hZFWeSEqjAX87czeXXaO3UQy/WpLhvbbXlHB8
         og49+ocBZ5SnYf+JJWpEzC1QMmf5Oydn/EaC7gVc3vDtD0K2/PRtr7YBDj777G9FHgbb
         JeVA==
X-Gm-Message-State: AOJu0YwA7pCMupCfTdJaDcoXSk71OJK0I9y9LiSDZBljhhCuGL/ikE0i
	wjD7YJxU8qbi9lAqBJrmDvEIO7SldDJuFZOcwvGaZZO9MgZh1qvn09eAYlTfof7LBx/AQm6ftoe
	hsyVBW1UWj1x6gPraX5D4wEAZ9aADIe61CBkDEur69EHujbRzxE4giw==
X-Gm-Gg: ASbGnct8jz7bsKND05OuQiZF5/GIIGuRmMr6OuIcCL52P9OuJudZ/9RrOMAlQljx9HC
	8CllPOTMMvf+vGy1Kwoxs143MPLXdjkddzZcAzZ8vnXhUIUtvvP6iTdrnan2mq7PZ/5Ln3PvNLA
	0OUW/OfmvvPLfw0VOu/co4+eyXbSnRazvOwiEMIhEkotDzO8vMKvVrxHdgBWt+OrN8IaAFqJlRx
	uMjQ9VAtEkmdu6ydReaO01M2W/UAM6EQ+DaW2lgpsprstl2BQGU6Z0npuGIv/gTvY707FSqQZ67
	Sr71QyHUOQIfHfX0RcvwnGqg23ahDL71Y6g=
X-Received: by 2002:a05:6000:1864:b0:391:10c5:d1ab with SMTP id ffacd0b85a97d-3997f8f61d0mr4261049f8f.5.1742587856918;
        Fri, 21 Mar 2025 13:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO0u4JAOR3ePDKvrPEKM6sSv3X5txYWtNi/YYiUC7DgCOXaTDyZfXVRGZVUjGhDh3oWjBkQQ==
X-Received: by 2002:a05:6000:1864:b0:391:10c5:d1ab with SMTP id ffacd0b85a97d-3997f8f61d0mr4261036f8f.5.1742587856479;
        Fri, 21 Mar 2025 13:10:56 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995778sm3289326f8f.11.2025.03.21.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:10:56 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 21 Mar 2025 21:10:55 +0100
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 2/2] generic: introduce test to test
 getfsxattrat/setfsxattrat syscalls
Message-ID: <20250321-xattrat-syscall-v1-2-366175071708@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4396; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=ijosmd3N1uUf6zykL+Qg27EOk7SCpZE6vGZOlcQv4ww=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8eeRTUpNAQeUT/xSLLh2oPp/lsW6GQ9ie5Qi5q/
 wo9w3hdN+OOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE/FvZvhfJLF4cmFq397a
 zv3syWb3ffR67/qW/TUU7xO7MmdznsF0hv8pMTEn03beXmewe+mT/U5Svx2CVCzeimktlpPgvzO
 hMpMBAJlxR7U=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108
References: <20250321-xattrat-syscall-v1-0-366175071708@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-xattrat-syscall-v1-0-366175071708@kernel.org>

Add a test to test basic functionality of getfsxattrat() and
setfsxattrat() syscalls. Most of the work is done in fsxattrat
utility.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/764     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/764.out | 26 ++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/tests/generic/764 b/tests/generic/764
new file mode 100755
index 0000000000000000000000000000000000000000..c8e54173dddd425dd62c8752990bb939e5f12d64
--- /dev/null
+++ b/tests/generic/764
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test 764
+#
+# Test getfsxattrat/setfsxattrat syscalls
+#
+. ./common/preamble
+_begin_fstest auto
+
+# Import common functions.
+# . ./common/filter
+
+_wants_kernel_commit xxxxxxxxxxx \
+	"fs: introduce getfsxattrat and setfsxattrat syscalls"
+
+# Modify as appropriate.
+_require_scratch
+_require_test_program "af_unix"
+_require_test_program "fsxattrat"
+_require_symlinks
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+fsxattrat () {
+	$here/src/fsxattrat $*
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
+fsxattrat --get $projectdir
+fsxattrat --get $projectdir ./fifo
+fsxattrat --get $projectdir ./chardev
+fsxattrat --get $projectdir ./blockdev
+fsxattrat --get $projectdir ./socket
+fsxattrat --get $projectdir ./foo
+fsxattrat --get $projectdir ./symlink
+
+echo "Set FS_XFLAG_NODUMP (d)"
+fsxattrat --set --set-nodump $projectdir
+fsxattrat --set --set-nodump $projectdir ./fifo
+fsxattrat --set --set-nodump $projectdir ./chardev
+fsxattrat --set --set-nodump $projectdir ./blockdev
+fsxattrat --set --set-nodump $projectdir ./socket
+fsxattrat --set --set-nodump $projectdir ./foo
+fsxattrat --set --set-nodump $projectdir ./symlink
+
+echo "Read attributes"
+fsxattrat --get $projectdir
+fsxattrat --get $projectdir ./fifo
+fsxattrat --get $projectdir ./chardev
+fsxattrat --get $projectdir ./blockdev
+fsxattrat --get $projectdir ./socket
+fsxattrat --get $projectdir ./foo
+fsxattrat --get $projectdir ./symlink
+
+echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
+fsxattrat --set --set-nodump $projectdir ./broken-symlink
+fsxattrat --get $projectdir ./broken-symlink
+
+fsxattrat --set --no-follow --set-nodump $projectdir ./broken-symlink
+fsxattrat --get --no-follow $projectdir ./broken-symlink
+
+cd $SCRATCH_MNT
+touch ./foo2
+echo "Initial state of foo2"
+fsxattrat --get --at-cwd ./foo2
+echo "Set attribute with AT_FDCWD"
+fsxattrat --set --at-cwd --set-nodump ./foo2
+fsxattrat --get --at-cwd ./foo2
+
+# if error
+exit
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/764.out b/tests/generic/764.out
new file mode 100644
index 0000000000000000000000000000000000000000..0dc8e973909c0e486c3662b9beba7deb1e495ba6
--- /dev/null
+++ b/tests/generic/764.out
@@ -0,0 +1,26 @@
+QA output created by 764
+Initial attributes state
+----------------X /mnt/scratch/prj 
+----------------X ./fifo 
+----------------X ./chardev 
+----------------X ./blockdev 
+----------------X ./socket 
+----------------X ./foo 
+----------------X ./symlink 
+Set FS_XFLAG_NODUMP (d)
+Read attributes
+------d---------X /mnt/scratch/prj 
+------d---------X ./fifo 
+------d---------X ./chardev 
+------d---------X ./blockdev 
+------d---------X ./socket 
+------d---------X ./foo 
+------d---------X ./symlink 
+Set attribute on broken link with AT_SYMLINK_NOFOLLOW
+Can not get fsxattr on ./broken-symlink: No such file or directory
+Can not get fsxattr on ./broken-symlink: No such file or directory
+------d---------- ./broken-symlink 
+Initial state of foo2
+----------------X ./foo2 
+Set attribute with AT_FDCWD
+------d---------X ./foo2 

-- 
2.47.2


-- 
- Andrey

