Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFC81AD7
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683254; cv=none; b=T6DhkuNgcQQCVMU3S5qntgTkDGX3jVbHVVHNxaILIWrMZRgbLG7N62lR7Iv8O7ZpOCd+cMYLXWeTvJof8ogGMXKNu28gM33OxmXCXmg4ffXSmkvGPHRxNK55O46VArLJxxrRs0oWNqbWNf66Cgo0HsY7Q3QjSUWx4v4crwls3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683254; c=relaxed/simple;
	bh=4HUhmOuklofF3hdxIssO0B3uY7NHx2eK4y8TWUpNwpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZbbGwk+Te/hxiyqMyeuI7vQaeISCS6y6he7tQHomC3BSs7J5NyxyiCXbbqPqOBQkqz2sO7fKNrfoB59vhBwG26A3KS81tUO6cduTvjZVwvY6QqXTefBXzmKg5Z3wzljyGlWAipADRyBNG0OXCmZGtNe7kgwFcKmXXIblDImxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wNolsrST; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wNolsrST"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724fee568aaso3455670b3a.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683251; x=1733288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FelxBb4HuL38hiN4TbafKM7UoqDyP2KHet7HbJIXe48=;
        b=wNolsrST0bpR3o1TrfscCSn4+KGputR2VI9DFOGioubD+kD85lfvLYgvM5ZlJPRwIl
         54BpR48vr/K/5WGOrCCzOW5Yiju3b2vllILd0MWCepagTx4lDgAH91GLc4UbD12o8Jdp
         aVqQEdLO2DAlviJO1QLVD/Z4vhNULfL3SBSwUUT28J2T0KDSo5bwF6yAM/T6NYOrElXy
         osYTAsMu3JNFJPVoT/0RiZpPKYctfs2FJMB7KpZFZznVOdvnxyhw7sf/d5i4P0O9bHtk
         pyj3nUrkm9PdbZxdTDh54nxkI4y3N+0pcpxoo/CCwcU0grCZroVJkTlMHrBabSN/3EUz
         0sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683251; x=1733288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FelxBb4HuL38hiN4TbafKM7UoqDyP2KHet7HbJIXe48=;
        b=SoFB7Ar1cX6ZkzDABjtNxLxI9OXLSGlUFdbhr9MTDkpnjcz8myQMmZXstspb3EsGU9
         koy6beMtJOuUb993toC/D9P4HXHwt5PFiUrub+kBk3Fz6PQlICbO6B2BqMsh2JJYFQif
         MdBHq5yg6EpV9qSkNYttdnaxbHFXlVy4sEpABd+Rb8khNhwfK8v7lxvj88FSgbg0yjkU
         R6tpSaeW/tWanWS3fGjHY+7nweY+ukUs0Az2PITI8wfemPRA3DxFhuD99OQD/2X4QhTt
         fQFzUNu05K6EGbcYRLcapNHraIDDz/Sd2fgl73mTSh7U2nHf5E0UYe5914mv9c5TIc9u
         z/cQ==
X-Gm-Message-State: AOJu0Yx5bMNZPA8FYP49JrtYH4FH9Hc3EhRya/maAH14UhHvTwTG/9iY
	v9pQtfQl5PMeYz2+dT5d+Ns+FHLiy4Qp93VzFkTvwOeWn4H3VszDYQQaEtFv5tVHi6ZMo1fwKxH
	9
X-Gm-Gg: ASbGncsn8JuHaH3BMf24aQCxO2lbNDZkempvZvETUNKunCok+zsoWTYJYvkAldlnR8r
	FNkYU66bQv5fHMIkTpw56soFEAqtN3BDYWIljsGWheF1IrciOm81nvKjidcgPevx4XMbJ/Ey+z4
	XJJt9KJalJOkGMr/wIjnbJbDXFtbjIDaBkdxBT6Y056fw19qGvqgtL2+Cet2cHWdQ1i2dXeA4KJ
	s3oLBrVLKFh8u0GhjmFoCe29+yFHZBsdflKalp0P+LTRT6PP7Z4MukkuOdte7g0i2CdCKtnxRQm
	jOOHHG3jMcE977a8WQgd9xy7
X-Google-Smtp-Source: AGHT+IHWdUYnSGA3hSbTYPBVuWXrtvX9aw3vGYLCa6SILYvSUl9/jQQxtZ+ZjNu9ezCXLG3hXEerSg==
X-Received: by 2002:a05:6a00:181b:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-7252fe113f6mr2430067b3a.0.1732683250785;
        Tue, 26 Nov 2024 20:54:10 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72506288250sm5694766b3a.20.2024.11.26.20.54.08
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3y-00000003ZWB-05cq
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgR-0fzr
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 37/40] fstests: always use fail-at-unmount semantics for XFS
Date: Wed, 27 Nov 2024 15:52:07 +1100
Message-ID: <20241127045403.3665299-38-david@fromorbit.com>
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

Rather than require every test that tests unmount in failure
conditions have to set up fail-at-unmount semantics for the
underlying filesystem, use these semantics for all test and scratch
device mounts.

This currently only affects XFS filesystems, and helps prevent
unexpected unmount hangs in EIO tests because metadata writes are
configured to try forever by default.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 3b4b9a59f..7f4a71bd3 100644
--- a/common/rc
+++ b/common/rc
@@ -410,6 +410,7 @@ _try_scratch_mount()
 	mount_ret=$?
 	[ $mount_ret -ne 0 ] && return $mount_ret
 	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
+	_prepare_for_eio_shutdown $SCRATCH_DEV
 }
 
 # mount scratch device with given options and _fail if mount fails
@@ -609,6 +610,7 @@ _test_mount()
     mount_ret=$?
     [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
+    _prepare_for_eio_shutdown $TEST_DEV
 }
 
 _test_unmount()
-- 
2.45.2

