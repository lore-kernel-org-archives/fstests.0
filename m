Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCFF12D1F1
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616829; cv=none; b=GILlWhJh9XQUErCgT+a62VI5lkl0/w+DoA2M6UZUhLCyvQqrd7UbM7UeRd9MY++j0yStx3zBIz7yA+8e0RASl/b4zA6dWYD9lw97xO+Ivhp5WBs/YJTXBj84blJqLkEEUVCo1PmMSM+9RnOCEqsKjIK9S8rwNKOaIUutzzZ6+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616829; c=relaxed/simple;
	bh=d/+KJcI/Ola9I9AvOjwj0nstm2exsr7zNZiv9+sXzpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr1x1SXdu7KDZ4EOrOHcBzczkivnIf3JACYWH1Twi9ihMY0lRw72ahaN6wVunPrRK9+oiR23d8BEtKcRNT9bymdb8fk2vA/Wge6zaV1cPxQFlxwTa7sg4i/NxrI4opml9J0TdOt8aUbpUeL9UDGoMLI78smvibltBD1JI5on3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4dnpi1P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tgiyRSHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4dnpi1P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tgiyRSHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787616826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYekN6SVId8ST96899GHQ9FtXxdodP1Mp+WD9ynMFKc=;
	b=V4dnpi1PkCVixjJcRFPRAew9x//x5Rcvw5gcf5wlajk1vOHaLK6tBFQVqFU/kmQJc7hfTT
	5i1tnSa5XV9lhVLM2a2R/W/YB+33EiX7YsSSENAnk/H2mXS3m4KlMzA/cp1cMVfdobIhys
	6DHnNDUspoAsTrWmGJJQUWeWU/7jOMw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-aCXlady3NfGj7TxvHyNgKQ-1; Mon, 24 Aug 2026 20:13:43 -0400
X-MC-Unique: aCXlady3NfGj7TxvHyNgKQ-1
X-Mimecast-MFC-AGG-ID: aCXlady3NfGj7TxvHyNgKQ_1787616823
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f3cc4f6604so7577273a34.0
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787616823; x=1788221623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tYekN6SVId8ST96899GHQ9FtXxdodP1Mp+WD9ynMFKc=;
        b=tgiyRSHITrPIr7cUkFTVpCAThSgqbaIq9D0XyEx8Wf305ZJ/3OKJ9aIpuDPAt1MLpM
         RvGo2XGrEpRIxbTd2360m50Qlz1yLcvtEm/NWR6XpCwb2uGk/E0VKYMUKA0XqzLIOfHe
         UPktceBaJAAblfCTneGKfJx2JQLBi5doEFKy1aO9q8rgEDZsnGUiT7HZ6HeMRqBezQH0
         prCu64JG/170wKYOh66yD6vYazQndiHWpOfmqHyTprIs8zLyp/OZEf2wRaNRkiIRGlne
         JDjUT9TjTgEZ6ezZvaqB6oYo9ujFaA2sRR0F0Ri7z1UgJZZpyfq8zHDc4YXxg7vXFHBg
         b/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616823; x=1788221623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYekN6SVId8ST96899GHQ9FtXxdodP1Mp+WD9ynMFKc=;
        b=IcF6MOHlaKWuE1o2mptIRBCW06NHDonvJnyY6Rq24DHigNsXnL2RCDmDTRvpIQRGcr
         DlYYGNmQluITkpFhxlVAD2VoayinAgK9qO+q4JPE5dF/9H+JPbdBIC+fKdkrYoDFNbr8
         nWwf5+UG9s5DHTzzVIV/ugrWHobmYGjY0ZGbg4zO9rKINgoxLcQrIHF4xdurxE/XNxlU
         cIoXCF1ck1m0VyPkW0+war7mCd+VwbrVXJpUGj4w8cNeJWUbI81ygGOs07JwQkFPNMHP
         tm9DzOdsLA3ba3IOR8hqihf2FV9T3x378SeCbMj7K6U8Px1n9QKtM9zvS7acZmK1tgFP
         09Tg==
X-Gm-Message-State: AFuF++lP6JBVsDPG/q/5vqBK97dwpDrIt5/aYKmScFARvzKSays6yzDT
	8OMSD7SRNM/zRq5MbQJG4h9iSReTjtG5WOq3j5OHZ1e3VTM+/tqZ5QWsqSWC7SdUDvvDZfokk1R
	rfHMskwiUI1KjkWFulbERLZ/bqXGP1UAoXSTuYgkzbS8SsMo3EXnWu+4fDWqY/NsUE8jh8FHMV8
	W8dEOUhDvu7LVP+5cYN6CGZ4HQHEvA2Spne1J3lNaz/gTw
