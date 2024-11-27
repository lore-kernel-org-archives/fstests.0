Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808E10E0
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683619; cv=none; b=ZKp90zeQbBf8oXk+Yb3lC40M4R72AM4zfJyjVxLjlb+VsON8rAp060ub2HIOK4GvLaeracxSGUVeiJayW6XqXP2piV7Wo/8Rbxb9FhL5lkKYa2dn5NjgGYykDFxGugX6RAC8UKsCkZUyRQxukIzEjYiX80swAlqabAFkP7m/DtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683619; c=relaxed/simple;
	bh=tMW5IA4gWYHrIishB2o5Fqp4DWrRYTODDnqH5SaacG8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwttX+QVA5NDtsyTbT02Vi6QYYn2C6y2wl/UdCGy6uS6QRslp1WoN4S6gBw/fmyeUiUFiwRXdMn9lnCGhd3M8tpIxoONWxyMsbqFjuZHzPDN6nDmDQ9V6CdYk57ST8tpZpQda3CIj61Hlprc/zAB6vIuS9T4qgi7QCvrtj1uM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LmYWQEiP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LmYWQEiP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21207f0d949so60719455ad.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 21:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683618; x=1733288418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOMvIhnFfNNITK55K9hXMMZ1nzXDoeNI+ouhBSMnChs=;
        b=LmYWQEiPEieIoaDrFjffQyh9YzeckvDg3q52I9w4wdreaoiNfbATxqp1ODGNq8M8nn
         sCCKUKPRMIOSs0ovQIqMd6+n+MY1GJWrYHUanAwLiefmLBxqTp6pJYzfVTgqd395sHzs
         wlX4C85/az9Oc9Tu4QqhXP6ZbIHyXldvRfvFRU7J2zpINqFaR0yrDZ69uV26iahwBiNm
         4PgCMpz00T33GiwtJPDiy07s6Dz4oakTHcGxAdQkzjZRFKLg2QmWGALSS7obH+qLZeW0
         RDFbuKeMZs0EU2uV3t+cdzlyQ+/HCFQBe7vcT46s6z2uC6sKlID9shHx0FjUua4YPD0i
         TLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683618; x=1733288418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOMvIhnFfNNITK55K9hXMMZ1nzXDoeNI+ouhBSMnChs=;
        b=KixrNGS09IoIb9ARa43jLESGhPp8sWBJadv3NYypa9PsT2/1/cQ+jj2H80m5Z6KtzA
         OhPSBXw9WQAVJ/y/wSqccD8VpMxYSHJ8BJnPS8SlZKnyzElSfpFsgSwiYWoScViq6LbB
         Zn7pt9ea9XdO/5e92UUkwqvk0TOuU5FBfC/ad9JrdBz0dgFIk+G4rbIVmQ9X/0yIayA2
         zjcOM+wDSpIQvHLWGOuykobe+fy+67uwCWLnLgmSrj8W06nOL+S5BjP1THdHx5ZK27H/
         b4Z0txx43XPflEvOe4KeAPtf9zt/MKcDuRrA5Mb9LsdyvaNhgI7hAwvigqtW7e3g2prB
         tkDQ==
X-Gm-Message-State: AOJu0YwFeqwvRy6vjP9Bfsys1J4UH3VolhxYg2N12VE4wQeeDlMftMBh
	4Ntb0vimgk5dksgH8yuhzIwIrdhdjL0hd7GvG1fzfuJkheGwCpYvSiwrTp9IXagDdCyhcksK/Cp
	T
X-Gm-Gg: ASbGnctc33WqKGyKpDs4puChPRCvQgEUuXasK981+AikY7rNGxt7LDVEqCwSlS/Q9+3
	0t/3EQ8bykS8HLz5kzlmO4XFQxnV0EgKZYrvaFX5ltlRhPGA7AyDoA0o+5y9tLo5mlI3qzK2QXg
	KeBzQTvFCor06sFHdWdY88noUb/ucS+Nj7q1I9SJeNoFMQWQP5KpZnRHbG8Q2/Ucc2tXzbwXa9W
	kR3FR9V8bphaJII3SSWeWJpiQxwcZ8IjwF3d0U/QqN7BUh0499x6q4qpUpYaOGU+P4Qo76Q0c85
	bdddTacbQnI1Qg==
X-Google-Smtp-Source: AGHT+IFxBfMXCkJiWp+4WcdL3TJWHcV3hlfd9nyavM96Dz957l8wQ4yy/wLpZeWIHZW2SyFTQHNunA==
X-Received: by 2002:a17:902:cf0e:b0:212:67ca:3b10 with SMTP id d9443c01a7336-21501099d40mr22565695ad.21.1732683617770;
        Tue, 26 Nov 2024 21:00:17 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba6782sm93237055ad.102.2024.11.26.21.00.17
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:00:17 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZW3-4138
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgI-0QIi
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 35/40] xfs/076: fix broken mkfs filtering
Date: Wed, 27 Nov 2024 15:52:05 +1100
Message-ID: <20241127045403.3665299-36-david@fromorbit.com>
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

The test does not do what it says on the packet - the mkfs output is
not actually passed to the mkfs filter, so it doesn't know what
inode size mkfs actually used. Hence CHUNK_SIZE ends up being
calculated as 0, and that means it enters an endless loop because
offset never decreases.

Fix it by adding the missing line continuation.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/076 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/076 b/tests/xfs/076
index e315a067c..2ea6459b0 100755
--- a/tests/xfs/076
+++ b/tests/xfs/076
@@ -68,7 +68,7 @@ _require_xfs_sparse_inodes
 # bitmap consuming all the free space in our small data device.
 unset SCRATCH_RTDEV
 
-_scratch_mkfs "-d size=96m -m crc=1 -i sparse" | tee -a $seqres.full |
+_scratch_mkfs "-d size=96m -m crc=1 -i sparse" | tee -a $seqres.full | \
 	_filter_mkfs > /dev/null 2> $tmp.mkfs
 . $tmp.mkfs	# for isize
 
-- 
2.45.2

