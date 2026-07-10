Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCA385D67
	for <fstests@vger.kernel.org>; Fri, 10 Jul 2026 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713239; cv=none; b=WRDK3UOyv2blvy92Ci4TRWrOIoNpmTAhBK8NhV32CiuHRPzEU5uvSi30khyDpSddFwLsH4/3UNQ0am7t5jyuyF+0VDlxmDSRI8NH8OAx02nvaus+rL5AKWcEt4hCqgErYPIMGl7QlZIW7Xl2KI5HYM/eWlQaV9FFolZKWxrvkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713239; c=relaxed/simple;
	bh=Q4e6IKvT8wsMEQQVRPZUJxrDOvgsXmwskT+LSVPtMp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIGapxlijJrqbCrBdARR3GH7x8x7jIOceGUi/FuxZ+kDbvHFld7573l6xaxyue5/y4VJmUXCJxpTy/oF5BB9ugT5GaILf0i+vQJftAqv1Qg1zzEkBce7iq2SzcPh/v6oxtdeG6vCKAWi1s4zdqbllRZvQXKB/ynW69mgoIyhdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrTz6wa0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrTz6wa0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so8222995e9.0
        for <fstests@vger.kernel.org>; Fri, 10 Jul 2026 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783713236; x=1784318036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JemGjNJEkSrxPtSEaV5WW6g56fuFDRtSGrOIp2Fp7tw=;
        b=WrTz6wa01cU5rdGT47gTPjGb7yCbviWNVDAza0c4SDnOYY4FlRttKJbnDTPzm4Vm0f
         LR93sJpW/oVOmb2Ol0o0jgtwlrsCUJlUE1el4Dl/6WDEwlz8UBmcVsPgJ4Ud6gxc7oZc
         WMl0sQ8bGoYAQiVZMugXe78PVTE+tYi5YcUdDo9Tt8FIkn8A2db8gCRIkJ9FJ6zWsqiq
         6THwAZ/Rk+WNinTt8an2zoMaTQAItEOZXoh3mHh+AHVZiZ1sUgaH51WOquIHvgR6lqyg
         myirsBZtTr9McH172f+r0v2DuX1OGlMhg3ePXyn7EAidWjCDvaLjxDm+EItCGw1kHUIp
         ycbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783713236; x=1784318036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JemGjNJEkSrxPtSEaV5WW6g56fuFDRtSGrOIp2Fp7tw=;
        b=qY6+sZkGw4b+SqSQxYl4UpEVz1oRcdZQYrnGAU9SugTsL+TIYpdWrC/GAmnCFwiFqb
         VL8gXNHZI+nCCusplabsS5UH9e1QrCdwpzUqlXpfeAhO63ioiiAz0ggnk9ECbVTlIGdE
         34Usphu39HxyPooDENEsgOLpVNlHPhfwiZ+0yh/95e0lCEnDxeS0k1ApCF03sjve4cot
         k0vRi749jn0i+Xk6LA7nJryQVWBgmO96SvVwTXhcjWLwD7D2C28IgQgGjhun8Cx4hhvT
         EohouUaYAbOzqYGKKxfDjV2TEhhju930KXzLgnIM8pf6rIHKO1zu4Wt3A36vNyFAEGtT
         QvCQ==
X-Gm-Message-State: AOJu0YwO2S6jN4GchexOm0TTMpoXS2AVM+WKgmrgBibNp2qgDBBaBq7K
	lFcMYhcJBvy7MLv0KPuX6nTSYLoCxCfcPMhpmAWm1JlvKN+uVts3Ni2uIfVzIOnQLOGzrZ31B2w
	w1YYIVs8=
X-Gm-Gg: AfdE7cm70XSrpqhUkktYhldaINv5kzLV/ordPoU0t/0w+Ly1RsCfVLKFXhsd7J8jWr1
	ISDdPfXMqRefHHuPTQB6Zfl+HWBtZLViGAMgoYtIIqz9AWVBxj/sQLCUld1wdj/edRACGJkP4Ir
	NHHjmVtA4Ivr+D1gWIvX2g58hWVlZ6wj7m22ErkjsLPB+58pU3aRS/or9tLgPx3pxvnlj3os4hX
	+Zgw3MmAwSyBdtuwL/zpGsSj60UtvZAHzcW1oLTXI4eDG5x9FpAFduWFmiJOBptKKoBQBVNjgkp
	ZOUJjHWFkkiy0e227BSSSSm7spqvl12Nj5CN0pEwhwnNd3QA+egTEDWKChDvY91jfW3z5J0sUck
	Um6UOivM4ITptv/aL8v3uvx+dClaBc+jiYom9Ex1SFYXYDcb2I2L0j5Y6jmkhIBtMSxQ0dnep2U
	s=
X-Received: by 2002:a05:600c:19d1:b0:493:c337:db18 with SMTP id 5b1f17b1804b1-493f87f122cmr2027345e9.16.1783713236485;
        Fri, 10 Jul 2026 12:53:56 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3dcdsm155242785e9.3.2026.07.10.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:53:56 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	djwong@kernel.org
Subject: [PATCH] xfs/083: redirect populate stderr to avoid spurious attr restore warnings
Date: Fri, 10 Jul 2026 21:53:55 +0200
Message-ID: <20260710195355.139127-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" print warnings
on stderr. _scratch_populate uses it, and xfs/083 only redirects stdout,
so the warnings leak into the test output and fail it.
Redirect stderr to $seqres.full too.

+Warning: option --restore=file is unsafe without option -P (--physical) as it traverses symbolic links in pathnames
+Warning: option --restore=file is unsafe without option -h (--no-dereference) as it dereferences symbolic link pathnames

[0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 tests/xfs/083 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/083 b/tests/xfs/083
index 9291c8c0..48deaafa 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -91,7 +91,7 @@ echo "+ create scratch fs" >> $seqres.full
 _scratch_mkfs_xfs >> $seqres.full 2>&1
 
 echo "+ populate fs image" >> $seqres.full
-_scratch_populate >> $seqres.full
+_scratch_populate >> $seqres.full 2>&1
 
 echo "+ check fs" >> $seqres.full
 _repair_scratch_fs >> $seqres.full 2>&1 || _fail "should pass initial fsck"
-- 
2.54.0

