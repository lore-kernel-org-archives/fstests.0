Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24A14A619
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616827; cv=none; b=D3ECxUSWHPBkMGgS7rNCZvPAfXlSs6x7LL1NeNM6PhBFc/EcDuFnNfGb+W2AOcyf1zo1UoPJsZLt4RFH5EnEqWIHSXpv0R33WjCXptiIfbT21GXhNOysS4ZoXFzL0HYgng51SG17KxprikE9mVgd4OhVk8B6BX5q+cw9z/zd0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616827; c=relaxed/simple;
	bh=TyT8szDBIbz4mMrawqCMBHWPSUdl6UFYmX1E4Lba0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aREss7WCAnf4Le3fS1Uz+oyMhTbdUJcrMyBnuHMORL5u/ESCa6v971JNXWOLeD1qwFJw07s7tAE/t3wpmg4NTp40SQqtbHlLCIv1yWDD2qnjSs194neD8ElQSTVjYGoPViKp2yPLNgq5mkzWcSwCGY0btfTQvogQ6W7is8KWb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVyhELNL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yi+hwBLI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVyhELNL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi+hwBLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787616824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGOFkIdEbZrol3quuEIOkzSJDPF65uRGyS+lKWbNM+4=;
	b=FVyhELNLcCAnsw+f0ucyp9LlrKAJzL1cW1BArOLtilnYVAJTRYFMq2RmdIaBaVC16SinKW
	y0g1FtTGeZVj45oeg392qaasWmcwZfBRxX6Oux3sx/mr7VOHHWnTcnjZJq5NUeiAih6997
	Cw7T9xulCAkmPRSVvMgG+FyvWp9XVOc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-W0U6eAAaMLmMhOm6m8EvlQ-1; Mon, 24 Aug 2026 20:13:42 -0400
X-MC-Unique: W0U6eAAaMLmMhOm6m8EvlQ-1
X-Mimecast-MFC-AGG-ID: W0U6eAAaMLmMhOm6m8EvlQ_1787616822
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7eb60cfd476so8496671a34.3
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787616822; x=1788221622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SGOFkIdEbZrol3quuEIOkzSJDPF65uRGyS+lKWbNM+4=;
        b=Yi+hwBLIFdN5TlIGfCg+wzgN+LsaxGWWh5xpa+QEs3Ld0GXUN4/9YKIu8TbS37kZdv
         4o+D0b+mDlJYNpL9Qzpz4NH9Qqd32TZ6H8UbgMC2HJ9z6mSCNTaLdr0Ec/EH2/WYXyTn
         Wo9P8KwcPR0xVhVnSSOcXMGk6MvZ2qzasbPH7bD/nSgHamS9Nqm+4GjIViprCQgaWSuZ
         wARrEMQfI5Y7+5kWNc4jL0rgFaBQp82o0T+kRTuUMZCS38DkLweZaIxDwJZOOQQ0aNVR
         g9A9dplLQS9x8mG4Gsc0j2wPrD9BN2osPHDvOsvdfITyUmRzNo5wlovEVYWcrVFXmvYw
         BkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616822; x=1788221622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SGOFkIdEbZrol3quuEIOkzSJDPF65uRGyS+lKWbNM+4=;
        b=X20FEMNIQyihH1Wi5Lyrc8QNmn3wmVanvvSPwj3IcX6X56/gcO/rAbBTUm32ntzk+b
         CaXj5ZquhefCAEe7Wesv6qfHHf2f6EyW0e+jIQmX3F15XZUQBpIQdFvDpYERuQXlpmIN
         C1AhhOHzJwaC2ioU6qWzCDXRNHNTeYWJJNQT8qjka9peeQYtbAkzvq5w07iv2siJ2blT
         ZJtMX2pbSfBQJSDQIXWIvvhriSp0+JDRRVpWkAWv5wOTx+lsU/htWcejfstwMsZSrLq2
         gTHHzRXCFm8vjv8c8jPRAzyfdFrCdtrJg+l6EeQUAjc7/3fEEOKZicmMOswAoAx67WWY
         6g4A==
