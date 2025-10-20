Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FB2F658A
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968569; cv=none; b=szgxs0OPxauqcFBBXbspASOpr8F9YGKZl4mriZBTqkz1HBIPxYLvkJBZsCcmSiV62hX3Zy7ksEnGLXxpLQ0YvfpkqmG/G4l5JGAbLrF9b/ie4avJBHbhe5G0gs/m9hp8xzP+e0zNLljENG4W1nHF0qJVXQADbUuFiB6mI5/kY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968569; c=relaxed/simple;
	bh=LiU1Kcnc/xXDInRfq9a5/iHVaT7mrnGXtbWirlJdHkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANGVaYi+HjhSO3zoq+foD8gsku8cD31OtqyEud/jdFNEmLxfGbshO94zO2hSHluKiv77dQURa+9ChTU75LdNui3FhjiLjOZGdOCL06JLowQOXQQIcAcrzMJD6qpKG57XOOaQBjhCUxyz6NrTbULFJCN49iztaOWtfgBoKBqqdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSfy55cf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSfy55cf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760968566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnVCSabx+0xkqqq3zNHBKS9lr9pABGnoboH7bSSoM4k=;
	b=WSfy55cf9ITc6UdUi86LC4d8BBbW1lt7ySv9UTR45IUBMMbTc21QDYLl8AAZNkgSRIQ1Ar
	wepa5cS/GzOBn/vdfGz4li3YWdu9GkrBaWk1XgsxufSEbvefIevYoLVbUWJwhOEgr1AS3p
	Iw0TpuyNd8a53GlEuKDcLL2tB+9Le+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-e9oz_aF8Og2-j8MvpcVM7w-1; Mon, 20 Oct 2025 09:56:02 -0400
X-MC-Unique: e9oz_aF8Og2-j8MvpcVM7w-1
X-Mimecast-MFC-AGG-ID: e9oz_aF8Og2-j8MvpcVM7w_1760968561
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47111dc7bdbso33901305e9.0
        for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 06:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968561; x=1761573361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnVCSabx+0xkqqq3zNHBKS9lr9pABGnoboH7bSSoM4k=;
        b=FZVKVS8cp9wF8s9dShIfEICW1u8auA6wD7DyysS2H3fP8k+gCwFWoKER33ftFsalbV
         7xuxNwvckVC1uSxT0JxS49X8KWxdUxbcXQSupOStvLzvGaZM/m+GxCkC8YN0akpDHmJ5
         da1hcq13fmn0qNGFp5fVd13z1zaf/dNUBqDpYMBvGQjjZLGRH2aaQZ5vAFRS0J0UidvY
         nH7laYTuc5qN5PM02JRu8e6pD8fi4vv7TK44mvy8SqqYYB8Ea5zmuWKGk05hq++CR34r
         m9FeO2rXmxf0WgQfnEWaXiURTE4zJ8u/cumSuMg0kEeqVTuC4HAHH3mPa3gMIAfZmjD9
         5OMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTNKV/p/0wdo3hcJ1iDIWNCzG5glT1aKF9Bgxn5nd54dAsF5rYgxP1rVpyoTDQa8++GOncKnKh@vger.kernel.org
X-Gm-Message-State: AOJu0YyHoHQlKu9B7tEQ1lVom9xqwAvrcBoI5QzJbERitQUyw5iaorvt
	OZUTZxo2ylaYUDHi9wbkSJZHrVPhxG+2hsmCIr431nHnskbm46LNGLYFBvaBmZOQymJG6suzUzu
	hJrZw5Rsqh50bt4cZtGnLjN5z2xGqnGmceXJQhOeAOlzUMgomCfi+byE/nQ==
