Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7C3E3140
	for <fstests@vger.kernel.org>; Wed,  5 Aug 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914327; cv=none; b=HIbMMKzVlRaxNc/m9e9aKa+3qudKDLue/XVGQ1VipMXx/lf1ABdt+B/COx1HdaqBn6qMldTDwOVdHRPLn3IWHJV2Locc+v5KGSO4/WIn31qSD3MAcjBWVJlxLou+YgnWT15eL+Kv2q3NjSZnf6LJdZqtV2ilzOHjbYVUo+hJSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914327; c=relaxed/simple;
	bh=eLqAyWz6JPIFIjARNrjsEhSQtXbJmfxt1w+sEn83zX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeLPQFQNooN/DwLigJ9w+ybT1JjV+HC9rp3eMcZpsUTXEHecjZA080wKZoqGL7RiOWkuk/icRJoejhn9/J+rTWTSLAk8YLzuEU3G1Vekg3+9R0srWhFiWTZ6dh/SayhisrEFs0vmeH+Fydgq1Q5chhZklgiT9eMdTjFpeOu1trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djCXVZNW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djCXVZNW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so565707a91.0
        for <fstests@vger.kernel.org>; Wed, 05 Aug 2026 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914325; x=1786519125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FmsOCHl2gua2OpwISUzmmcA2ZNJ6H6s62NtJp3dFLu8=;
        b=djCXVZNW0bFH8Bh0PhqOI0WqJ5Dwi35Fbe31JHQ/7gjlSJqYryR3OC3Uj68qRCQFGQ
         DXLVi0ZSq81u4yPP2VCX773SMnb5gMd93nuyhocfBsKAcioPLVaQdz5JY9Qt/1UIHf+Q
         ElvmfTRHOLihI1T2bar0tgYl+f/03gu4AaK3xRi/r2PHIyx/ZR77NbVBrA4kfZ7kk6Th
         wwlkWVmR0JC2uYRYWxR/roXsWhhjE52YpgNrMVb5MB8rBVk17I0Zc89EyvvnkCEd2ecd
         8PlnOCrrUCM5AUe8mLRgY0/T+ryNnLpDQrBsaZ3FjOfWIID9G1effwoGsxIku6YNia92
         KPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914325; x=1786519125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FmsOCHl2gua2OpwISUzmmcA2ZNJ6H6s62NtJp3dFLu8=;
        b=bQgecnPZgVjdcOEH6GPOKWA7HEt1oCDIu/iyJLXrfSX8xS50zNzuaM+ksB0gApRi7I
         QzyGMnjSRKDETVHormqHfRZ3ML693U36+qPxT3yaty0ULwW6w5V4w6T07ZhTYKUgRXQW
         3/VUMmIHklAJPclKbTDVv8PVzsa+Mc24EZcSOQUOQP7wVFF+fUHe0XiqgMmCSS0N60t4
         M3rIpaHzZePzeRBdwOymrN1Xej9kZx/nmRm/T8TXdy+x5ezVro01tO5+J5KwEHqEXaSu
         MQMwlsDhqsLBpy7Y6a1UEyp8daIhteZlgaJbb2UdWDNINktClgY4SQ0QhbNRGNoA49JT
         UjpA==
X-Gm-Message-State: AOJu0YzcQmS+sVtgFeYUHo6AmyftouRH4h1Fb5FfEr+8ShN8rlrhduA1
	hIpfXD5QYBVcIScy0Sca9RR5s1Jf8+axa87JwsoDgdiaDuJByvWmOuH7iDHuw6GL
X-Gm-Gg: AR+sD11p4L548QvHYAVPCBkD9jTPrLmd6NCM+X1TtZ9pvZLRJi+YIP5HbFxa1CY2gXk
	VM58xqVOJyRsUPUKv1FpA0wkiIPskCiEJqCIw0HMPGvElelwRb//9YuBS4WiPSxuE0jZ8uFjUJJ
	5B+UCUHTw72Ggg1McgaH0eS20dD4bj/HB1Rlc1J1BPiI9yyqJ6AUf4cvaVDMFx5x+mBLrdUnVBW
	4VFC1OE+WQhuQJxUkh0KKBaMBvttnjd40W+FhZbegjhGtBZZ4EMSXo9Hl2+HYL2kzO9OPJui9lp
	i5iAx28+LCMww0lUhk4OelT2Fo56WKMj7F1Fz9REHpJjNKbbjjJmgUnzF/E+ar1qPJ44oxnTdql
	XJ6oVhX74F6zfGt0DgAmr/4C1gDr3vJqP/tw3i7zuEkzoOufvY+BHFjsMFw/lQcoiw9QlU9ysr9
	FIkisXgWzoA937ic6nNSPJD+/bAlp6t2TTd90A2kND6thyNaRPZWQ9PvpxZc5ABxQJKTIYq9XNw
	Jtq8gwHvX1yNhRTjxcOu8C62gXKwNcMp8xosw9ehXGebr9fzlijJAUKoA4pbYtBtJUioiG6fzIE
	p5R5U6Sxj85PGvshb+VK1iypfkPa79aMU9gfw2skE75pTtizZo6K
X-Received: by 2002:a17:90b:3a8e:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3903c581fecmr1849198a91.5.1785914324859;
        Wed, 05 Aug 2026 00:18:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fedc650a0sm3638742a91.14.2026.08.05.00.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:18:44 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: fstests@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Zorro Lang <zlang@kernel.org>
Subject: [PATCH 1/2] generic/517: expect truthful dedupe progress
Date: Wed,  5 Aug 2026 15:18:38 +0800
Message-ID: <20260805071839.3423779-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805071839.3423779-1-matthias.goergens@gmail.com>
References: <20260805071839.3423779-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VFS currently reports the requested FIDEDUPERANGE length even when it
shortens the operation to avoid sharing a partial EOF block into the middle
of the destination.  Once the kernel reports its actual progress, the first
dedupe in this test reports 131072 of 131172 bytes.  xfs_io then retries the
100-byte remainder, which cannot make progress and returns -EINVAL.  The
separate 100-byte request returns the same error.

Update the golden output for those truthful results.  This is the output
change that caused commit 4a57a8400075 ("vf/remap: return the amount of
bytes actually deduplicated") to be reverted.  The paired kernel series that
determines the new output is linked from the cover letter.

The updated test passes on btrfs and XFS with the paired kernel changes.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 tests/generic/517     | 6 ++++++
 tests/generic/517.out | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/generic/517 b/tests/generic/517
index 3f7027a8..ab5d17e7 100755
--- a/tests/generic/517
+++ b/tests/generic/517
@@ -11,6 +11,12 @@
 . ./common/preamble
 _begin_fstest auto quick dedupe clone
 
+# The dedupe amounts this test records are only correct once the kernel
+# reports the number of bytes it actually deduplicated rather than the number
+# requested. Both dedupe calls below target a range that does not reach the
+# destination's EOF, so generic_remap_check_len() shortens them under
+# REMAP_FILE_CAN_SHORTEN.
+
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/generic/517.out b/tests/generic/517.out
index b9b63207..6ba753d8 100644
--- a/tests/generic/517.out
+++ b/tests/generic/517.out
@@ -13,7 +13,8 @@ File content before first deduplication:
 *
 0786528 ae ae ae ae
 0786532
-deduped 131172/131172 bytes at offset 65536
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
+deduped 131072/131172 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File content after first deduplication and before unmounting:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
@@ -33,8 +34,7 @@ File content after first unmount:
 0786532
 wrote 100/100 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-deduped 100/100 bytes at offset 655360
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 File content after second deduplication:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 *
-- 
2.55.0

