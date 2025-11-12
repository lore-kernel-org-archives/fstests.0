Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C851229B12
	for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955561; cv=none; b=soOZED8zMM0g4+6MTPhtguuBpjjfJjXkfdMpYfTXVwZ51UGmd+qtwLw5671tRIwi+mtycccCm2nSRSr+S2nrlKgoIjkzm2c76FAZ/TUWujNZ3pw/ntXGIBCGKzNNE8Up8tGqlaGdDhGQqYk7Jg64jtIM4Cibqrs2ySLAfbBxI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955561; c=relaxed/simple;
	bh=UWb08bRPfXPtPWx+aZWuY8TV33Rt0cUOHM2jOayqbQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m7/6L074t45DTAzGk0B2bVBN9ISj9r6QuJ1LHX77Ky+otqQIiS8M0tTofqjb+AKBqjfOvwiliTGtiqqzDHFkKFHYg4hppVXPuvPXUj2NYyyXcLSQCNl8DTJSZtIcbUYYmkCQ5gL0Gs8gNMALhpffGfdMtNXFo42S9DnnrxJuPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHctceBa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHctceBa"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297d50cd8c4so22876665ad.0
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762955559; x=1763560359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ6Qy7ndj39B6pMalkS3qilQZ+lIftQt3Cy+FN17e5g=;
        b=iHctceBaup9pKFU1xwwafW49343pbbf7ibPCSzoQUC+QqoOC4JsZVXGk1Ur0ch5IsS
         i5gkePs8dbjwl7snzgXtPakV6b4bCr026zy6RGeHjfUdugL4s50kqYAoNw7wBbtcIBWt
         iWwHgA3WSMvfN8eQyM8MOACf7r94Jzq4HvIE3q3W6vLL0t+OPdDhkDLAO8dvBNi+5W7t
         fkzoU3k2tz85x4U+lyhQAeCFkgjO3r7zuiB+FgRmd6KGHxivyuhh3pzc54qNGtq/+ePj
         PCAzq8XIMJfNUkhy/JfNE9pfYietxt3n1pPiJ1lhDlyW4uumULJiXpOf89sSV/wbOJ+B
         4KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955559; x=1763560359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ6Qy7ndj39B6pMalkS3qilQZ+lIftQt3Cy+FN17e5g=;
        b=YnrgU4Jc9j28Bey9F+CiNj0VeTLwjQapmvgRYiaMr5M38k+YbFPZCdPdhcAVBDhIgu
         tzLXxe16YowB7gUrTnlDv5ayxR919RO9PI8ouaMBoymYXhBCFBN5iVhR8FZqLhR7RL2m
         yiOVIK2VTRIrnqleN9QGvOxuYvKFUSqVHVdbxqSgB9IVHU4pMBtFmZ/1KMv3JWizvlK6
         LtxP2mfvYo9tCEI+zsA5yOHB8imiUbI1D2w5ww13kaCGfCnd0CITeUHxN/PA5HRe5x3U
         pi9KLYZtyxCyV8jIa3Qg93PNRZTHM7VGpfP9WlRrCzay4VXgUvogz03/N+BYpdV9slKB
         Gkuw==
X-Forwarded-Encrypted: i=1; AJvYcCUMvSWE2kCrCk1sh3giS8iBjTqiiCw3YlhC8Ux8NA8q0BakePNuXAIHJ9kmk6+sN02H0I43dwsO@vger.kernel.org
X-Gm-Message-State: AOJu0YyittK8TUs6Q+gmxg0/idBTckl3cFpmonHwooImimMkoOfoOdh2
	yq4tWAl0tThR7dbD/4wsEjkvxwQXxB0yoR4+U+bgJ5lZrLbPNuhGLs2nXJFnMXd8Xp8jFcWlWot
	JA1Z8QmJKgoAONgYr///mdonGSg==
X-Google-Smtp-Source: AGHT+IEvwPE8wXHAoTH4+kRCz/nwKtlAXCsMVOxHQHz6fO63yQ7yVeRoMRbdXyB0GF6cp2lHZ9lVEAu4F9AjgFQhJg==
X-Received: from plhn15.prod.google.com ([2002:a17:903:110f:b0:297:d52d:2b6c])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dace:b0:293:33b:a9b0 with SMTP id d9443c01a7336-2984edcada9mr39893955ad.32.1762955559492;
 Wed, 12 Nov 2025 05:52:39 -0800 (PST)
Date: Wed, 12 Nov 2025 13:52:23 +0000
In-Reply-To: <20251112135223.3467852-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112135223.3467852-1-joannechien@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112135223.3467852-3-joannechien@google.com>
Subject: [PATCH v1 3/3] f2fs/{019,020}: clear MOUNT_OPTIONS alongside MKFS_OPTIONS
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, f2fs/019 and f2fs/020 only clears MKFS_OPTIONS. This causes
the tests to fail when leftover MOUNT_OPTIONS depend on unapplied
MKFS_OPTIONS. So MOUNT_OPTIONS should also be cleared to ensure reliable
mounting.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/019 | 1 +
 tests/f2fs/020 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/f2fs/019 b/tests/f2fs/019
index a6e6e38c..721f2180 100755
--- a/tests/f2fs/019
+++ b/tests/f2fs/019
@@ -22,6 +22,7 @@ _require_inject_f2fs_command node addr
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 
 testfile=$SCRATCH_MNT/testfile
 
diff --git a/tests/f2fs/020 b/tests/f2fs/020
index a6933134..eecd312d 100755
--- a/tests/f2fs/020
+++ b/tests/f2fs/020
@@ -25,6 +25,7 @@ _require_attrs user
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 
 testdir=$SCRATCH_MNT/testdir
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