X-Gm-Gg: ASbGncvn6u9CMg6aioQGaMD4ZAqaCk7+JJZdwjFzB2fpyf8T+QbQaYTIW0wnQxsjB0r
	oDpmYbsaQw54cdCN3VLFxQLrTbyvHbEz8jelfjGRKEsef/+JX7nxA7n3Unx1Zk+Us+weDuacemI
	jD4OXw73U3iTMZmNrTcC9sz9zW0/jiuUjS3z2eF+3bcRnNNa1nWRGkckilsbMrcMnl/gf4iNNXN
	ASRYnjcmxMUGUZTYRJpD4NOkD8wJ/DHskwdXXPrDs87YYGFZcGuCKRno3fWZuP0A57AZFvxu50u
	tG5rbEi1jnom0EmuYdbE28sDoGbFBZnIlVrj5GrKWWBZgeIV83Sbi1gYGl/brc8Mm01vVo3Cl0W
	Bm6XelvLoDRltVcNaRIS4QLAs06j/9uZ/Xg==
X-Received: by 2002:a05:600c:681b:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-4711792a6bemr104228215e9.37.1760968561063;
        Mon, 20 Oct 2025 06:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWqnw97pmYKSKEGBfX2T590QI21UcBjSDyt1Nq7yFQpR4T8AIyPG4MYQImAMV81pZkhOIllw==
X-Received: by 2002:a05:600c:681b:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-4711792a6bemr104227955e9.37.1760968560517;
        Mon, 20 Oct 2025 06:56:00 -0700 (PDT)
Received: from thinky.redhat.com (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm151404645e9.6.2025.10.20.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:56:00 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: djwong@kernel.org,
	zlang@redhat.com,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 2/3] generic/772: require filesystem to support file_[g|s]etattr
Date: Mon, 20 Oct 2025 15:55:29 +0200
Message-ID: <20251020135530.1391193-3-aalbersh@kernel.org>
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

Add _require_* function to check that filesystem support these syscalls
on regular and special files.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 common/rc         | 32 ++++++++++++++++++++++++++++++++
 tests/generic/772 |  5 ++---
 tests/xfs/648     |  7 +++----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index dcae5bc33b19..78928c27da97 100644
--- a/common/rc
+++ b/common/rc
@@ -5994,6 +5994,38 @@ _require_inplace_writes()
 	fi
 }
 
+# Require filesystem to support file_getattr()/file_setattr() syscalls on
+# regular files
+_require_file_attr()
+{
+	local test_file="$SCRATCH_MNT/foo"
+	touch $test_file
+
+	$here/src/file_attr --set --set-nodump $SCRATCH_MNT ./foo &>/dev/null
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
+	local test_file="$SCRATCH_MNT/fifo"
+	mkfifo $test_file
+
+	$here/src/file_attr --set --set-nodump $SCRATCH_MNT ./fifo &>/dev/null
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
index e68a67246544..bdd55b10f310 100755
--- a/tests/generic/772
+++ b/tests/generic/772
@@ -20,6 +20,8 @@ _require_mknod
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
+_require_file_attr
+_require_file_attr_special
 
 file_attr () {
 	$here/src/file_attr $*
@@ -43,9 +45,6 @@ touch $projectdir/bar
 ln -s $projectdir/bar $projectdir/broken-symlink
 rm -f $projectdir/bar
 
-file_attr --get $projectdir ./fifo &>/dev/null || \
-	_notrun "file_getattr not supported on $FSTYP"
-
 echo "Error codes"
 # wrong AT_ flags
 file_attr --get --invalid-at $projectdir ./foo
diff --git a/tests/xfs/648 b/tests/xfs/648
index e3c2fbe00b66..a268bfdb0e2d 100755
--- a/tests/xfs/648
+++ b/tests/xfs/648
@@ -20,10 +20,12 @@ _require_test_program "af_unix"
 _require_test_program "file_attr"
 _require_symlinks
 _require_mknod
-
 _scratch_mkfs >>$seqres.full 2>&1
 _qmount_option "pquota"
 _scratch_mount
+_require_file_attr
+_require_file_attr_special
+
 
 create_af_unix () {
 	$here/src/af_unix $* || echo af_unix failed
@@ -47,9 +49,6 @@ touch $projectdir/bar
 ln -s $projectdir/bar $projectdir/broken-symlink
 rm -f $projectdir/bar
 
-$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
-	_notrun "file_getattr not supported on $FSTYP"
-
 $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
 $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-- 
2.50.1

