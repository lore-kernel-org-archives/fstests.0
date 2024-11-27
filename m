Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A34689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683549; cv=none; b=k+pcyqTW0N6DwqscTe6fyGhbvPw/SuqyRUMnW+CUCUOj5uf4RUCNwxgqFGPfm0aKmzq126Ctgv5PJPj1SN/lD5h2mhXjVIz6n1tTf2VhmqoqKi1rogLMG2NR+yaRewG5+5IznTKA3SgZI9S1UBq3YllhMcvvs0tOZN+hDSpBbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683549; c=relaxed/simple;
	bh=vBrDAvGw569f9gYfc7PTPsc73tbloCuxkVFwbWK3z+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgqroHBElev1u8gNDGL3wt+6/hq1ApbAL+DhLpeJ/uKP1XzK4VKVWoNkdrAxKTBkxfBSjT5gRqidcbDpOGZ/WwFc1CNrimCCS5StmgHGAbDSipa0rIVmer9cbbYVXwTFfcSnD5/MCDMFzfaQqR5ffFXz2tMcRCaD7YHWJ/EvjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ImfY+H3o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ImfY+H3o"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21207f0d949so60714185ad.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683548; x=1733288348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyXbpCk9ub9DUUkBl5poE/hnVuXSP9Y8jYRNxmrhev4=;
        b=ImfY+H3ow87sFjsVKbiB00Fr+ywOsoB3xn22CVGMoqUozmACawphCQO+Ke8x8IaYPM
         fQXguBdZpObDtiW0GHVxvs+EcUfosscY7dYwmhDj8kBbq5DZmYyIEpEGzxPNuN6HdG1Q
         4OmjbfKe4HLb0lmCZVbXymsGpEE7b4zB0FWpb6zovMEctVWDdDsMCYPXD4mwhTQ/JTer
         TJiqBL0l6nKc9sl/5MIE50rmeKd/hWw304nLee31ECg746s/8NsvLIaqU6CEmFh2VDgu
         /WZGey2WP1K5SnUPI7WBQs/PuKpn1Ye8CubQGTjiqeY1Ppovee7g3xxgJ5NyrjU29KVJ
         oGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683548; x=1733288348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyXbpCk9ub9DUUkBl5poE/hnVuXSP9Y8jYRNxmrhev4=;
        b=jI5OK7A2qC/U8pGjvRm2lfUm/nZpI9+rqgVFm6KRKK8y3vWskc32/vBDkVhsD/oFMb
         M5RbKxle62o4KWC2CMJ/XdN0y125UzpK/0CjOQ6+cMGUt59vvZygo/LO7RLOvcVyZ4Dl
         0Ng1YsNbQDATVxIkBqBvRUm7miUfiQdA4okQyJaqE759P+1HS3f4E+ZLczrs/4DmY4XR
         BGDQ9YYMymsYp7RuJOGyZqf5BaziUwrAp4DGdXb+xDFi4nj+P36xIha3F5W1HZdZKELF
         6JrbSYHklVnZYx41qsOoT88lUTdPpL8EJo4jw2zIEspavHPNlm0Gv7iPVY+7O5jNggey
         xg7A==
X-Gm-Message-State: AOJu0YyzdI8apCZiT7GFyFRzVFBMdLvgo8bWBOKkbzMXufnKvmTC8q1c
	JSm11NoYzfhcbBo7Xn0gpoCmYCkXpXyeCP3hSpFat6MyvVxsiqg5QvV/uqj7vTIvxMeKIxpQ0Ue
	Y
X-Gm-Gg: ASbGncuG9XMw7OOM74gTyiHw5I7SW/QfDAPenOurFkLK71KK3rOz4f0GKtfqQpo0fMl
	qnUWSOQhy15jQlUpjXosTaK5R8rSKOymJFn9f9c/DGepgtiNlR0om7YUGrIUvbR5JTSxA/BzcVx
	Hdir3oGGPT6XaRGK6ISFGaBfBsU4MpeKkwDULEnyoY/m/tJ43RTeYf0EC0LROY+MPQzY/d7i0aX
	U/d4nr6J0zCG8F0n3l/CN+qfZT+PGxqgImeQzWh57eC7pGvg9poVhDc26qciWjh2FxhYFPnNOeU
	NmczhnTIFdTO/Q==
X-Google-Smtp-Source: AGHT+IEMUfpeUoM75pIYuVV129WvtKs2FnV1cb+VyXtU47oXDwh8PgoDKvSuTolcJe1UUPmqac37zQ==
X-Received: by 2002:a17:902:b18b:b0:212:4ac2:4919 with SMTP id d9443c01a7336-215010994a5mr16552955ad.17.1732683547729;
        Tue, 26 Nov 2024 20:59:07 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfb30asm93956005ad.161.2024.11.26.20.59.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:07 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZW0-3uoz
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgD-0GkS
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 34/40] xfs/629: single extent files should be within tolerance
Date: Wed, 27 Nov 2024 15:52:04 +1100
Message-ID: <20241127045403.3665299-35-david@fromorbit.com>
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

The test passes if we have between 2 and 40 extents (despite what
the comment says!), with the target being 20. There is absolutely no
reason for considering a single extent file a failure - that
indicates the filesystem completely defeated the fragmentation
behaviour the test was trying to cause.  Hence expand the range of
"test pass" tolerance to 1-41 extents.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/629 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/629 b/tests/xfs/629
index 34b3ca0d6..a2f345571 100755
--- a/tests/xfs/629
+++ b/tests/xfs/629
@@ -59,8 +59,8 @@ _scratch_sync
 
 for ((n=0; n<nfiles; n++)); do
 	count=$(_count_extents $workfile.$n)
-	# Acceptible extent count range is 1-40
-	_within_tolerance "file.$n extent count" $count 21 19 -v
+	# Acceptible extent count range is 1-41
+	_within_tolerance "file.$n extent count" $count 21 20 -v
 done
 
 status=0
-- 
2.45.2

