Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F5256C61
	for <fstests@vger.kernel.org>; Mon, 10 Feb 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206639; cv=none; b=Uqp92X05eY8hXSrMCXiZ1uUdSvRjke2gbQJ6y1KKIvv4b0Vjkxxw9uz37r92CcKuBmslg8STuoAp+JjpNd4/710fNlVbTEfvg1n+lXBy5mg5LGaLWFQQEZnNBWdtkw/mJ3ikgwDuDQWIBGPALNQy0SdHmj2x5BjwYTUGOoAyQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206639; c=relaxed/simple;
	bh=lXbaBOdufZJ0HE/tKGfrN8YRq5gFBH9cHkveI7yygPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QijK04I7JxtiaAwjYWoz9whPXhPp3Isq2QRg451hjLMjG/ztxvRL1EX+NmXZMVhU68bkq9/TSZ5CLn7abMafHC+2C+i/Pq6Cv+sdr02B5O1ggV74sba4uLYfc4jn668tsOGytXnN2BlRWyUEixEkkNKnNGq7ZIdHdmXeFaWHZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVDi1KdM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVDi1KdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21240C4CED1
	for <fstests@vger.kernel.org>; Mon, 10 Feb 2025 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739206638;
	bh=lXbaBOdufZJ0HE/tKGfrN8YRq5gFBH9cHkveI7yygPc=;
	h=From:To:Subject:Date:From;
	b=iVDi1KdMus+tD43fGG06Ah6bwlWU4fP04fhqWu/ILrRl85lCK650hJ1m9h75cNU9+
	 LqMpwDC7FSTpu0OlOhHJqWogUfEEfc57oBEpoMeVPb2jXm60/JQ8J99gFVGHZcYb34
	 ks4AYGzXcUgL2rsKGsaey29mql3/pYY/w8clpWwkv2176ALBa0T0a5bq0U+g0zehkY
	 8fMLP7wgt/oDkvV+yXZGKU8+BIFhnhmENUw0tj3ui06uAojKsTNTU7JNOuKxN+UAmg
	 yoyBLfGwnSAiqqykZ0eSd3+4cL34D1uo+fVQ91aVZce3nSawrVpnd35NKF1LY68Aab
	 XoNvYbB90NhTQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH] fstests: use '-std=gnu11' to fix build errors with gcc-15
Date: Tue, 11 Feb 2025 00:57:15 +0800
Message-ID: <20250210165715.44659-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC-15 does a big change, it changes the default C compilation
language standard to -std=gnu23. That cause lots of "old style"
C codes hit building errors. On the other word, current xfstests
can't be used with GCC-15. So use a fixed language standard --
"-std=gnu11" (to match the kernel and xfsprogs).

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

The upcoming gcc-15 does lots of changes, a big change is using C23
by default:

  https://gcc.gnu.org/gcc-15/porting_to.html

xfstests has many old style C codes, they hard to be built with gcc-15.

Thanks,
Zorro

 include/builddefs.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/builddefs.in b/include/builddefs.in
index 7274cde8d..631e5d83f 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
 NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
 HAVE_FICLONE = @have_ficlone@
 
-GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
+GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu11 -Wall
 
 ifeq ($(PKG_PLATFORM),linux)
 PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
-- 
2.47.1

