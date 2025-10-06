Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83019067C
	for <fstests@vger.kernel.org>; Mon,  6 Oct 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745251; cv=none; b=FuZsupBy9NZvZqGWmXI23STr0+GEOQb5AtcxluJ0Ch8NugR4PEuW1GqG+pT4aN+hHgBzECdpfwvbUmGbAjd41J7si49zKjTgLprfG82QuLjNgF57fFRbSca7/4s9B/ZHWfwZdQ2FVGew4gO12ha2tZLdMXpOXl0CQVvsDufv7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745251; c=relaxed/simple;
	bh=ssP+Pu8EHHnANvsOdBkNO78FOPl/IHrcayjUL4L7LMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=esXtGxZ65zfqDKa6jA1Zi2NB6jD13ajSOzVV+xLWdGoy3k7i8b1Rpq7ZAYR4JrKBlECkII5eaKaae4Vt6sPrZDQbWYluf5N47aVqUBko2/reUCfKx0O5xd3oDzXY7DWc6hr44axhSF2YzSX83jQZF3x1UVPHvnP5RQiEIjKzBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0ytWamP; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0ytWamP"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-62fd1b03d74so5152503a12.0
        for <fstests@vger.kernel.org>; Mon, 06 Oct 2025 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759745248; x=1760350048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y8AjHP2BMxxekAp+wHrrG6IAM0ijg+DCDAJtMGZzegA=;
        b=g0ytWamPAerSkPXiEPb2n2+TftxwgX31gHZnGf2pczb0DW12TZw9KEbS1xRNXdbd4o
         XSJ5UA7d5F462STeZHMJZuYZ84+uXAEd3vuuxEEAN/KP8JIQYNcyp/WvLeEgmH9snRL0
         svO5zfkTdXDJPZt1iDYI1UilOCvddw8SNgzf/kaUv5X1ht1fauVLW+xpms39zbow8Nn/
         AShX1VLphGXqQNQXW+fjXpFU7YBlVBHnOwikcQ8AphiDUd/pjMY8eauLSGoK/JagDfoF
         NWkQ2yOPGYdUQFI4V9rx4Zs3w83E9LGYvLq6yR1my6hdBcinc5TOBGvCUGtoXRN7FN+4
         CGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745248; x=1760350048;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8AjHP2BMxxekAp+wHrrG6IAM0ijg+DCDAJtMGZzegA=;
        b=jyW5Zsg2FeXvmhCw71iOrVCk8QDQZxKSZrhc/XngrSj//trCcqbWmyvKnQFdNhX0SX
         g+c8XL3Wfk/BUKu2Lzg1VqBB1BbAjzA//lF/Ud7u3fXUEy/ohHZCJck3ArFqYwTIsJ3p
         rcetUByKw51OxUr3LFE5/GGotaWwcRMVyxEJ6ued4q0bBBFx9z6fwXXj2Jx9EtaHL2td
         otkf/2T0rG7GfjkoCC6ThheqpCEj2yY/+sxtd5bV+/glUN5i8ufepCDqb1OrY4kOr1vh
         4LuYgbbBSPexfuaz3nWvSKKy+MYk/y8AhdUcBcH3FFXW8LF23BcbI/JR7scAeV6IetN4
         fuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV43Mk1eDnOZuc90neP9Tk1U3GjA8IEvuCLH0VWpaafnWw50tZ8TCfzcgvdo3c3yoDt09f3z7rc@vger.kernel.org
X-Gm-Message-State: AOJu0YyFre3eAg8ab4MpLEFO+TkBWzOoW0nAo1GuWoFBqKANdyWCLun+
	IBbsCHftSPlS9tO7FZHHwduSKHpD4OdLHrV5Ycg/Mdor0VuJmhQgu66+L82sIlVFxjsYIb3WN4a
	t0RJ5l3DWPA4Gvw+gDGHdPwqg4Qxelw==
X-Google-Smtp-Source: AGHT+IGaOvMuxw+j8+jAjq57qg7DRkWnQZOVLbHJzaCCRqJzVwyoWB4RMYvEZDlpZvF3gdBG8DuwX+0lyPnJryMyeuQ=
X-Received: from edbbm11.prod.google.com ([2002:a05:6402:b0b:b0:636:7b56:c4f5])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:34cd:b0:62f:337b:beed with SMTP id 4fb4d7f45d1cf-63939c28153mr12378079a12.30.1759745248294;
 Mon, 06 Oct 2025 03:07:28 -0700 (PDT)
Date: Mon,  6 Oct 2025 12:07:13 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006100713.3501501-1-jprusakowski@google.com>
Subject: [PATCH] f2fs/009: Add delay after killing socket tool
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

When running the test in a VM on a host with all CPUs busy, the kill command
returns before socket tool shuts down. This prevents unmounting the
scratch, causing the test to fail.

The added sleep ensures that the socket tool closes before the next test steps.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/f2fs/009 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/f2fs/009 b/tests/f2fs/009
index 7333d484..d4893139 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -95,6 +95,7 @@ pid=$!
 sleep 2
 ino=`stat -c '%i' $filename`
 kill $pid >> $seqres.full 2>&1
+sleep 2
 check_links 0 0 $ino
 
 ln -s $SCRATCH_MNT/empty $filename
@@ -127,6 +128,7 @@ pid=$!
 sleep 2
 ino=`stat -c '%i' $filename`
 kill $pid >> $seqres.full 2>&1
+sleep 2
 check_links 0 1 $ino
 
 ln -s $SCRATCH_MNT/empty $filename
-- 
2.51.0.618.g983fd99d29-goog