X-Gm-Message-State: AFuF++nG5PRIzZySUnRv7xl+lC/PF1Br+Zffa9tTI5v1/OkuCdjF+ysg
	xDgPpu6a+xBpyRaRJZAGzbh3LSMYNkJjbuGzRx87e8DWDC1Y1zUs77Mi2+ZHtLdRjBq714FKDtg
	ADXFtbGdwbrQmPpHi3mTPFO0K80YEStBL41YYYAI7uRR5tI3P+FwcjALlYvJfPyE7czve6udaCw
	sjJD8H/RrWlf4FDNvonD0xJvHC4Z+I/QwoAwFgXbTzB9d3
X-Gm-Gg: AR+sD13Vm6QLdL7vYhXNvQlr4rHfRxAHssRPlMp6AbnGhtYZJ3VzfwUWiDtGYExckAg
	easttebStJ7lRyxDrSIuzma//Jf8XMjC/z8d7wu6EXm2D8Cu8CyL6UxOhwjBuOMzKURZ8LbZ0Yi
	H54rO5e3kjRds4ylhIlOn8g8o/jdP6tYx6JWXxrzYd/wmBb2j9XUInl3+4p0YwKPCXSLkpJdMsR
	aTG+87VO01mOfykRQZ/rTFHEJoc8c4p1V1RBN8v4Bl2hCDj9N+fdT4rdZ7QvXk0WdsoSAvq8gJO
	xxmYOSBqp/WhIOXfX2iF5vUY7NqeI9+dixlT0fGVhGeXlfVZcQbSg4ABcmqeRVfm4HFup66uH1t
	IsYvuRjNc0nzqULnuRDht1EnBORw6EnV0UmvlWRy/hyU=
X-Received: by 2002:a05:6830:6d08:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7f4613a4742mr32331648a34.5.1787616821434;
        Mon, 24 Aug 2026 17:13:41 -0700 (PDT)
X-Received: by 2002:a05:6830:6d08:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7f4613a4742mr32331574a34.5.1787616820799;
        Mon, 24 Aug 2026 17:13:40 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm6433923a34.24.2026.08.24.17.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:13:40 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 2/5] Add _require_chmod as needed
Date: Mon, 24 Aug 2026 19:11:09 -0500
Message-ID: <20260825001337.449670-3-sandeen@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001337.449670-1-sandeen@redhat.com>
References: <20260825001337.449670-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 tests/generic/093 | 1 +
 tests/generic/099 | 1 +
 tests/generic/184 | 1 +
 tests/generic/193 | 1 +
 tests/generic/230 | 1 +
 tests/generic/256 | 1 +
 tests/generic/314 | 1 +
 tests/generic/317 | 1 +
 tests/generic/355 | 1 +
 tests/generic/370 | 1 +
 tests/generic/375 | 1 +
 tests/generic/378 | 1 +
 tests/generic/444 | 1 +
 tests/generic/449 | 1 +
 tests/generic/462 | 1 +
 tests/generic/495 | 1 +
 tests/generic/514 | 1 +
 tests/generic/535 | 1 +
 tests/generic/572 | 1 +
 tests/generic/573 | 1 +
 tests/generic/581 | 1 +
 tests/generic/597 | 1 +
 tests/generic/603 | 1 +
 tests/generic/622 | 1 +
 tests/generic/636 | 1 +
 tests/generic/641 | 1 +
 tests/generic/673 | 1 +
 tests/generic/674 | 1 +
 tests/generic/675 | 1 +
 tests/generic/682 | 1 +
 tests/generic/683 | 1 +
 tests/generic/684 | 1 +
 tests/generic/685 | 1 +
 tests/generic/686 | 1 +
 tests/generic/687 | 1 +
 tests/generic/688 | 1 +
 tests/generic/698 | 1 +
 tests/generic/699 | 1 +
 tests/generic/726 | 1 +
 tests/generic/727 | 1 +
 tests/generic/792 | 1 +
 41 files changed, 41 insertions(+)

diff --git a/tests/generic/093 b/tests/generic/093
index 047cc821..9c3c855b 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -29,6 +29,7 @@ filefilter()
 _require_test
 _require_attrs security
 _require_user
+_require_chmod
 _require_test_program "writemod"
 _require_command "$SETCAP_PROG" "setcap"
 _require_command "$GETCAP_PROG" "getcap"
diff --git a/tests/generic/099 b/tests/generic/099
index 980fd38f..cf54e96b 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -47,6 +47,7 @@ _cleanup()
 #
 
 _require_test
