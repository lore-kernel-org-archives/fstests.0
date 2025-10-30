Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025B157480
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838227; cv=none; b=cHZKlHxli4bmlCbZ3EoILAxAb6P1QVbtHX1NmCwfyLNrNzVwrq/cRbEyqowZV4xHOAP4ro3ZbefbRrN/Mnkq5r6S8WRGEndevE5ki0upf8rG8hhm01KmgVOf4JTRRgCKdu6eP6sTbiu78Dqdw5mb8GC8aM3k5eWq1oUn39f4ehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838227; c=relaxed/simple;
	bh=3AloyVglmOTk+TiFMUOT0YM4XZ0tQXtc4q0G2lCx1OU=;
	h=From:Date:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe/eGpW+ZXboz8q1WsnvhngDycCxUmel2beFZ5bvWyKqIqxt53cHDsHFrmq/sy5S5V3Drb13ogT9KY7Ix/F8xuRf1ygOSYrtpB8uhSlIRL6Aza9/zi+YE9vWc6ZF4nzify6pQ+og8gsVW1WUOT73vnQ6iCPAFC2H6wzwMLJkRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBPa1woQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBPa1woQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761838224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUu1yBTNL4cBNSwGdAYBFfnUHF6zEEDgoeLt2AaYzLc=;
	b=LBPa1woQfSumfxYQVuBcAOZHZrcG/kv+OTcpp730UtxypSMkxA9/YiV62pP73Q05dI/Rx0
	i7DeJm3gRxHhIu+93sAOzJGMwYIzhPaksryeY71WrdADLRTIDXqSo1++G93VxYwB7t/jnQ
	9lTojjkpez4tV8aUOmFYBTWH/SZaxPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-j1SJpB8JOKGsUtOiFXre1Q-1; Thu, 30 Oct 2025 11:30:23 -0400
X-MC-Unique: j1SJpB8JOKGsUtOiFXre1Q-1
X-Mimecast-MFC-AGG-ID: j1SJpB8JOKGsUtOiFXre1Q_1761838222
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47113538d8cso6186235e9.1
        for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 08:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838222; x=1762443022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUu1yBTNL4cBNSwGdAYBFfnUHF6zEEDgoeLt2AaYzLc=;
        b=UjoJ8sK/Cv6eWbekvCZeBEHmU5b6LK/Flsn4OvIsdrv1/jP5tg/bW8ySb1nLQXTHWT
         QlzXUFMPHjggPnwsowXGsxrKSJe/i0W5Vb50RQEdIpormRrfczfLKhXGiuKYBoReyyzT
         j2MQ6y+XmdMmOGmcmhZPyx88TTFJSX/mUxPWUolP1nQR0HYgrg8mQt4xDT7wiI3QJzhq
         jINqx+Xp7IntQlv33korEGbL6Zqb1jgL5dDQB7T6TsWTuYaSf0MjAlz7odwA1SeFyW3o
         7p7YrMXrQvS2vqZHtdZ/XYaNJ4dsqxUruqf7OkxgVRJi8yrF3Y+ULa9G/sgGLxDR8KQ7
         xyaA==
X-Forwarded-Encrypted: i=1; AJvYcCWi+vzIxaCJJuhNB+SlFISnC4xbGNlplmUQeATKzHs9CNSeBv/wekzT8i3qi5rzx0XS4Cy6jRpB@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQYYVkT6NXvj7gMNh7K+ls4FFBmcnJdIIfwII6zccgH8ltms1
	sYTd4hYy9+E4s1p9spsWqe+A9mLT/F0npBuzkCoStLjINTsBTeRes57G8cfWLwWKWmQayhkfeJX
	C5vpy3re9YQOPEyG4p8dUDEw4YTNXrDmfZuxDkqfgYuYz1qpSMRluLabK8YS/iQ83ig==
X-Gm-Gg: ASbGncvXFpJ3Hbg3klbPbbt1TCFtVwYWvCMnkOGRPj2dy5hPsLY4Igz7u7pTPxHyLAF
	FaA0zcqAg5Hh6UPRFFbj8v7m0tIyU0TLWSXuVjHVAtztdt48Kn1828Io3HznCb8nRdj7QSxQoAV
	QGTeal1P8NOizxF9zD+sMf9qRFtF8tnsQ86YYUv36l5WDvF+WjplXhcYMgYtbHm1/Kx+S3jVNSg
	RhSYGNFqGtmhQqAKPHCXLDLunfEm2Opdbbm4x5P5pkPC00ZXHc5qFwQwK+zo5Bzs1GRVFfML/sG
	Q256yRWSakEDWUwQgzZYSnEXiW3iUFTWdAHq5YYICfwDlySUIWsdp2vD6lK7G3sN
