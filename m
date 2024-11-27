Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220524689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683602; cv=none; b=HmKglOZ4hBevnxQk+L4QiLSzBUt3Y+ovvCH3bDrwBMCeCv0CLZyP9sZaUaiie7iY6q55L8zfihEnY0dSuwsqgF9n5FzlkJpIYBbFHdPBzWY8TEnEUGmzP+P1EKS15Mx+KngbfPm47EriZUIbCwv2FtZ8nOvb+Y72pQKy083UJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683602; c=relaxed/simple;
	bh=A0slEnRi3Nrium96xvU6OZMqxy1dB8zO0sa5Tvc6328=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEgwrqjbZ6ViHBhjTzG+OEm8681tl0YOiRFtJCiD1m55a26DHMVnCMeEtfifNyvpfCXYKVQzkHPEIPRay0luW+eeE+dPv7RcfznQdx/JSo/5bG6aOQGygT5bZnA2Fz63NLv+J2L0/Ef9IkG8JLFarufgS7dL9BkYskcC93DL+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pwF6mfMS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pwF6mfMS"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so4818499a12.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 21:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683600; x=1733288400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ho6Fd801zwPVdXsIjfXb0nCFNvhnvHgiMu+2yU1aQQQ=;
        b=pwF6mfMS/fbwLQjBZhxDQ8ZLly36xMMhORGvwiVf+QCcrLeWRCX0T6fX6auOId4mIz
         1zvPkldBzufUg84MFC2OAG8Co+9jpjLiN5BSE4d4mw3786ORNKsx3idlGQbYOHmXwJgR
         pCQZ2hBBE5HV6+hISq8kyTiXEzP+O3lXb08pwO1N8qXiyKuyPLvE1cE1HP5v+tmXeuGi
         2kVHkNwOYOPyYH3u2f9GiAOC69iFZkG1lqOijvV9ceMA6MHZ1T2/d6584Xi3jvNsBiuI
         Ucyk1iJru44LXgl6AV9OJgFmcn2HQMkPfmasK/KJdsXmjaWZFNB9M7AnywhK+S+IU7Uz
         fi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683600; x=1733288400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ho6Fd801zwPVdXsIjfXb0nCFNvhnvHgiMu+2yU1aQQQ=;
        b=SAunMIOiwR+eULBDDL+kSwfw2QHTwryyjSKcnw2V50zggrijOfa6+zG8yYiL9El+Vl
         hmuUTa8homkEGsA5S8zbR8w5S1yA3JIZ/ytBDqWzYUAxj27a2sKWHiA1vmlnOr2tioez
         7xm8lwYWlqoEuXeU5zwh7wmTFXPs0XXwsZ9zYNzCzPc9VVdEsZsEYpiuAixAJMS/je6R
         tlDtE9RB80yhTOgCcZMxQ83kMa2DzSlVMcvDU3NamaiM3+QzbPCVyPSoJCU+iCEYTsIg
         97RuKG5aPIAK1lVJc+11/wk6tCdnF8mh2x6oj3BRZSDwpdkeuu3XcN9CbPZpRo0ODvcn
         3dHA==
X-Gm-Message-State: AOJu0YzHdd7XPIy6nNT7/cwe4cIJP777IbGZocyqIvB2XusdOY/PMcT3
	Y75CTvBndo8W66DMvSDET5TVHMepq72bLOZJUh2q2gwXoidqEtgogAYuwjizfyc1rQB8JeBvETE
	j
X-Gm-Gg: ASbGnctyHMDuI7NiwBvE+jERjELNq7CasbJJgnEVmeCaq6ng2IDdvgYCzQ8x053uN+a
	1rJSIbj953+UHH9BfYQiLFgauOD/auWDSV17BukJqBgxE69qeBdt2MMiJ45UHCU341/sNDW8+mY
	6DE0XlX5rvpBfPW7veD/7/XPmCkVuBvVHg2xQF26UWTT9IcHFx3fIiAJQQXrC2iPZRI7j4WzY19
	kf02Ic5jbkDgBUSk70C3pUDahrEhWyMZP4H8hfK+c6cxmgEzSZE6qez8AJBs1pjMz8y3gbyOBUv
	VVXiMhDYuq1czA==
X-Google-Smtp-Source: AGHT+IFubvdnPshRVsX9HA24Xqjds4I27sHUvdeOKPMCNJBg2on2DhTq6GnKvwzzU9Waq9eW2D4WhQ==
X-Received: by 2002:a05:6a21:3289:b0:1e0:ceb4:b7df with SMTP id adf61e73a8af0-1e0e0b10582mr3217361637.25.1732683600477;
        Tue, 26 Nov 2024 21:00:00 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfee73sm93597595ad.150.2024.11.26.20.59.59
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:00:00 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUz-1iu8
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQeu-2EOH
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 18/40] xfs/176: fix broken setup code
Date: Wed, 27 Nov 2024 15:51:48 +1100
Message-ID: <20241127045403.3665299-19-david@fromorbit.com>
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

The test does not pass the mkfs output through the mkfs filter, so
the inode size is not set up correctly. Hence it calculates the
CHUNK_SIZE as 0, and it ends up getting stuck in an endless loop
throwing ENOSPC errors because the offset never changes.

While there, use 'echo -n' rather than 'touch' to create zero length
files much faster.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/176 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/176 b/tests/xfs/176
index e3fa87c43..8e5951ec1 100755
--- a/tests/xfs/176
+++ b/tests/xfs/176
@@ -21,7 +21,7 @@ _require_scratch_xfs_shrink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 
-_scratch_mkfs "-d size=50m -m crc=1 -i sparse" |
+_scratch_mkfs "-d size=50m -m crc=1 -i sparse" | \
 	_filter_mkfs > /dev/null 2> $tmp.mkfs
 . $tmp.mkfs	# for isize
 cat $tmp.mkfs >> $seqres.full
@@ -69,7 +69,7 @@ _alloc_inodes()
 
 	i=0
 	while [ true ]; do
-		touch $dir/$i 2>> $seqres.full || break
+		echo -n > $dir/$i >> $seqres.full 2>&1 || break
 		i=$((i + 1))
 	done
 }
-- 
2.45.2