+_require_chmod
 _require_runas
 
 _acl_setup_ids
diff --git a/tests/generic/184 b/tests/generic/184
index c82876d9..81663a65 100755
--- a/tests/generic/184
+++ b/tests/generic/184
@@ -13,6 +13,7 @@ _begin_fstest metadata auto quick
 . ./common/filter
 
 _require_test
+_require_chmod
 _require_mknod
 
 rm -f $TEST_DIR/null
diff --git a/tests/generic/193 b/tests/generic/193
index ba557428..4e23f33d 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -49,6 +49,7 @@ _filter_files()
 
 _require_test
 _require_user
+_require_chmod
 _require_chown
 
 test_root=$TEST_DIR/$seq.$$.root
diff --git a/tests/generic/230 b/tests/generic/230
index a8caf5a8..793e3a8f 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -17,6 +17,7 @@ _begin_fstest auto quota quick
 _require_scratch
 _require_quota
 _require_user
+_require_chmod
 
 test_files()
 {
diff --git a/tests/generic/256 b/tests/generic/256
index fe8be022..eba2ba32 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -19,6 +19,7 @@ _require_xfs_io_command "fpunch"
 _require_scratch
 _require_user
 _require_test
+_require_chmod
 
 testfile=$TEST_DIR/256.$$
 
diff --git a/tests/generic/314 b/tests/generic/314
index 65f7f9d9..b0fdd567 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -15,6 +15,7 @@ _begin_fstest auto quick perms
 _require_test
 _require_user
 _require_chown
+_require_chmod
 _require_sgid_inheritance
 
 rm -rf $TEST_DIR/$seq-dir
diff --git a/tests/generic/317 b/tests/generic/317
index 1afec6a7..67dcbf91 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -33,6 +33,7 @@ file=$SCRATCH_MNT/file1
 
 _require_scratch
 _require_user
+_require_chmod
 _require_ugid_map
 _require_userns
 _require_chown
diff --git a/tests/generic/355 b/tests/generic/355
index 6b4f7eba..443c17a3 100755
--- a/tests/generic/355
+++ b/tests/generic/355
@@ -14,6 +14,7 @@ _begin_fstest auto quick perms
 
 _require_test
 _require_user
+_require_chmod
 _require_odirect
 _require_chown
 
diff --git a/tests/generic/370 b/tests/generic/370
index b5d942de..1b04eab1 100755
--- a/tests/generic/370
+++ b/tests/generic/370
@@ -23,6 +23,7 @@ _fixed_by_fs_commit btrfs 03018e5d8508 \
     "btrfs: fix swap file activation failure due to extents that used to be shared"
 _fixed_by_fs_commit xfs 2d873efd174b "xfs: flush inodegc before swapon"
 
+_require_chmod
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/generic/375 b/tests/generic/375
index eb675144..1e2ee334 100755
--- a/tests/generic/375
+++ b/tests/generic/375
@@ -15,6 +15,7 @@ _begin_fstest auto quick acl perms
 . ./common/attr
 
 _require_test
+_require_chmod
 _require_runas
 _require_acls
 
diff --git a/tests/generic/378 b/tests/generic/378
index 5a6bd2b0..7c3a8d93 100755
--- a/tests/generic/378
+++ b/tests/generic/378
@@ -20,6 +20,7 @@ _begin_fstest auto quick metadata
 
 _require_test
 _require_user
+_require_chmod
 _require_hardlinks
 
 # Setup testfile and its hardlink
diff --git a/tests/generic/444 b/tests/generic/444
index 31e0e43e..9094743e 100755
--- a/tests/generic/444
+++ b/tests/generic/444
@@ -15,6 +15,7 @@ _begin_fstest auto quick acl perms
 . ./common/attr
 
 _require_test
+_require_chmod
 _require_runas
 _require_acls
 
diff --git a/tests/generic/449 b/tests/generic/449
index 9cf814ad..370b0db1 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -19,6 +19,7 @@ _begin_fstest auto quick acl attr enospc
 # Modify as appropriate.
 _require_scratch
 _require_test
+_require_chmod
 _require_acls
 _require_attrs trusted
 
diff --git a/tests/generic/462 b/tests/generic/462
index 49b0df40..d886a26e 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -19,6 +19,7 @@ _begin_fstest auto quick dax mmap
 
 # Modify as appropriate.
 _require_test
+_require_chmod
 _require_scratch_dax_mountopt "dax"
 _require_test_program "t_mmap_write_ro"
 # running by unpriviliged user is not necessary to reproduce
diff --git a/tests/generic/495 b/tests/generic/495
index dd18693b..4cc4c646 100755
--- a/tests/generic/495
+++ b/tests/generic/495
@@ -12,6 +12,7 @@ _begin_fstest auto quick swap
 # Import common functions.
 . ./common/filter
 
+_require_chmod
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/514 b/tests/generic/514
index a2086a25..02537b21 100755
--- a/tests/generic/514
+++ b/tests/generic/514
@@ -15,6 +15,7 @@ _begin_fstest auto quick clone
 
 _require_scratch_reflink
 _require_user
+_require_chmod
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
diff --git a/tests/generic/535 b/tests/generic/535
index 9f552ee8..c8e193cc 100755
--- a/tests/generic/535
+++ b/tests/generic/535
@@ -34,6 +34,7 @@ _cleanup()
 
 
 _require_scratch
+_require_chmod
 _require_dm_target flakey
 
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/generic/572 b/tests/generic/572
index 80356760..97656c4b 100755
--- a/tests/generic/572
+++ b/tests/generic/572
@@ -27,6 +27,7 @@ _cleanup()
 . ./common/verity
 
 _require_scratch_verity
+_require_chmod
 _disable_fsverity_signatures
 
 _scratch_mkfs_verity &>> $seqres.full
diff --git a/tests/generic/573 b/tests/generic/573
index d3f3296c..3f056b57 100755
--- a/tests/generic/573
+++ b/tests/generic/573
@@ -24,6 +24,7 @@ _cleanup()
 
 _require_scratch_verity
 _require_user
+_require_chmod
 _require_chattr ia
 _disable_fsverity_signatures
 
diff --git a/tests/generic/581 b/tests/generic/581
index 2773c910..b36a1b89 100755
--- a/tests/generic/581
+++ b/tests/generic/581
@@ -29,6 +29,7 @@ _cleanup()
 . ./common/encrypt
 
 _require_user
+_require_chmod
 _require_scratch_encryption -v 2
 
 _scratch_mkfs_encrypted &>> $seqres.full
diff --git a/tests/generic/597 b/tests/generic/597
index b97265fb..62f83cd6 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -27,6 +27,7 @@ _cleanup()
 
 # Modify as appropriate.
 _require_test
+_require_chmod
 _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
 _require_user fsgqa2
diff --git a/tests/generic/603 b/tests/generic/603
index 9b5e8245..853d3b16 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -115,6 +115,7 @@ _require_setquota_project
 _require_quota
 _require_user
 _require_group
+_require_chmod
 
 _scratch_mkfs >$seqres.full 2>&1
 _scratch_enable_pquota
diff --git a/tests/generic/622 b/tests/generic/622
index e8ead300..cb0f5828 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -77,6 +77,7 @@ _cleanup()
 # This test uses the shutdown command, so it has to use the scratch filesystem
 # rather than the test filesystem.
 _require_scratch
+_require_chmod
 _require_scratch_shutdown
 _require_metadata_journaling
 _require_xfs_io_command "pwrite"
diff --git a/tests/generic/636 b/tests/generic/636
index 2ae74310..402fc917 100755
--- a/tests/generic/636
+++ b/tests/generic/636
@@ -13,6 +13,7 @@ _begin_fstest auto quick swap
 # Import common functions.
 . ./common/filter
 
+_require_chmod
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/641 b/tests/generic/641
index a6efcd4c..809204d9 100755
--- a/tests/generic/641
+++ b/tests/generic/641
@@ -15,6 +15,7 @@ _begin_fstest auto quick swap collapse
 . ./common/filter
 
 _require_scratch
+_require_chmod
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/673 b/tests/generic/673
index 6c54ade8..832fdd72 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -16,6 +16,7 @@ _begin_fstest auto clone quick perms
 
 # Modify as appropriate.
 _require_user
+_require_chmod
 _require_scratch_reflink
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/generic/674 b/tests/generic/674
index 41fbdeb7..e5a32782 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -16,6 +16,7 @@ _begin_fstest auto clone quick perms dedupe
 
 # Modify as appropriate.
 _require_user
+_require_chmod
 _require_scratch_dedupe
 _require_xfs_io_command dedupe
 
diff --git a/tests/generic/675 b/tests/generic/675
index 87dfbdfe..e648182e 100755
--- a/tests/generic/675
+++ b/tests/generic/675
@@ -17,6 +17,7 @@ _begin_fstest auto clone quick
 
 # Modify as appropriate.
 _require_user
+_require_chmod
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 _require_scratch_reflink
diff --git a/tests/generic/682 b/tests/generic/682
index 6914a549..a3bb42ac 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -23,6 +23,7 @@ _begin_fstest auto quick quota
 _require_quota
 _require_user
 _require_scratch
+_require_chmod
 
 _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
diff --git a/tests/generic/683 b/tests/generic/683
index 883905da..226d2758 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -24,6 +24,7 @@ _cleanup()
 # Modify as appropriate.
 _require_user
 _require_test
+_require_chmod
 verb=falloc
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
diff --git a/tests/generic/684 b/tests/generic/684
index 9cdfe4ab..7595f58a 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -24,6 +24,7 @@ _cleanup()
 # Modify as appropriate.
 _require_user
 _require_test
+_require_chmod
 verb=fpunch
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
diff --git a/tests/generic/685 b/tests/generic/685
index 55672550..aa7fc848 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -24,6 +24,7 @@ _cleanup()
 # Modify as appropriate.
 _require_user
 _require_test
+_require_chmod
 verb=fzero
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
diff --git a/tests/generic/686 b/tests/generic/686
index a3fa8e06..03270a7d 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -24,6 +24,7 @@ _cleanup()
 # Modify as appropriate.
 _require_user
 _require_test
+_require_chmod
 verb=finsert
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
diff --git a/tests/generic/687 b/tests/generic/687
index 0c4b09d2..cd564a7d 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -24,6 +24,7 @@ _cleanup()
 # Modify as appropriate.
 _require_user
 _require_test
+_require_chmod
 verb=fcollapse
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
diff --git a/tests/generic/688 b/tests/generic/688
index 77db2946..1d16261d 100755
--- a/tests/generic/688
+++ b/tests/generic/688
@@ -23,6 +23,7 @@ _cleanup()
 
 # Modify as appropriate.
 _require_user
+_require_chmod
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 _require_xfs_io_command falloc
diff --git a/tests/generic/698 b/tests/generic/698
index 0029df90..a0cccfe7 100755
--- a/tests/generic/698
+++ b/tests/generic/698
@@ -26,6 +26,7 @@ _fixed_by_kernel_commit 168f91289340 \
 	"fs: account for group membership"
 _require_scratch
 _require_chown
+_require_chmod
 _require_idmapped_mounts
 _require_test_program "vfs/mount-idmapped"
 _require_user fsgqa2
diff --git a/tests/generic/699 b/tests/generic/699
index 2a6f857d..6e94043f 100755
--- a/tests/generic/699
+++ b/tests/generic/699
@@ -25,6 +25,7 @@ _require_extra_fs overlay
 
 _require_scratch
 _require_chown
+_require_chmod
 _require_idmapped_mounts
 _require_test_program "vfs/mount-idmapped"
 _require_user fsgqa2
diff --git a/tests/generic/726 b/tests/generic/726
index d2a2a2ce..a6c12133 100755
--- a/tests/generic/726
+++ b/tests/generic/726
@@ -23,6 +23,7 @@ _begin_fstest auto fiexchange quick
 
 # Modify as appropriate.
 _require_user
+_require_chmod
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate
 _require_scratch
diff --git a/tests/generic/727 b/tests/generic/727
index 9551e47c..92d3743c 100755
--- a/tests/generic/727
+++ b/tests/generic/727
@@ -24,6 +24,7 @@ _begin_fstest auto fiexchange quick
 
 # Modify as appropriate.
 _require_user
+_require_chmod
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 _require_xfs_io_command exchangerange
diff --git a/tests/generic/792 b/tests/generic/792
index d1896728..c457ad6d 100755
--- a/tests/generic/792
+++ b/tests/generic/792
@@ -22,6 +22,7 @@ _cleanup()
 . ./common/dmflakey
 
 _require_scratch
+_require_chmod
 _require_test_program unlink-fsync
 _require_dm_target flakey
 
-- 
2.55.0