X-Received: by 2002:a05:600c:190e:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-47730801f19mr1119995e9.9.1761838221678;
        Thu, 30 Oct 2025 08:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE8jDLUAXDGJEJfUwRsC6CCUCM4/AEui3HqIXh7PfXdY52cNBdW1IYjgugolZtyPVJoR2KGg==
X-Received: by 2002:a05:600c:190e:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-47730801f19mr1119675e9.9.1761838221131;
        Thu, 30 Oct 2025 08:30:21 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477285d1e43sm57176465e9.0.2025.10.30.08.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:30:20 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Thu, 30 Oct 2025 16:30:20 +0100
To: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, zlang@redhat.com, 
	djwong@kernel.org, aalbersh@kernel.org
Subject: [PATCH v2 1/2] generic/772: require filesystem to support
 file_[g|s]etattr
Message-ID: <lwdr5ntyyszcvqe75ljcqtpcrtjioopoa3abm4fjrdupfmrmx7@2jebme2cchx7>
References: <cover.1761838171.patch-series@thinky>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761838171.patch-series@thinky>

Add _require_* function to check that filesystem support these syscalls
on regular and special files.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 common/rc         | 32 ++++++++++++++++++++++++++++++++
 tests/generic/772 |  4 +---
 tests/xfs/648     |  6 ++----
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 462f433197..be3cdd8d64 100644
--- a/common/rc
+++ b/common/rc
@@ -6032,6 +6032,38 @@
 	esac
 }
 
+# Require filesystem to support file_getattr()/file_setattr() syscalls on
+# regular files
+_require_file_attr()
+{
+	local test_file="$TEST_DIR/foo"
+	touch $test_file
+
+	$here/src/file_attr --set --set-nodump $TEST_DIR ./foo &>/dev/null
+	rc=$?
+	rm -f "$test_file"
+
+	if [ $rc -ne 0 ]; then
+		_notrun "file_getattr not supported for regular files on $FSTYP"
+	fi
+}
+
+# Require filesystem to support file_getattr()/file_setattr() syscalls on
+# special files (chardev, fifo...)
+_require_file_attr_special()
+{
+	local test_file="$TEST_DIR/fifo"
+	mkfifo $test_file
+
+	$here/src/file_attr --set --set-nodump $TEST_DIR ./fifo &>/dev/null
+	rc=$?
+	rm -f "$test_file"
+
+	if [ $rc -ne 0 ]; then
+		_notrun "file_getattr not supported for special files on $FSTYP"
+	fi
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/772 b/tests/generic/772
index cdadf09ff2..dba1ee7f50 100755
--- a/tests/generic/772
+++ b/tests/generic/772
@@ -17,6 +17,7 @@
 _require_test_program "file_attr"
 _require_symlinks
 _require_mknod
+_require_file_attr
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
@@ -43,9 +44,6 @@
 ln -s $projectdir/bar $projectdir/broken-symlink
 rm -f $projectdir/bar
 
-file_attr --get $projectdir ./fifo &>/dev/null || \
-	_notrun "file_getattr not supported on $FSTYP"
-
 echo "Error codes"
 # wrong AT_ flags
 file_attr --get --invalid-at $projectdir ./foo
diff --git a/tests/xfs/648 b/tests/xfs/648
index e3c2fbe00b..58e5aa8c5b 100755
--- a/tests/xfs/648
+++ b/tests/xfs/648
@@ -20,7 +20,8 @@
 _require_test_program "file_attr"
 _require_symlinks
 _require_mknod
-
+_require_file_attr
+_require_file_attr_special
 _scratch_mkfs >>$seqres.full 2>&1
 _qmount_option "pquota"
 _scratch_mount
@@ -47,9 +48,6 @@
 ln -s $projectdir/bar $projectdir/broken-symlink
 rm -f $projectdir/bar
 
-$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
-	_notrun "file_getattr not supported on $FSTYP"
-
 $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
 $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \

-- 
- Andrey