X-Gm-Gg: AR+sD11j3nmEv21Mp6eCp2xjIB7AHdV13JgfKJ6+c9QX3TrUmdTSthQytoSDTkd3X+i
	eeEsgENDXSrt19rldp2twzsR9vrJLHeITuFbC6ZUcA9BOhOxrkWq1qFY9lxKkQj81IkroO35m5S
	WgFjCJkS4PoowmVpyzcjkDSoju6djvnAzL16+dMfbPnHqEu6yPOEl8JF8LxRPkfgOP1w0gWA+0k
	WzcFlZmE0GBast99DJ7rRThVg3YOxNXZZWh/4CmRYb4X6foM4rf2Soqq9HllXQYucprxjfqLcNB
	TTPSFBT5pM28rSJaENwHeTP0auUgYUsGi6N2Ixip+3LCh+sFOPZu17V7+hRYUI+sBrG8qSz84Ze
	JrSVJYWNDk7cLbfCZ50u3CoXd1T92hk/wm5r/VDva4FM=
X-Received: by 2002:a05:6830:4c16:b0:7e9:ea28:4c1f with SMTP id 46e09a7af769-7f47641e9b5mr22536950a34.8.1787616822646;
        Mon, 24 Aug 2026 17:13:42 -0700 (PDT)
X-Received: by 2002:a05:6830:4c16:b0:7e9:ea28:4c1f with SMTP id 46e09a7af769-7f47641e9b5mr22536881a34.8.1787616821908;
        Mon, 24 Aug 2026 17:13:41 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm6433923a34.24.2026.08.24.17.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:13:41 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 3/5] Add _require_chown as needed
Date: Mon, 24 Aug 2026 19:11:10 -0500
Message-ID: <20260825001337.449670-4-sandeen@redhat.com>
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
 tests/generic/105 | 1 +
 tests/generic/219 | 1 +
 tests/generic/230 | 1 +
 tests/generic/235 | 1 +
 tests/generic/237 | 1 +
 tests/generic/244 | 1 +
 tests/generic/305 | 1 +
 tests/generic/318 | 1 +
 tests/generic/326 | 1 +
 tests/generic/327 | 1 +
 tests/generic/328 | 1 +
 tests/generic/375 | 1 +
 tests/generic/379 | 1 +
 tests/generic/380 | 1 +
 tests/generic/400 | 1 +
 tests/generic/444 | 1 +
 tests/generic/462 | 1 +
 tests/generic/505 | 1 +
 tests/generic/566 | 1 +
 tests/generic/572 | 1 +
 tests/generic/587 | 1 +
 tests/generic/597 | 1 +
 tests/generic/598 | 1 +
 tests/generic/603 | 1 +
 tests/generic/681 | 1 +
 tests/generic/682 | 1 +
 tests/generic/709 | 1 +
 tests/generic/710 | 1 +
 tests/generic/721 | 1 +
 31 files changed, 31 insertions(+)

diff --git a/tests/generic/093 b/tests/generic/093
index 9c3c855b..e1291019 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -29,6 +29,7 @@ filefilter()
 _require_test
 _require_attrs security
 _require_user
+_require_chown
 _require_chmod
 _require_test_program "writemod"
 _require_command "$SETCAP_PROG" "setcap"
diff --git a/tests/generic/099 b/tests/generic/099
index cf54e96b..40b795e1 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -48,6 +48,7 @@ _cleanup()
 
 _require_test
 _require_chmod
+_require_chown
 _require_runas
 
 _acl_setup_ids
diff --git a/tests/generic/105 b/tests/generic/105
index a74dc726..180e7418 100755
--- a/tests/generic/105
+++ b/tests/generic/105
@@ -26,6 +26,7 @@ _cleanup()
 
 
 _require_scratch
+_require_chown
 _require_acls
 
 _acl_setup_ids
diff --git a/tests/generic/219 b/tests/generic/219
index 64282385..7c47762e 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -17,6 +17,7 @@ _begin_fstest auto quota quick mmap
 _require_scratch
 _require_quota
 _require_user
+_require_chown
 _require_group
 _require_odirect
 
