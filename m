Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB04689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683541; cv=none; b=qZ496eoT4QJzI1PPBAMrwwGDNjm1M2fZiTGeMxbapWsmp63Nef9INy4hFLC0Esmek9Od4gEhesqxRS+5X8M+TjG1Vr5U32rk3dqLUT5fYOpTDw2gIhySzwPWjzbuONZ1ntXk4zCWTfB57vKhCJgBgsSHk3hTEI5dtWjB1PE47wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683541; c=relaxed/simple;
	bh=oJAaDjS5ffMmwAPg4C4l3WNAY+wVknRcr2IA59Fa64c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOt49D3pgpK/1xO0W8kdRndeiiEEHts2Sk0vLnIA+cShIQgRQsppwwuq1S3NEQqFgEKx8gbTuGHPXzRS5e37N1ed72wdB+KGXAz0fJ/WTyPEoI5CW4SlMwnxvUMZqkQaQ2X113bQ7oggOq6Zx0RTVoFF8qSgSAz3EuBOCW26BnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MPOEBSCb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MPOEBSCb"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7252b7326f4so1014243b3a.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683540; x=1733288340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hTOuI7jzPuJR5iLCMuKxkGY4seL8nFZpcu2nArCUfY=;
        b=MPOEBSCbaydLdIypPwsnzl5tb3UongwGAyk5Wfu4Tk8nXbMTY167GPXi8ce9JI7mek
         IiBQ6nVn/GRwuVKAQ4V/vREccdyl+/mhd3tTlSjfnZF/3o1c8noBfsDMb8r7NCEVFGuP
         bWTK7+93aRQ/OyNTW+hfEhRrHx8PkiySGn9ZIfxgFXpNsc7SqAGVpToOUi/aRS4kZM3l
         m+fGaYbczcDw/BOx535pbuSQC34jAvvGWteAOkd7UY9lBLwIqstAH7odCgvJAEFOFj2q
         t4yIS6xnLNx+bdeIdTzvBeUVYsVjr8JoEPzag2EOcYbPf3zjnoTSTbHcBjCK17HesNDM
         FM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683540; x=1733288340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hTOuI7jzPuJR5iLCMuKxkGY4seL8nFZpcu2nArCUfY=;
        b=Zjhd5G1qaoXHPz4+mY2mUUb4icKUN2zHhENvLOufSUjvUbOTYN272vCCxksBkI7gE3
         9rwfl5wa2wKaxUPXaFPtQtXTdW47DN+N57yo9J9fXoYXvbwjCwodjJME3ydmBBvng1SZ
         XWma6RSfqm+d2iY+hB9CIR+OtMlGlvCSMxlexGl5GfRXvYjuWcxkgsLyAo293cK1tZ4J
         ouBu1CBQUy/3L++Pk8boyemAUtsdXp3gz6k4dB/JpHOY+7ZVgx6lwh+BcdxdsHZz7lLH
         fb5usy95vEFUgiDjo0vRpXySLdfja5E9NMhW13XtMalsTS2QFCkUm9nYEQlNpLbjcLAD
         YetQ==
X-Gm-Message-State: AOJu0YxWMJnAMhQ7fCY8VTx5G9FCG7i0YArVHXjoWRMEGu+Tlb0oTGZ9
	rx2Lk8KX6XM0zC5sN1nobBztX217/S0rsWJDSXA2gKsZZhkI9gvVkCPLR/vU9bhSMO0RHF4h5sT
	x
X-Gm-Gg: ASbGnctJiFyQFBSoyNBbhoRSDBhT2Eix6n2T25qDBBywkM3Z+ou1/SQO+fc7ZBmj7WV
	CSGyqNDss9CagJFQ4yD/Lrt3M57/gHPZ90YmzsCEAXOxi5FyuRP/EUTKjdcVmFa2NLKLcNHapgh
	QaheBBHSECbduwLAeQkAWOJEGpxVZr5aKrhxiHVnTrOM7dd4B3TAaOJ/r0e5GTWYZp4Pbfj7nO5
	K9hwuTCg0UhMU0PB+NDhisIe9K+OIXw+1R7Qnz4hpob0f9v18Mi7I4OB9RJeEV6hyMi5HljKWs7
	AQfsnYErXFAMfA==
X-Google-Smtp-Source: AGHT+IGtPhKRYPvHYgP8dlRT/FdgMYlF5plhlXpdTn0nPPkEjMRjcMcL++JGWJm2d51KG7mi0PNu0g==
X-Received: by 2002:a05:6a21:3288:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1e0e0b8d197mr2931887637.42.1732683540000;
        Tue, 26 Nov 2024 20:59:00 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fb10f74sm493080a91.48.2024.11.26.20.58.59
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:58:59 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3y-00000003ZWG-0DyG
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgV-0oCz
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 38/40] generic/062: don't leave debug files in $here on failure
Date: Wed, 27 Nov 2024 15:52:08 +1100
Message-ID: <20241127045403.3665299-39-david@fromorbit.com>
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

Move them to $seqres.<debug-file> so they don't pollute the source
tree that fstests is running from.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/062 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/062 b/tests/generic/062
index f0904992d..896590403 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -196,7 +196,7 @@ echo "*** compare before and after backups"
 diff $tmp.backup1 $tmp.backup2
 if [ $? -ne 0 ]; then
 	echo "urk, failed - creating $seq.backup1 and $seq.backup2"
-	cp $tmp.backup1 $seq.backup1 && cp $tmp.backup2 $seq.backup2
+	cp $tmp.backup1 $seqres.backup1 && cp $tmp.backup2 $seqres.backup2
 	status=1
 	exit
 fi
-- 
2.45.2

