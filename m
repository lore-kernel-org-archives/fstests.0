Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861127511C
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423747; cv=none; b=FbFT4KaZ/pUuxojxiJgjqDnGKLmbHOQfddio+uaELahpi4t4eOp5eji6TOdPv/FBxZIZwCtLRvrQaG7oth1gb1hgUjhHbenKkj6BrTqLIA5zWAJ7cG6RetXQWA0zfgsDoPwo8ziXOE0VAYPSFytPvT+jqbke+WUjFg7WmL6ud6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423747; c=relaxed/simple;
	bh=hAd3yFyKtcZE+2XCGa5XMh3GIq9PucWvYsfrXxOSZms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo/0xbE7Z/FfH6NM2ypB9wc1HsiY2P9UwxMQyAzEPf8Vqbk1aMmI5RQYQjyH2bRnnatlYTk3DImSu1EWdmA07b2APGD9azuXOxbmjoUXvJmr+eigVAS9jzH1+T4Y/4NA5zGbC9sISXi37JuqzNSyUJIy8IkPP64Z8FUCJR3iyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=xp9vladq; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="xp9vladq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423746; x=1779959746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSmThhyiChuSwTlEX0mBDN6K5/LWwCBeO1xVJZ8FaTg=;
  b=xp9vladqb9yBzfF60tM2yU3quGRpF1ZKJ9mTx8CHirNMiwTE5/89OW8v
   xijmKlfLiWVx3n7+jlzfxy01LXrHTpAk5rCOV6B0EpjPZAdLt8ntPqpUr
   9f/QdWtyeRLNevZCbpjw7xLeZX8yi/+gRta6LcaOuTGCLIcBxQSCJKeEw
   AXKrpV4GmMWi82JoLUOQ5gnJNzui0R1+WiCRCl9vqMAutbQvsZW0j4A5n
   K0g01FuQiggrC8oFy2XAdikWP/0ccBBfF25SVuCY7naXbl23o5LvI2u+7
   5UkDcMi/P2pt8ttGm2PTZOKdQ1Bx5ygzsKeFeG8jKcfF82RG15awNTZrn
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:33 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970978"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:32 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 4/7] generic/755: add _require_hardlinks
Date: Wed, 28 May 2025 17:15:27 +0800
Message-ID: <20250528091530.1218188-5-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is used to test whether the ctime of the original file
changes after deleting its hard link, which requires hardlink
support, so add _require_hardlinks to check for hardlink support.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/755 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/755 b/tests/generic/755
index a0c5abd4..b2fd3e58 100755
--- a/tests/generic/755
+++ b/tests/generic/755
@@ -10,6 +10,7 @@
 . ./common/preamble
 _begin_fstest auto quick
 
+_require_hardlinks
 _require_test
 [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 3bc2ac2f8f0b \
 	"btrfs: update target inode's ctime on unlink"
-- 
2.25.1

