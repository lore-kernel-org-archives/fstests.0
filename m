Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10317357D01
	for <fstests@vger.kernel.org>; Tue,  2 Jun 2026 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384824; cv=none; b=ZwugluZKJEapNYxCuXMfuSRK/Nl/Tsbt67SFqhLLTST48fTs+50DDGX4ltcJEqkYJWXvvsz2tULp+bJMXYaMwOoBDPQ5b9xurOKsh53agyKeibNUy0/hQ4wyD4Q5vUVMPrmc7rSsZsvckA6UmmPfauHNYEJNpKEYaJV+9MKgQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384824; c=relaxed/simple;
	bh=697k+mg9eApcxRBABdirczqWPUcv+i0MaEM53NbUY7Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q3q8BinNUn9CTEjmxikkAwKR4tWyuczusofiyP83JabV6haZwGWQi3/fvnxxkNuCZuwOLNnbgWAgP0vAfhI9ElSz9iYMhHqxBTgxq9mWwd/kxbebl4ThFxG80vW98OJJISRqzb4dmUcyB/F07hQvZg9RcMe9s6fEzxH7WmlWLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1bi98IH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1bi98IH"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b7f696b40so4381052a91.1
        for <fstests@vger.kernel.org>; Tue, 02 Jun 2026 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780384822; x=1780989622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvADwMamOgSgMnsZzgfxJFHbU/mitHRiQMKS8+1jQKo=;
        b=B1bi98IHHB/9i5Cwp8WSJmzpO9kiA7bw3QIoNBrBmxvqXb93rKhQTpTPhC1rpfq6Yt
         48BFW1lLkeP1Y8C6OK2Mzd67EIC025Fn4iHX8OBi10+VvtNf0ZMnSepX33YQhhinOY+v
         2IXTLgjW33RisJRjiQVAF4dyMblUn+rsUhb0eCdrDxruOnS1ABcm3tnQr7RqXOyGgMjq
         KXJvbEKcs2ZrpM6tYHwAMSbHvSuGZH76G69gSfgLvU79CzBF8XcbBgO/ZyyBA2ABS/Vu
         1rIzhfYEopoaeaGPIkDAkboEmpBd4Tsvqozy5jzBoP8H75FpzVd1hL9WTajPbbTqrQGe
         F1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780384822; x=1780989622;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvADwMamOgSgMnsZzgfxJFHbU/mitHRiQMKS8+1jQKo=;
        b=WSrnHQaVuu4NLKGrOc5wVLaYrHBFgghiwLFaQQ9yIN1dShXIRJEAguH3/HVzHqeQBg
         2WPI4IdkQgKpaGBSmxQ0rEp7MKfHyWFqrckOatu/Dqdmt4qlT46desrZG0LUmc+AL/+3
         +RbKG2azYbTfJQSl+ug8dMX5dhFOYpjjXrSEs1y4P6tVJkvWavje08nItuvURVUzmp1h
         ZGKKJ0Hr0rPxLo+G5QQBJt7Vd6uOfZVK/LjUjgk675eTIFZGQ9jxLO0Mek//V5mL1RHy
         n4SrnCGwwgDKOCFxeiEliyIeQo81G7dQRkQlKk9biq/YcqUH/qPnEzZzWlf0fiEt7nZn
         IkAw==
X-Forwarded-Encrypted: i=1; AFNElJ+YLA12Np/MfxqeunAeCHzOE4Ia32K3P2gJxZBeGF5PVnqsgVJWihlsmMfej48NltSxX1QPnMSW@vger.kernel.org
X-Gm-Message-State: AOJu0YzDL5lxNQgM0tjWjWzNy2UpxO2yqAmglFA3rhvBpsd8hHF6ePzS
	zwiQMFEkPJuX9yhb35jXt70HOSrB7AQj/zlqAHJUrAxbhFh8TyAzJOIap54mvvZOrsshPy4zGU9
	z/L/nvwIRGKvUJXEaMfYaEwZ+Uw==
X-Received: from pjtf7.prod.google.com ([2002:a17:90a:c287:b0:36b:8553:3c3a])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d603:b0:36b:9835:cf96 with SMTP id 98e67ed59e1d1-36c4ff249bcmr13601837a91.2.1780384821909;
 Tue, 02 Jun 2026 00:20:21 -0700 (PDT)
Date: Tue,  2 Jun 2026 07:19:11 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602071911.3652151-1-joannechien@google.com>
Subject: [PATCH v1] generic/63{4,5}: Modify criteria for passing test
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: djwong@kernel.org, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

The two tests pass when a timestamp is not preserved after the remount,
because "cmp -s" does not print to the output file, and status is set to
0 regardless of the return value of cmp. So, use "diff" instead to
correctly fail the test and flag the error case in the output file.

Also, as the tests are focused on timestamps, don't print file contents
so the tests can still pass if only the file contents differ.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/generic/634 | 4 ++--
 tests/generic/635 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/634 b/tests/generic/634
index 8a4210a3..d7dd9dd8 100755
--- a/tests/generic/634
+++ b/tests/generic/634
@@ -52,7 +52,7 @@ touchme() {
 report() {
 	local files=($SCRATCH_MNT/t_*)
 	for file in "${files[@]}"; do
-		echo "${file}: $(cat "${file}")"
+		echo "${file}:"
 		TZ=UTC stat -c '%y %Y %n' "${file}"
 		test $test_statx -gt 0 && \
 			$XFS_IO_PROG -c 'statx -r' "${file}" | grep 'stat.mtime'
@@ -98,7 +98,7 @@ report > $tmp.after_remount
 cat $tmp.after_remount >> $seqres.full
 
 # Did they match?
-cmp -s $tmp.before_remount $tmp.after_remount
+diff $tmp.before_remount $tmp.after_remount
 
 # success, all done
 echo Silence is golden.
diff --git a/tests/generic/635 b/tests/generic/635
index 018b868c..f74d0cd7 100755
--- a/tests/generic/635
+++ b/tests/generic/635
@@ -55,7 +55,7 @@ touchme() {
 report() {
 	local files=($SCRATCH_MNT/t_*)
 	for file in "${files[@]}"; do
-		echo "${file}: $(cat "${file}")"
+		echo "${file}:"
 		TZ=UTC stat -c '%y %Y %n' "${file}"
 		test $test_statx -gt 0 && \
 			$XFS_IO_PROG -c 'statx -r' "${file}" | grep 'stat.mtime'
@@ -102,7 +102,7 @@ report > $tmp.after_crash
 cat $tmp.after_crash >> $seqres.full
 
 # Did they match?
-cmp -s $tmp.before_crash $tmp.after_crash
+diff $tmp.before_crash $tmp.after_crash
 
 # success, all done
 status=0
-- 
2.54.0.929.g9b7fa37559-goog

