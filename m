Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50223EAAA
	for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730513; cv=none; b=W35DxbHvNxxQJmNfnpDBgbXUOlui7Zqy/C99XHGl2hSAtzLYeRlY3U+1ODBgkMLYN9ljuQ0lYRmKseCyW6REMT7yk8b2PcjuNW/WZZ3l7tuy7YgcqLZpxRWXwOV6w+xe55oPtn3FPvsnDY5mbZtHgf6XLM2s4slsxsYOvs/bKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730513; c=relaxed/simple;
	bh=Xv7gDwmfJZzwcuznwHUzJ2KZ8K1UHUt9m9J2s+QW5S8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hFWVUeaQHDv6DyAr1r0ceEWxL03RmX94vFRhIaoa8qfvRWw4hPrbZfMSXtkR14u33YrqiXRrrVHk/EVuae3lc7WV9MMPMyKvMCe6J2YtVw8XTzuwsQEYpW6F4CFCEaY0wDCQkkMxelEaFCqwy8NXZJiCb+fguMdd+OfjNBMvUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGk/DVAA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGk/DVAA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b646768eso7157300a91.1
        for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761730511; x=1762335311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TG7hKlVVldxlYKW/0fbCkRJaaVtKZa4iA2igZCm5fjo=;
        b=kGk/DVAAcbw2832B/ph0AJwieZyD09QHGu+g8vdOCxNxKdbBEVYCxlpOh7b5M2xdC4
         cBYI0YXzzIb/w7tQ0mp7sqAE8qWCkwBABq/fbgOwIcNTOsST3d8Ohyu9Oa4e7a7ddd4W
         mwk8M/2HSVJXWMXJ77LpnEDzp15sEFGKgOUAVoALq/qVPab3vqcJ1wXqo/H+WeMSl0cE
         g0YeCGTRf64MYjsT+qpQd+1MQSBhQyRZfDeeDW2v7x47RFlQ3p87vsFj5uDdnfb5REzt
         Zt9/i1S8KFvQcTiKWl4Az/MogIDhaGHdlvdk2xkxFUtxdnmSi0JvrTnwS+5wck4sEwui
         +67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730511; x=1762335311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TG7hKlVVldxlYKW/0fbCkRJaaVtKZa4iA2igZCm5fjo=;
        b=EJlFwFpW2F5LPrEWxILspLCc6/ab7pWrpG6tV11IqSR4Mw/aN6NEih/Cj64554q1ex
         L8Ay9R6vILNrametlN0uovZeDyiNssrNqQLQ9LL+NtWa7/apOSRCVuHblu7QBrEF092K
         ODfsJUx6zgzM71l0cpxmcEbrkcgYCpQILUnLS/TuY2ODvghk+Ofs2HE966FVXF/YStJ6
         1LnIXzQv1UMEoJfxLkDyvHXQGojU3rAhK/bfDB6ESIWO0WFdHHQh8DlkyjiiFhvf4Hkc
         Lm0QJ0dJhwLEGKUhg/oNQzOUm62Z7kvq2TA3cdJPHksbaa40MshDjNA5dpeJp4cqB4ec
         SfHg==
X-Forwarded-Encrypted: i=1; AJvYcCVUIQRmrR97uitJj+xRcyRT2M/uFkFpn3vwJyXP7Qfn262HN3d5kbw2NrY/8u+QhcSGk5seoD6j@vger.kernel.org
X-Gm-Message-State: AOJu0YwozReiSNAPgdT1vfqHqtzGTUK/po2VgyAvzsiw85R4GDFM/6De
	nekfjf8y6sCWGAekfYKIoIty+GLmtZmI8/niilUk+xuUfvBCrFmKUP8IFfooidvXi2OE3UGJbMx
	nxN08zkGyAOtZN/3XwhzBhoCYyQ==
X-Google-Smtp-Source: AGHT+IHR8YkI7WIhmnwbsdBqu8NfFmfXLDaTUM4XSvRgD3OsxYZdVP7ypYFRVuhN2SG9DLeF+gErD7zEhckJvL/uIw==
X-Received: from pjbcp12.prod.google.com ([2002:a17:90a:fb8c:b0:339:ee99:5e9b])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:498c:b0:340:299e:dbc with SMTP id 98e67ed59e1d1-3403a265483mr2712365a91.16.1761730510939;
 Wed, 29 Oct 2025 02:35:10 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:34:57 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029093457.183578-1-joannechien@google.com>
Subject: [PATCH v1] f2fs/011: use random data to avoid file compression
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the created files are filled with 0. When filesystem level
compression is used, they take up much less space than expected. So
the final fallocate does not show an error.

The created files are filled by /dev/urandom instead to ensure they
are not compressed. This way the files take up the same space whether
compression is used or not.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/011 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/f2fs/011 b/tests/f2fs/011
index c21cb586..75679b36 100755
--- a/tests/f2fs/011
+++ b/tests/f2fs/011
@@ -35,8 +35,9 @@ _scratch_mount -o checkpoint=disable:10%
 pinfile=$SCRATCH_MNT/file
 
 # simulate fragment status in f2fs
-for ((i=0;i<256;i++)) do
-	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
+dd if=/dev/urandom of=$SCRATCH_MNT/0 bs=1M count=1 2> /dev/null
+for ((i=1;i<256;i++)) do
+	cp $SCRATCH_MNT/0 $SCRATCH_MNT/$i
 done
 sync
 
-- 
2.51.1.851.g4ebd6896fd-goog

