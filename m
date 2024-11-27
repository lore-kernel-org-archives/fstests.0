Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726174689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683577; cv=none; b=AQFj2MwUULmuYYZvE5h0LXSC2H/JJBwlrDzd63ag6m8pLSbJkThnLgftLfkp51DG3FlQPGCSX5S8AXTdgKMpPedCMZ8tmJsot8X5c532jvqb1/ZwVjUjhOZuj4tKjB9hvNl0lkjVHDyYWgX3IlkToTWCqrmF4gXIoKeKhgHAcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683577; c=relaxed/simple;
	bh=Fjhq6mjr43d7UOVg7y101Ya4UzJYpqQYQcOcS4bzXTA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f20ZUNXOJ5M6Yxu7qOgJvnRT8jvQFZGhsRAcAiBH0H3fknZWtCJYxm29HXmVomDrl5YzjrIVY3fepBHXh2P98C73UN1m1t+1S528OQjprHhO8k5g5/czj40gi++2Gmesc1m32/EuVHlBG8KTpbwmUxe0pV0RHZLFopBEbVUtV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hnCrVSiz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hnCrVSiz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7251ce598adso1348740b3a.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683576; x=1733288376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uO17thinb1mTZm6rxzipVuysiU7uoslnytn3CIiThlc=;
        b=hnCrVSizlQcG708cEDqbCK82l8ICxZgci7LhgTWQsWmDgEyL2oo9ruHWU94bSqpYNx
         HdSxJ+9rb7QCwsK39I07pEvTSDKfniRMuw6VHHhGX/sKrX0xXjJmiXlG/SnrjFNBJrRD
         b22DoEltgA5KtUsnErlnYMlKzrmHqexhkw/z9QPplavgrU3Sf2ZZ1iFyl8PZDFR3BKJi
         h9ZHY5UVQc0X/MOZqbdRUQcvw6LctytqiCaVQslPFGylcib5qCybabz+SRIMhvcfjTJq
         /tRQSDLgap6wVge43bNTEKjq1/b5JFgyX4zQg5scMUudcody6K+X064DOqLgKLPRC2Wu
         XRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683576; x=1733288376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO17thinb1mTZm6rxzipVuysiU7uoslnytn3CIiThlc=;
        b=X3enH9nQKOTmkDrA2bhmwJL61FLWv3rGbejfcKmLossHWPGkDBw19oMlZcYj4rWdUL
         L2rUqRj34GFxWVPrMnxucbHquT52cNX+KgFT3EBD7DHTKUUp2P6nnzJMG6EFqcAJA2wP
         8YFx2KLshlFo9TEwA3wRZN/TrYW/aJdrqkSpEcFdbvzdNYbkhclirRnpuh/WpJpI3Txt
         2SxkGrHdUbhsRtPp9BAUCqeLpDAcZLhooVsOjStgqJKhYA5Y0r2EvyjvKZXN/T+ErSoK
         8TJyBW+RmlY4ZcQCtXshlp/n60RewKkfanMvzUh1yd/Y+y2oVYPabNiHC/mUlU4x8c8Y
         aBRQ==
X-Gm-Message-State: AOJu0YzRUp7c2uyX8h/lGn1bLvmqoZO0cjxInT7v6fRr+YqYBSm9U8sR
	DNi+23dSCgWV/vc+yS5PXmJS3mpfJFrkK3lvRMbDML/aL4jGcOyfIHLnMaToLOEZSwiYQdQcUZL
	j
X-Gm-Gg: ASbGncuL3esrG2JeNVjr3PkIdHFGLRAUYYMzVf5gURoIzCdqF2fzqkLIHWwYeIu4EIy
	zo41IQB5WorvweIpYW6d/LM4KCaa3aXVkSwv4GLqjcFMLpiLmrVSHg3h1+KbF/5SdgwzutRS2Sx
	NIKOUu41sPT0QeY1ipB5V1jsIjOXRm1JApUileKrh/ZZnJh+xJGtRSqj7B24xHqozJNwx7zgzII
	tlGJWxf4jl6/3X3xoqFNClFtZ9yffX7zijokIuZf9C2ag4897Ykjh7zXZmJF0ZxS+QVxv4VfsoE
	dR1Mm378KohFRQ==
X-Google-Smtp-Source: AGHT+IHISm+u1rLHkVYllNeUVbS2doPfFz0eYVsyxK7bJ03yoKM3mafAtGVFzcyuZs0KSZ2+B8wcTA==
X-Received: by 2002:a05:6a00:2351:b0:724:67dd:2615 with SMTP id d2e1a72fcca58-7253015446amr2597043b3a.22.1732683575860;
        Tue, 26 Nov 2024 20:59:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531308sm9290309b3a.110.2024.11.26.20.59.35
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:35 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVf-3BOz
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfn-3lTV
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 29/40] generic/085: general cleanup for reliability and debugging
Date: Wed, 27 Nov 2024 15:51:59 +1100
Message-ID: <20241127045403.3665299-30-david@fromorbit.com>
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

This test was quite unreliable during development of the parallel
check runner. It redirects all errors to /dev/null, so there was no
way to debug it when it failed.

Use common mount/unmount helpers, redirect errors to $seqres.full,
make sure the cleanup code is always run at test exit and only
attempt to kill processes if they are still running during cleanup.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/085 | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/generic/085 b/tests/generic/085
index 8fbcdce2e..7671a36ab 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -16,18 +16,20 @@ _begin_fstest auto freeze mount
 # Override the default cleanup function.
 _cleanup()
 {
+	cleanup_dmdev
 	cd /
 	rm -f $tmp.*
-	cleanup_dmdev
 }
 
 cleanup_dmdev()
 {
+	if [ -n "$pid" ]; then
+		kill -9 $pid 2>> $seqres.full
+		wait $pid 2>> $seqres.full
+	fi
 	# in case it's still suspended and/or mounted
-	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
-	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
-	wait $pid
-	_unmount $lvdev >/dev/null 2>&1
+	$DMSETUP_PROG resume $lvdev >> $seqres.full 2>&1
+	_unmount -q $SCRATCH_MNT
 	_dmsetup_remove $node
 }
 
@@ -64,18 +66,19 @@ setup_dmdev
 # important, as long as they're racing with each other. So just throw away the
 # outputs and ignore the results.
 for ((i=0; i<100; i++)); do
-	$DMSETUP_PROG suspend $lvdev >/dev/null 2>&1
-	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
+	$DMSETUP_PROG suspend $lvdev >> $seqres.full 2>&1
+	$DMSETUP_PROG resume $lvdev >> $seqres.full 2>&1
 done &
 pid=$!
 for ((i=0; i<100; i++)); do
-	_mount $lvdev $SCRATCH_MNT >/dev/null 2>&1
-	_unmount $lvdev >/dev/null 2>&1
+	_mount $lvdev $SCRATCH_MNT >> $seqres.full 2>&1
+	_unmount $lvdev >> $seqres.full 2>&1
 done &
 pid="$pid $!"
 
 wait $pid
 unset pid
 
+cleanup_dmdev
 status=0
 exit
-- 
2.45.2