diff --git a/tests/generic/230 b/tests/generic/230
index 793e3a8f..05eb9024 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -17,6 +17,7 @@ _begin_fstest auto quota quick
 _require_scratch
 _require_quota
 _require_user
+_require_chown
 _require_chmod
 
 test_files()
diff --git a/tests/generic/235 b/tests/generic/235
index 037c29e8..c880c620 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -17,6 +17,7 @@ _begin_fstest auto quota quick
 _require_scratch
 _require_quota
 _require_user
+_require_chown
 
 do_repquota()
 {
diff --git a/tests/generic/237 b/tests/generic/237
index 266b3d69..2c686dee 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -25,6 +25,7 @@ _cleanup()
 # only Linux supports fallocate
 _require_test
 _require_runas
+_require_chown
 
 _acl_setup_ids
 _require_acls
diff --git a/tests/generic/244 b/tests/generic/244
index b6803512..c508f01b 100755
--- a/tests/generic/244
+++ b/tests/generic/244
@@ -26,6 +26,7 @@ _cleanup()
 
 _require_quota
 _require_scratch
+_require_chown
 
 _scratch_mkfs >> $seqres.full 2>&1
 
diff --git a/tests/generic/305 b/tests/generic/305
index 373abf57..04c0f223 100755
--- a/tests/generic/305
+++ b/tests/generic/305
@@ -21,6 +21,7 @@ _require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_user
+_require_chown
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/318 b/tests/generic/318
index 033c0611..0c5c19c8 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -34,6 +34,7 @@ file=$SCRATCH_MNT/file1
 _require_scratch
 _acl_setup_ids
 _require_acls
+_require_chown
 _require_ugid_map
 _require_userns
 ns_acl1=0
diff --git a/tests/generic/326 b/tests/generic/326
index d16e95aa..3fc04143 100755
--- a/tests/generic/326
+++ b/tests/generic/326
@@ -22,6 +22,7 @@ _require_quota
 _require_nobody
 _require_odirect
 _require_user
+_require_chown
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/327 b/tests/generic/327
index 9102cbd6..2fffacab 100755
--- a/tests/generic/327
+++ b/tests/generic/327
@@ -20,6 +20,7 @@ _require_xfs_io_command "fiemap"
 _require_quota
 _require_nobody
 _require_user
+_require_chown
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/328 b/tests/generic/328
index db785475..27160ec2 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -21,6 +21,7 @@ _require_quota
 _require_nobody
 _require_odirect
 _require_user
+_require_chown
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/375 b/tests/generic/375
index 1e2ee334..81d3de22 100755
--- a/tests/generic/375
+++ b/tests/generic/375
@@ -16,6 +16,7 @@ _begin_fstest auto quick acl perms
 
 _require_test
 _require_chmod
+_require_chown
 _require_runas
 _require_acls
 
diff --git a/tests/generic/379 b/tests/generic/379
index 9e5889b9..28d004fe 100755
--- a/tests/generic/379
+++ b/tests/generic/379
@@ -23,6 +23,7 @@ _cleanup()
 
 
 _require_scratch
+_require_chown
 _require_quota
 _require_xfs_quota_foreign
 
diff --git a/tests/generic/380 b/tests/generic/380
index 8d772a96..0a619768 100755
--- a/tests/generic/380
+++ b/tests/generic/380
@@ -19,6 +19,7 @@ _begin_fstest quota auto quick
 # Modify as appropriate.
 
 _require_scratch
+_require_chown
 _require_quota
 _require_xfs_quota_foreign
 
diff --git a/tests/generic/400 b/tests/generic/400
index 77970da6..48d54f65 100755
--- a/tests/generic/400
+++ b/tests/generic/400
@@ -19,6 +19,7 @@ _begin_fstest auto quick quota
 
 _require_quota
 _require_scratch
+_require_chown
 
 _scratch_mkfs >> $seqres.full 2>&1
 
diff --git a/tests/generic/444 b/tests/generic/444
index 9094743e..1018e85d 100755
--- a/tests/generic/444
+++ b/tests/generic/444
@@ -16,6 +16,7 @@ _begin_fstest auto quick acl perms
 
 _require_test
 _require_chmod
+_require_chown
 _require_runas
 _require_acls
 
diff --git a/tests/generic/462 b/tests/generic/462
index d886a26e..0dc0d98b 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -20,6 +20,7 @@ _begin_fstest auto quick dax mmap
 # Modify as appropriate.
 _require_test
 _require_chmod
+_require_chown
 _require_scratch_dax_mountopt "dax"
 _require_test_program "t_mmap_write_ro"
 # running by unpriviliged user is not necessary to reproduce
diff --git a/tests/generic/505 b/tests/generic/505
index eb44573b..ca815d42 100755
--- a/tests/generic/505
+++ b/tests/generic/505
@@ -25,6 +25,7 @@ _begin_fstest shutdown auto quick metadata
 
 
 _require_scratch
+_require_chown
 _require_scratch_shutdown
 
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/generic/566 b/tests/generic/566
index a6ec82fd..87db8095 100755
--- a/tests/generic/566
+++ b/tests/generic/566
@@ -27,6 +27,7 @@ _require_scratch
 _require_quota
 _require_xfs_quota_foreign
 _require_user
+_require_chown
 
 _qmount_option "grpquota"
 _scratch_mkfs > $seqres.full
diff --git a/tests/generic/572 b/tests/generic/572
index 97656c4b..c3059eb2 100755
--- a/tests/generic/572
+++ b/tests/generic/572
@@ -28,6 +28,7 @@ _cleanup()
 
 _require_scratch_verity
 _require_chmod
+_require_chown
 _disable_fsverity_signatures
 
 _scratch_mkfs_verity &>> $seqres.full
diff --git a/tests/generic/587 b/tests/generic/587
index 49fcade7..c252dab7 100755
--- a/tests/generic/587
+++ b/tests/generic/587
@@ -20,6 +20,7 @@ _begin_fstest auto quick rw prealloc quota
 . ./common/quota
 
 _require_user
+_require_chown
 _require_quota
 _require_xfs_io_command "falloc"
 _require_scratch
diff --git a/tests/generic/597 b/tests/generic/597
index 62f83cd6..3aef67a1 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -28,6 +28,7 @@ _cleanup()
 # Modify as appropriate.
 _require_test
 _require_chmod
+_require_chown
 _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
 _require_user fsgqa2
diff --git a/tests/generic/598 b/tests/generic/598
index 5b9db69e..52541b3e 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -35,6 +35,7 @@ _require_group fsgqa2
 _require_user fsgqa
 _require_group fsgqa
 _require_chmod
+_require_chown
 
 USER1=fsgqa2
 USER2=fsgqa
diff --git a/tests/generic/603 b/tests/generic/603
index 853d3b16..bb0fb4a7 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -116,6 +116,7 @@ _require_quota
 _require_user
 _require_group
 _require_chmod
+_require_chown
 
 _scratch_mkfs >$seqres.full 2>&1
 _scratch_enable_pquota
diff --git a/tests/generic/681 b/tests/generic/681
index dc425201..651ee157 100755
--- a/tests/generic/681
+++ b/tests/generic/681
@@ -23,6 +23,7 @@ _begin_fstest auto quick quota
 _require_quota
 _require_user
 _require_scratch
+_require_chown
 
 _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
diff --git a/tests/generic/682 b/tests/generic/682
index a3bb42ac..80846463 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -24,6 +24,7 @@ _require_quota
 _require_user
 _require_scratch
 _require_chmod
+_require_chown
 
 _scratch_mkfs > "$seqres.full" 2>&1
 _qmount_option usrquota
diff --git a/tests/generic/709 b/tests/generic/709
index e3994d00..04460556 100755
--- a/tests/generic/709
+++ b/tests/generic/709
@@ -15,6 +15,7 @@ _begin_fstest auto quick fiexchange quota
 
 _require_xfs_io_command exchangerange
 _require_user
+_require_chown
 _require_nobody
 _require_quota
 _require_xfs_quota
diff --git a/tests/generic/710 b/tests/generic/710
index 16f7276d..488c6751 100755
--- a/tests/generic/710
+++ b/tests/generic/710
@@ -15,6 +15,7 @@ _begin_fstest auto quick fiexchange quota
 
 _require_xfs_io_command exchangerange
 _require_user
+_require_chown
 _require_nobody
 _require_quota
 _require_xfs_quota
diff --git a/tests/generic/721 b/tests/generic/721
index 75d5063c..fb4eb489 100755
--- a/tests/generic/721
+++ b/tests/generic/721
@@ -25,6 +25,7 @@ _require_xfs_io_command startupdate
 _require_test_reflink
 _require_test
 _require_user
+_require_chown
 
 filesnap() {
 	echo "$1"
-- 
2.55.0

