Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE014689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683584; cv=none; b=KOLyf9syifDVuI2xSFRdr8cXjZcT1l7p+CLfeE09OyLlHru7fX15VdGQJ4/vWrSjxAdh8vSApsFHoLLQn6JxKDYSrh2zWvjNEOqdFgOieZT2EDqU2IJ3fqdH2xeP7OS0hwcjlUQpgWsKGpr/HVHWMDEW2P0kQC8hagbiUvd7qGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683584; c=relaxed/simple;
	bh=CPKSGUSlagvlJWWk6OHPlBfiuqm09EOoBhJFYr6A7R0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyKlii9JFXHtAGLWPK5fYolPxGL70kHa+hgUtJsVSsqJnDX7rjBLkuGgjH9vlbn5Y3vEgJUlZ1eTGnO0GsCru2sz2kdfjctQrlzDdz1moHPZ1NvGZpv4v5BTR1Tio1LmLiDKd8b8QP52SvChb+9CisBKyzn3NhSLlmADbGjKyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=f9bmTtMA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="f9bmTtMA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21285c1b196so59644945ad.3
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683583; x=1733288383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH7lGQprZZCi6rCoGBTP87RrIO42NQIhzQJNGcRSjN8=;
        b=f9bmTtMAonJaf55k4a0NNVaddoAyREhf/7Bfsc0HBugS/RWc9UjET8uLZdrgc1MC61
         B9Vzqik0rnO42dp6viLiOLHj+N9YzyoD+QEZ2dhgb1DohGIzKQkTQMxLN6VHX5Q5EpaY
         mCZcF6uEzKOfExZtjQ/lQYjwiUuDxtaj25kEhtqJdNKWFhbASx6KU/Hl5ApNtlAIZ1Hf
         HGCYNOE9Ii4oN5TGx14ZVrKHtQDcD0LxSeiqFTUK0uOkB6Objnr6cwws4fnbyjHK0tg3
         XZGMsZaQOVY7fCWzUuM5Lx2vzxv9VqjMYLHWs1D52+rJvLM96ddvAfrGO1WKtmsJgSsK
         NVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683583; x=1733288383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH7lGQprZZCi6rCoGBTP87RrIO42NQIhzQJNGcRSjN8=;
        b=tT/9lPK7hCpcp9nsc/7L484PkTbmel4aOGBe/UWng9mmf+HmfkbWaq7g40oMPHeltD
         6S2PX4Ks8IQfPTYRO5xsxGhsyP0RLlMYU1J6eatwotlEnfSYj3S3pp2GHthx/Gv50Jxs
         WjhNPdvcBVJTCa2QSWwlOnUA+zagkxGDfa61LH7NqT8Jp4mAaHYH5LxOIDHed91ykE8r
         V2179wN4HUfgnLV7lylUYAgHI3Rm/6M88NEG6fR8tc46vMXmTwZSKOVjuTEeFD4rd23w
         OZ20otL8ebqD8jsxKikr6uC5rQHZMWEkfVstpDJBq2k0lIwU4za7ecEG3XbTPMCOnWoR
         1ScQ==
X-Gm-Message-State: AOJu0Yxyvd9ZQ5Uz5PuO72R86lKwISt8P24LfwYW702ZpjcIjyePmzeq
	aXLj0r8BdxfnaToh7DkDr+aprzaqPNDyKKeIiSAoBqYnPdkjj+54d+Tyf3mMFE09TCyA2mpP/K0
	u
X-Gm-Gg: ASbGncvi057IEqfu2palUFrNGtYpkRRViTT80oSok0i9Jwmcewd+2i1DTJ7n2nFGQoJ
	2Q7OY9r1s9YWC1cCsSTtPLLB61ARSfTGQ0DR22q2K8qpRzXamDlLxbbToq55Gld0DQZrCWV+zIw
	i8oHZEqfKYyWwig6whAf+lueELpPGq5+88qORssWQBcFzz8sC+rxvkkQ3uRgRarZrxS+agpwqYn
	6v69654bwuQElbiczVXifjuiXtsQiZysWoO4Xr7gsOSSYMOujPi8BCB7Kfn45DfQHLUVu5dUqsw
	IOiDGxiR+8XnnQ==
X-Google-Smtp-Source: AGHT+IFzHTL6K/w1zAWBZ2j07TY4HMli8FSYVftG0EE2IhTZ3tohIQUJTT8WdlW5YHaa+wGOB3+lDw==
X-Received: by 2002:a17:903:22c1:b0:20c:d469:ba95 with SMTP id d9443c01a7336-2150109b400mr19530605ad.16.1732683582661;
        Tue, 26 Nov 2024 20:59:42 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3625sm94091085ad.95.2024.11.26.20.59.42
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:42 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVY-2uNg
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfc-3TKg
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 27/40] filter: handle mount errors from CONFIG_BLK_DEV_WRITE_MOUNTED=y
Date: Wed, 27 Nov 2024 15:51:57 +1100
Message-ID: <20241127045403.3665299-28-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Kernels post 6.x may have CONFIG_BLK_DEV_WRITE_MOUNTED=y which
prevents mount from opening the block device on a mounted
filesystem. This results in an error such as:

mount: <dev>: Can't open blockdev

which is not the error that callers of _filter_error_mount() are
looking for. It is, however, a direct result of the test trying
to mount an alreayd mounted filesystem, so it is reflecting the same
error case. Hence this mismatch in errors should not fail the test.

Catch this mount error and convert it to the expected
"already mounted" error for the tests that exercise this behaviour.

There is also a minor test change here to push mount failure
information to $seqres.full in the cases where mount errors occur.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/filter | 8 +++++++-
 tests/xfs/154 | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index 36d51bd95..6a509d8b5 100644
--- a/common/filter
+++ b/common/filter
@@ -430,6 +430,10 @@ _filter_ro_mount() {
 # v2.38 and later:
 # dmesg(1) may have more information after failed mount mount system call
 #
+# Kernels post 6.x may have CONFIG_BLK_DEV_WRITE_MOUNTED=y which prevents mount
+# from opening the block device on a mounted filesytsem:
+# mount: <dev>: Can't open blockdev
+#
 # This is also true for ESTALE error. So let's remove all the changing parts
 # and keep the 'prior to v2.21' format:
 # mount: Structure needs cleaning
@@ -437,7 +441,9 @@ _filter_ro_mount() {
 _filter_error_mount()
 {
 	grep -v "dmesg(1) may have more information after failed mount" | \
-		sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
+		sed -e "s/mount:\(.*failed:\)/mount:/" \
+		    -e "s/mount: SCRATCH_DEV: Can't open blockdev/mount: TEST_DIR\/extra_mnt: SCRATCH_DEV already mounted or mount point busy/" |\
+		    _filter_ending_dot
 }
 
 # Similar to _filter_error_mount, filter a busy mount output.
diff --git a/tests/xfs/154 b/tests/xfs/154
index e8494bbd6..674d06784 100755
--- a/tests/xfs/154
+++ b/tests/xfs/154
@@ -46,6 +46,7 @@ test $? -eq 137 || echo "repair should have been killed??"
 _check_scratch_xfs_features NEEDSREPAIR
 _try_scratch_mount &> $tmp.mount
 res=$?
+cat $tmp.mount >> $seqres.full
 _filter_error_mount < $tmp.mount
 if [ $res -eq 0 ]; then
 	echo "Should not be able to mount after needsrepair crash"
-- 
2.45.2

