Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D327280E
	for <fstests@vger.kernel.org>; Mon, 15 Sep 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930705; cv=none; b=u6i3L5W25xgaAKvg44ANyr0s09Ud0yc2rlrpypemiFaEjgmSCmXcizRDgCCq6JUN3t3nqfsQbebMdCNxzdxVQpCBA9rE7qYUwaN6BKaIqowppUjImzEl83FdOe8o2XPRqhj1Byi38+erDpJdYI4dVjZfFqvoyaCpKhYork9v9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930705; c=relaxed/simple;
	bh=s2ziUCNYAIGDdrADmPQM2T1urNUgcF1abd7E79Xd9Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=su2gIhpz+NZ/XnyiGvAnfXPzaTzI7d2oH2Ac6TDt7qok5eLcIH0SDukvYAmOS9H8zM0Dc+ltlnpiatz9bSmbpj8DTyoyBc/5X/EaSujOOAqNeXLWvY1p/BnPCOXhqSSI0E/U6hy/gJs9goGqqN1STurWf8/gx5poQz1zFNV4TIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjFx2URX; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjFx2URX"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b0c1a67399aso130613666b.2
        for <fstests@vger.kernel.org>; Mon, 15 Sep 2025 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757930701; x=1758535501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhOb+fXoz/JynstoF4uW9k/iZuOaeZSzWY+DYBWeboA=;
        b=tjFx2URXMc3T6Og8jXaEA4UfNEQIf+OLwp9L3CGCvgrqujBNRu+fJoT4533djiJGLj
         wFqz49dmXgq2wzV87Tp9MEf504LGD8dlaU4w+j/4fQz0GWthbkfgIaWm7rb+yoXdxfYq
         nQ1PF9xjLE4EqCVIjyiaDVvcOMLzSG8DSROk/1pgJGTqTCfhuSoMyfiy8+Ou3s8eBm7o
         IQGMCFmA48cgP3Mly2eUKxd3VPfn+DmkDxlspGDtkR8GUTpjyhd54tZ2VsNfrbsHh4rn
         SyqsRP6w58+laKcTYM6bWIoeWdldv1k9BsdAdzV4xdrZQ5rmuPBpcjvOE2ym91pqLXHJ
         5kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930701; x=1758535501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhOb+fXoz/JynstoF4uW9k/iZuOaeZSzWY+DYBWeboA=;
        b=nql5/kjHqKOkGFJ8dVHppodpiTN5mZElUDapa696bh5fngdPvLOB0bbk3CefusIov+
         9OP/QTu0aNPoDLT07Wsl9L6KNjjdKNIFOG0xAru2Q5Cqyi4vXMSubkYPbX6MYk4GIwbe
         tQ0Auq5lLq7iljl43FrUGbKlXPcstHWpFyGUqqdRER8g2tZIkuGMf8/5n+mj69jmoLO5
         v90ikeQ5fbit55B7/kPztxjQCxJHsLcWq1l8PflycLlF1MGXGe0wYoVxgbiDgGEWO5rT
         bnIheJ/3efnD9Z6MRtFTi2rzdW0FR+p+rPwSi39cO8bH4xR9UIZ0H2pmhLzz9AX5+WHV
         rCfA==
X-Forwarded-Encrypted: i=1; AJvYcCWQj6bS7eqO225WEt5tsSPf2bLW3OvmjGW5P7nzun7P6i26fhCaSO+3N6CIVGm4ppGo9P0DgWAs@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLvsXfO9hyc1Js147Pg+l10fwdTLj+hvyIxMR1cR4f3O4GnSd
	ZKDWSBpKlxMO9lhLrKt+lYQ70XpN5cVYqzd5irbWCKCLJ3Qg8FW7RSIqS9GyEnEQwV1bCkdfQXu
	MBRNkLU5X1SbZbXq56+Mf9IrdGKkwig==
X-Google-Smtp-Source: AGHT+IEJoLywW7u172IwfK9/WZbn/vWDjB5heLqpeIZl1R5HWLwd/Sp6g2o2dBQVVVgodrM3OmdmACuDrPXNTYNgOsU=
X-Received: from ejdcw6.prod.google.com ([2002:a17:907:1606:b0:b07:e174:152a])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b8d:b0:b04:aadd:b8d7 with SMTP id a640c23a62f3a-b07c3540759mr1152316466b.13.1757930701187;
 Mon, 15 Sep 2025 03:05:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:04:51 +0200
In-Reply-To: <20250915100451.810719-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915100451.810719-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915100451.810719-2-jprusakowski@google.com>
Subject: [PATCH v2 1/1] common/encrypt: Do not run _verify_ciphertext_for_encryption_policy
 on compressed FS
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Eric Biggers <ebiggers@google.com>, Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

verify_ciphertext_for_encryption_policy() checks if encryption works
correctly by reading encrypted file's contents directly from a block device and
comparing it to a known good ciphertext.

This, however, won't work if the test file is also compressed. So this patch
adds a check if a test file is compressed and disables compression in this case.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 common/encrypt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index d4f6e3dc..c25ff5a4 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
 	_set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
 	for src in $tmp.testfile_*; do
 		dst=$dir/${src##*.}
+		# To make sure the test file is not compressed we create an empty one
+		# and disable compression first (F2FS won't allow resetting the
+		# compression flag if the file has data already in it).
+		touch $dst
+		if lsattr $dst | grep -qE ".+c.+ $dst" ; then
+			chattr -c $dst
+		fi
 		cp $src $dst
 		inode=$(stat -c %i $dst)
 		blocklist=$(_get_ciphertext_block_list $dst)
-- 
2.51.0.384.g4c02a37b29-goog

