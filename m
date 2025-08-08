Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F982882B8
	for <fstests@vger.kernel.org>; Fri,  8 Aug 2025 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681543; cv=none; b=amz9mM+AFcjN8fbqhA2LiOrLwUlx2HH7fjek5Gu6kULEJboPM01n1wUgm64ZeQdOPhMqm7auYeg6n/UjsbeesGNPj5gf2S62Shg5XNkCu+k0UbRCEB7DZBBDv6CA0ysbeJo+e/Bk1kx0eWgBWSGvjpkkwo/hbG367BtMhikapUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681543; c=relaxed/simple;
	bh=rd0gHPs9r3n1uqaeogh6lISRfiKMIbMIwGCvZPqFvjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWJ8ePgYM1D/o8O4irXcERYmkFFDAgv15jHp5ugBC/bpNcmJG7OFJjWK/GQOKu5BKDIrainpJCRVKk056pkn+sDRkUs20Ef9R/OYjxIriD8FblGdWVw3m4kvR49V8f8Rozt3ncZzueBxXWrR5SBHFYWTdDofGfjW9dAUQHWRGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwi8hDZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwi8hDZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DY1Hu90O7055hYQlq+ozgQX5TkAPtJWGsG/dYblQRY=;
	b=Rwi8hDZUXb8hKN1FxkNPOre6NxASH3e8pPmEeVU4DJtZY99Z60k61BahEDSd9E/oMQh0F1
	JTlnTLTV4CKnviFg//ETsTx8vnEUia4WXQqjOrLCCRhOMS+BM+yqTv7orveNIk+3hEtBEj
	pFyNv2f4TGM6Xldf6kVm1Zhu97KZig8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-mA3s0xNWOIeJGI8Fqm6qJA-1; Fri, 08 Aug 2025 15:32:19 -0400
X-MC-Unique: mA3s0xNWOIeJGI8Fqm6qJA-1
X-Mimecast-MFC-AGG-ID: mA3s0xNWOIeJGI8Fqm6qJA_1754681538
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-458f710f364so16660015e9.0
        for <fstests@vger.kernel.org>; Fri, 08 Aug 2025 12:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681537; x=1755286337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DY1Hu90O7055hYQlq+ozgQX5TkAPtJWGsG/dYblQRY=;
        b=cXI1lbl5h/bXZx3w9yOo7MF0TSCkurt7BnpDFVDyu2ANFrAh+Yf3yA12mQ8/bFAvXQ
         LzGY1wJXCyyc8FMpfl5suqzyzVCCKkXPw0i5BW67tH11a7sASDkWpUXqj/8IZsnytux1
         ohV8rKfVnv6lcrjX0j8eAEtyz4eLP6zf2uqRUpeKBgcGhLWvVG4qHUExG/U8NVqToHOS
         DTH0DZO1PMDnfFejEr1ovo/wMeSg7bazLJumIYPtIzP2ZO4XAKwTETg+3TBz4VxTkC8p
         doIQZhiGSND+/TrtWkzXNaVKuA7QL+gGncWpVgv7ukwbdYFttrZHatDwdjjwKST+ztkc
         dETw==
X-Gm-Message-State: AOJu0YxT3xvzNqk/bgiYOYKq1Pwh11q40QaO3/nmNPy3syV5FRvZoQQq
	SQ/gGLyjLVm2/JS1WW4AQHbt4TRH+qZKyblQ+LwNwMSPlpgre7aAeydVQ2woxTRyRmyVUYIb5+s
	M7t1s5UD1VAxacpaNMusdnPe7/w3Ow7pkIGOJJnczrLsYokpP4cuqmeBGyAX6zWIRFsx1qqNIfy
	GzdyRs5A6Rjw/KXFFvKWoRJt2/l+6beiMTXl3MunUO9Q==
