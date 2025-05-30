Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDD1E2607
	for <fstests@vger.kernel.org>; Fri, 30 May 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597043; cv=none; b=Eiw0qjmukJ1Dsr4wSXxsrqBZbk0k+aDcZ6BSlfiGbX2FcxZD4n7hlRCJlIes5tLdccgX83tSqLnR3SksdA36wRCmQ9Hx7F5MG2DubHJmpdVXhiHkEcPmL6Mrkg/dCzpVXmnMkdsAFRFqmynEPc20bcMihbUFJTU63Cxn515F/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597043; c=relaxed/simple;
	bh=upks11UNb7Bj2+PIQfyKVyLkQHPpiiA0oWyo+RxAgWM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ikhSFNOn9ze7hI2lsD8y8UTXxvoMN0L0RKQmblBOh68UuZctDOKYeJbQ4o0E4kBPCCfyoKHJrSViBk/T0Jy4D7Gn+q5KCTIW93Q9u+QRphk6IYf2NLk9sqeZ1C6Mm+vFJlTuFhA5sJ/EggeY2uRnKrgqYTxlxJ5iSRp9ypag4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usVFYk+c; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usVFYk+c"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6021b8b2ab1so1731725a12.2
        for <fstests@vger.kernel.org>; Fri, 30 May 2025 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748597040; x=1749201840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kNsoQrbO6r0+t/N3UUDEwd5dEvoE0yv1vSMzQKLNhHg=;
        b=usVFYk+chdQqYpQBuuAS7BFKexFVb3k5tHQdbNz/N57sJnbJb3l+FiKxbCryVWCQ0f
         vBmE2nJGaww6rQL2Ofj+UA2fB3Z47BA/Qbfd8jZb0o3JXYYRDizpuILGROfN/w8h5Tnq
         xsqyJLbrRg0yvLhgseGPVI48e027Dck4jae4hngYtsf0Jy/Ob/m91p5aAu69k7o0iW68
         lzqKvJcnoshVbUbWYmB6vhZC6yXrO2c5VVnh/mFbHYjNKtVubdKeZVj00wTF+DbNSTya
         ZkQaC17+I5PgcqLiNlQlzWLU+VgdzxbvnIFp9GfBqq9PWuEc9s52GeIuSAk2ZAbiFgiZ
         sobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597040; x=1749201840;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNsoQrbO6r0+t/N3UUDEwd5dEvoE0yv1vSMzQKLNhHg=;
        b=Jw9NsfM6Nw2JoAkwL+a5Z2pMs+HC7+URk27YwMVo84q4SetQ1pNaaw7KvE+Snaim/j
         G5JdYPpT7gHBNfwXjoZkGJ+s0AghL2MG71/sTPNA3X4hVVwJI9yJI5sfm/1L+kJOi2ih
         tf8xb/gUoNAG5pMDTqLuGid9S1tolRPa03UbSW1PN6nmRoOBL578jsix/OpfLFfqNpah
         SvYOboZoxajuNslA1/GQxsLyLFK1B07l3azB0QhoIQFiRxZcLV8g96VcMbZd9Z1hpGso
         XFARji++MVzwrpYeHYv4J1xRjfSLqyCSeFpAYOx10XXCNGBWnby4kUxrCrrrzc7XkUfn
         42GA==
X-Forwarded-Encrypted: i=1; AJvYcCVDecW03AE2q/iI15E1epuB1q01DXxp6adcApVS5ccuWX7vbacvUUGV6I6IhizbeyvYJs5GvQKw@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGT3jG9zcE7QePslrEwHQBS0VpG+WSUcrnAArnvDygLiAkW7Y
	/6ppPpSv19XdRmA5/m3JApUb51aDnY5DxyKLVWXGxAZRohP9oNP1z+RyI4+b5BpkX7jZ8rN8ZDM
	OUNtWWoN6Bm/X4GKRZofmTW0LLIF1jg==
X-Google-Smtp-Source: AGHT+IE72Av919IDDm4wEfbEzX4XfOKhpgZ1L0ybT1n1bbC7V6vlgXaojKI4rlGgqekrC/BSpb6havKaBqZVlhykYEQ=
X-Received: from edbdg5.prod.google.com ([2002:a05:6402:1d05:b0:5dc:2205:e2ad])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:26c6:b0:5fb:c126:12c9 with SMTP id 4fb4d7f45d1cf-6056e2586fbmr2079020a12.25.1748597040124;
 Fri, 30 May 2025 02:24:00 -0700 (PDT)
Date: Fri, 30 May 2025 09:23:49 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250530092349.3407742-1-jprusakowski@google.com>
Subject: [PATCH v1] f2fs/004: avoid race condition in test
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

In current implementation the atomic write may not start before
the direct write and the test fails.

The patch adds a delay after starting the atomic write process
so it has a chance to actually start wrtiting data and set the
internal state of the file correctly.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/f2fs/004 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/f2fs/004 b/tests/f2fs/004
index e08cee11..ac824c43 100755
--- a/tests/f2fs/004
+++ b/tests/f2fs/004
@@ -40,6 +40,9 @@ touch $dbfile
 $F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
 atomic_write_pid=$!
 
+# wait a bit to allow the atomic write to start
+sleep 2
+
 # simulate concurrent direct read/write IO
 $XFS_IO_PROG -d -c "pread 0 128k" $dbfile
 $XFS_IO_PROG -d -c "pwrite 0 128k" $dbfile
-- 
2.49.0.1204.g71687c7c1d-goog

