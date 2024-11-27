Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D33C8CE
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683250; cv=none; b=tLqcKyhAivuhUZzXMplD7Wn5JcuX056wfGY9jR5wDUS7UUhCq6/r6yw7CLU4EgoxVi97UoApR7elqFiFtc7980u54aviglZMgOBgKjfx93v7azAPGDvRy9TlN2CHGVN18HzoBNMffnmp8utqbqONubHUvIS8zVRD0XlAqrQvJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683250; c=relaxed/simple;
	bh=u0NqGrPHkPBh+ThIyO+QOucAWEOv1QaSJg+9iHHoqx4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYKwPVMtxnO2wZ5eVLeNY0LlAC/EJvj7ZpRilsoCUMxnShLgMdNAjKjRFIv22VygiOdwqVuiya09Q+hSyYa0SWXMFmOS6bU9yysN7aqj1Ch+lISOzxCazg6Sur5Uj1mg9kTGlGeG9h8GB48KONY8ibVHz+loHVFdR4sn1NWM0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JbG8/czU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JbG8/czU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-212348d391cso60994215ad.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683248; x=1733288048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhc88UwVJco40pqZl8KwTK/wY0FP5frjRRPeEfugaGk=;
        b=JbG8/czU3528VzRNnHGgqU+kIOXw4PXPKH4/Gz/W/1QPzSROan9X4+UlnaE030U4fS
         5tJZ0d2756TkkXsNvbHF8teNLkfI8ZBi2eo/7NEpj9OZ7IbCFr7xRerE23TcGmt+19Qh
         VprH5DDSbuc2McZc3+MfnN/epGfmuw7mZ01/ypRZlV65ryUVxiRaL7guy8ua2LhpGpEl
         f52MpD7PnG3bSKdFWyOjMmhJbmRvb4D0KMUAHLwEPUENYywLgEXcOuvnOJ44+hpyHmZE
         tmZ1Bw4beysSToaI/6flmvH7k3GmU5xwdeFp0Ck2oupwGWEEzRh8jGgNJ2SbmTDQBoZ5
         78Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683248; x=1733288048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhc88UwVJco40pqZl8KwTK/wY0FP5frjRRPeEfugaGk=;
        b=X7Emb7YPQIXj7LqjAoU9rsCOR0+paxdcypP6/1/I/2w9E8OdgZXTJxX6koPD4vXE5B
         6EfRFajCqXm6mBjNGkllhO/vc56+SO744Aex6leeq8f+M3/wiIgr8OSJjv+HRDLOZIoP
         adDYCB7FOOKIcBvslb1ubvy/C9vHhPb7jrHSKnX4ud5Iw0f1iKDruIJqF61srWASHIB1
         w/Icm2mhJOEk1X3gf937s2kxHCQHorEIPgZic4bQ3FGOzo6s45yyXEfyp4eg+2rmwxf+
         uND0UXRIJQmIAXf0fMzu680+WVHqXjfis08GNljTeSOZzODxjbvLrgtwF8lfRuCJA4mp
         wFRg==
X-Gm-Message-State: AOJu0YweLoigyd7WSl4zbN9JikzSGfaJwBrmla+nGzMiMMEGJ2jO3g89
	JHmH5oAhZKNOI7iO5J7f1+wTnHah9AafaL30fKTXv3i4paIcVbmORPxaJASzSj3128VgjFL7AYl
	S
X-Gm-Gg: ASbGncs9KAyYiXvCLXyv8ckkFMX+hvrilJRTvT/JGoHhJufL/Xk3EU/S+iUy4eD0UHS
	YTwkV6a8ZHp+XqquM0qmcawJXjhCZCLesb7vpAx62DjyL5Oa8IcvY881y/wkZ3w4dVIEJ1WdVhm
	mj5UyL6th2NEwSkB86tRM86XvlMRBIvhZ8w3gsuDAImnrF/8s++2xeZnezwaXytKtndUz7+fxcz
	bKygPnFakBLgwt1U34y/LWbTN38N9R/+GvbZYSHR8FGvLAPyrX+7r07bMg3XaIfm82m5PQ6M3/V
	GggoDzzgluIews86nYMGS7cN
X-Google-Smtp-Source: AGHT+IHr+iG8VSF6Eabj3RGdNyJ0qE6ZeiC5x4JFP3IIwPQgWLBtKyCg9BAWxOeXYxhfe0uqRbbFcg==
X-Received: by 2002:a17:902:d48c:b0:20c:5404:ed69 with SMTP id d9443c01a7336-21501a43fc5mr22428335ad.31.1732683248405;
        Tue, 26 Nov 2024 20:54:08 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfeb4esm93849625ad.164.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:07 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZUG-3sbo
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQdz-0ArY
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 07/40] fstests: per-test dmthin instances
Date: Wed, 27 Nov 2024 15:51:37 +1100
Message-ID: <20241127045403.3665299-8-david@fromorbit.com>
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

We can't run two tests that use dmthin at the same time because
the device name is the same. hence they interfere with each other.
Give dmthin devices their own per-test names to avoid this
problem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmthin | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/dmthin b/common/dmthin
index 7107d5080..f2c00f5a7 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -9,16 +9,16 @@
 # from a single scratch device
 
 # Backing data dev
-DMTHIN_DATA_NAME="thin-data"
+DMTHIN_DATA_NAME="thin-data.$seq"
 DMTHIN_DATA_DEV="/dev/mapper/$DMTHIN_DATA_NAME"
 # Backing metadata dev
-DMTHIN_META_NAME="thin-meta"
+DMTHIN_META_NAME="thin-meta.$seq"
 DMTHIN_META_DEV="/dev/mapper/$DMTHIN_META_NAME"
 # Backing pool dev (combination of above)
-DMTHIN_POOL_NAME="thin-provision-pool"
+DMTHIN_POOL_NAME="thin-provision-pool.$seq"
 DMTHIN_POOL_DEV="/dev/mapper/$DMTHIN_POOL_NAME"
 # Thin volume
-DMTHIN_VOL_NAME="thin-vol"
+DMTHIN_VOL_NAME="thin-vol.$seq"
 DMTHIN_VOL_DEV="/dev/mapper/$DMTHIN_VOL_NAME"
 
 _dmthin_cleanup()
-- 
2.45.2