X-Gm-Gg: ASbGncsE0EkkrYzoxiE622Edt/JhrjBqdz2It5FKoHwjF5nStXv/1RpkXQyp63SDQBn
	5WKht4FtlDq34Lk8ht1afPKXoJl/y6MyvITFgpNiRJrYuskS6cY7ynqogvWyidbnEaf0YpE8h5c
	taxEebhrOPsRiE32tM7gNwU8kFa7AnlEcDKZ6QlXSJcH+SfYespAosrSj5CJ+xs1Q9/I/Vih8GT
	qlZS2FMKtLUPNApoHQPM9fPlBHVkXitYcLoCFwLQQBIQFNpqNXNB9kTEeMdRZiP89DLL4Qr3coJ
	30ANEfJJz2W0i+4o3NeRCBtDC+c21vZdodORmOpkPrHNQw==
X-Received: by 2002:a05:600c:1988:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-459f4f0f55bmr33822105e9.22.1754681537463;
        Fri, 08 Aug 2025 12:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Zzp0+e8x86fu4vkp2zl133cRaxb2jV1ttAjta9TTzPN3gXe0PibXkLKt2GjRw6aWnewDbg==
X-Received: by 2002:a05:600c:1988:b0:456:214f:f78d with SMTP id 5b1f17b1804b1-459f4f0f55bmr33821805e9.22.1754681536917;
        Fri, 08 Aug 2025 12:32:16 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm164906135e9.17.2025.08.08.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:32:15 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:31:58 +0200
Subject: [PATCH 3/3] xfs: test quota's project ID on special files
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4286; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=JD0ZSorQ60c/tMR/lOTbqcoU/0PVcdELTNmMcs0rJ7M=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYF7FViWNvIkifo6s3Npn1Hz4jnjZxTQ3eLxI+b5
 zt7y2p+fukoZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkTfPGBn+f+J2+3uDyXPH
 a1udjV7H2LL+X92rfUxulsSJqSFlu74UMDLM9tvkIrfvc/3r775Lz/JNfHV2JYMahzcfo6PifKa
 PhZXsAGntRho=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

With addition of file_getattr() and file_setattr(), xfs_quota now can
set project ID on filesystem inodes behind special files. Previously,
quota reporting didn't count inodes of special files created before
project initialization. Only new inodes had project ID set.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/2000     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/2000.out | 17 ++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tests/xfs/2000 b/tests/xfs/2000
new file mode 100755
index 000000000000..26a0093c1da1
--- /dev/null
+++ b/tests/xfs/2000
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Red Hat.  All Rights Reserved.
+#
+# FS QA Test No. 2000
+#
+# Test that XFS can set quota project ID on special files
+#
+. ./common/preamble
+_begin_fstest auto quota
+
+# Import common functions.
+. ./common/quota
+. ./common/filter
+
+_wants_kernel_commit xxxxxxxxxxx \
+	"xfs: allow setting file attributes on special files"
+_wants_git_commit xfsprogs xxxxxxxxxxx \
+	"xfs_quota: utilize file_setattr to set prjid on special files"
+
+# Modify as appropriate.
+_require_scratch
+_require_xfs_quota
+_require_test_program "af_unix"
+_require_symlinks
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1
+_qmount_option "pquota"
+_scratch_mount
+
+create_af_unix () {
+	$here/src/af_unix $* || echo af_unix failed
+}
+
+filter_quota() {
+	_filter_quota | sed "s~$tmp.projects~PROJECTS_FILE~"
+}
+
+projectdir=$SCRATCH_MNT/prj
+id=42
+
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
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -cp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# Let's check that we can recreate the project (flags were cleared out)
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
new file mode 100644
index 000000000000..dd3918f1376d
--- /dev/null
+++ b/tests/xfs/2000.out
@@ -0,0 +1,17 @@
+QA output created by 2000
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Checking project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#0                   3          0          0     00 [--------]
+#42                  8         20         20     00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#0                   3          0          0     00 [--------]
+#42                  8         20         20     00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).

-- 
2.49.0

