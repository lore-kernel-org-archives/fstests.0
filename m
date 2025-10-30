Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D437A3BB
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803228; cv=none; b=TZmLhbZzt2xzUBv5dextgjYbjd+TYSRJD4BvcVD8ST9PSYjBkqSbzaL/iltXF6qjcFYgCqB9U32nq0y2ISlasJY7QY0yy9I8yoRssOqL/5/y1g64piv2KiXrH6OgXWikuL5pS0+s1RNF9W48Awms99M7iu4y4lrz4jxMmcOrV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803228; c=relaxed/simple;
	bh=pvuwCHeBtdbQ8eoZmW8m5GdSIEoreEGvRu6TM8IyykY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c8l+wjAqHo5tZZHG+W5awfrkuf7NCeVxR313LD3dVQ+U3dnUdQGg30fVG22MDOvF9jjCKUR754ATk7szl66G7hVfvJtGFqWoiyBWni2Ju5kmAi7HJpoq2dIL5eHCGTODpLxARqsKsVJMIm1DInG+HkoUBQICT54wwBywjBC7Gkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRgLjLE9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRgLjLE9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33baf262850so724347a91.0
        for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 22:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761803225; x=1762408025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nSia/EkEjOq1PfGwKO1FOeTRUFNCvI3AbrOEQ1lnPc=;
        b=QRgLjLE9Gspr7MXvPsh/6qeyx3aairryeUcSKW8CTY1qfHEUQtiIjSU3H8CIU/Wy5i
         msdUGPG+zVAgrUGSCvD5Wb2f+k2qMn2gmDLkT+7FjSjjD3lDKA4RtuZUcJ2/E+blrMNW
         8sLHGG54UBToic8t5AC0JdxMEYEtly2RmJaresR4Ih2BtyB1aJsjb2Nw0j4pzKvh1f8S
         MapG56o4ZHVPgaw7G3k/YZt5h7ur5LA+75O0L5mYDO5/cUIxeYrm5dZA8pftUgGkUS3O
         QzPGQsiaOYmlUx/wTKczyLCIwgla/DuaVyj5hhinQdS8laE0aTu6TJMEZpxt0m6ENWsY
         RlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761803225; x=1762408025;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nSia/EkEjOq1PfGwKO1FOeTRUFNCvI3AbrOEQ1lnPc=;
        b=fZxJ8hpuQu/yazzBv3xPMD4FzQx8Megmx6htPahusXw5fFO4Czz5SdVRC9ZLHHKk9z
         mQ67N1BaKkzDqbD+eGpcjnmDndjDlHJL9KRRx3lFr8UQaQFGcs6wsVHjNmWM0ubYN8gq
         rhGzPQRUAZ8h5mYvXLNogGaxKU3h4+45/hd1N3xGT4lKBp/0jGA9Ph8E0VTUSHnu6hH+
         3hirkYEkSOeGKO0DTNe5ICGJKhxqwAYBCakGPjAaF2GFFk6Xe+HHJ0EVUSqfNOFcHfd/
         gbeJp9orB/dVCUIUyL+SpU8Vs8KNumnLaeCknZOs6QYxRySEg3QIc8IIcRgSrLCsJULv
         FO8A==
X-Forwarded-Encrypted: i=1; AJvYcCVcbTHtvrpVAVpET5T7jsxKYnjou1/kwRBRp85NzbD8/mel0U3rm7GDb9NV4u/NeglmB7Ow4KEw@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqu9FxLM4YKpH7PR4pLKtB0X8Mi5Nqbq6b9pBM+hr09joaZZ3
	DP5SBWFGb8IMhsGFI8cUHf9fg5E9Fknc/8LbpveEE4/QqJRSN0eKv/nnQS6MtwhwmU4tP17RDex
	4b+hpH+hSNv4BZ4vN4DenemqrWg==
X-Google-Smtp-Source: AGHT+IHEs1oYAPW+Nqb69swABbBSDxauRlgHBigamCQlZkyY/7LcZgCc2+Q5Oki8i+hQFYOXic3py2MMhD0vZsiOGA==
X-Received: from pjbnm10.prod.google.com ([2002:a17:90b:19ca:b0:32e:d644:b829])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c85:b0:33b:e034:c1c0 with SMTP id 98e67ed59e1d1-3404c45284cmr2349460a91.23.1761803225587;
 Wed, 29 Oct 2025 22:47:05 -0700 (PDT)
Date: Thu, 30 Oct 2025 05:45:40 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030054540.278518-1-joannechien@google.com>
Subject: [PATCH v2] f2fs/011: use random data to avoid file compression
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
v2:
- changed dd to $XFS_IO_PROG as suggested by Chao Yu

 tests/f2fs/011 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/f2fs/011 b/tests/f2fs/011
index c21cb586..07c94d8c 100755
--- a/tests/f2fs/011
+++ b/tests/f2fs/011
@@ -36,7 +36,7 @@ pinfile=$SCRATCH_MNT/file
 
 # simulate fragment status in f2fs
 for ((i=0;i<256;i++)) do
-	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
+	$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 1m" $SCRATCH_MNT/$i >>$seqres.full
 done
 sync
 
-- 
2.51.1.930.gacf6e81ea2-goog

