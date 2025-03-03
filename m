Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3F1DA60F
	for <fstests@vger.kernel.org>; Mon,  3 Mar 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984140; cv=none; b=YrE5vp5S9QloOA8ntYuTU5b1sM3wmfCGr0oGikxW5WzEotMNxrbWtBFAlYGuaaSvPM5FuzP7Frpi0gwfp6G8kNy02dvJP2cPlQc/kQK/YE90IjrRxKt5U5mgWBUAFlMrrraagT+GI7rd8ER6Hu5IdnUxCM5Ed4lK7nESJ6AFpMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984140; c=relaxed/simple;
	bh=XuEDVhgi9fcTFUnP24W+RY6NXqVnd+s7gAunntPSzi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VG0mWl2RgVAU7UfRHDyj8YlVuYeqQkZ6APNQS+X/+Bpvonp5A4qdOFwnriDsZmLZvXcZTKY32wlEb8WzMGJ4uR0wYQp6WISJG5atJGNEMxkL/sXd08kaa4npA2JpWj/2wZmR0caZjncmemmq4hKg5t27x3pnJbP0ovhYMkDpk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=igZ8IDG3; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="igZ8IDG3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740984139; x=1772520139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XuEDVhgi9fcTFUnP24W+RY6NXqVnd+s7gAunntPSzi0=;
  b=igZ8IDG3D8pGEazY8QesVtkiOAxW/ZvvCoLCHrGjKKXnS9pOSzF+JUU9
   Qrsvv0Q8toEEUN7fHvNAGMnIDjITV8wY9UE0N/L+DhFpTEKmxdMrUoBMO
   QOu7FEiXFqJl+kHdtNtKZRVkQsBUoOXHE5lA1Y9Ybh2xW0mTn0ij2eVJf
   0vLAg0xZ3TKIbtZhZu4vmVDH9OwHRaiZpGzm8YIlHYYhCwfgn9HvmSSh0
   4htbuscLVo0KfqcGbd6UqGy7HX2nVNIWVOHktzFV8QUVwBiwX9E2QY35q
   F6IDdg2pfCoDQ9aktzMm9pdFST4uPQ3VS8dfPKVR7ECjwFAngK+me/CxV
   Q==;
X-CSE-ConnectionGUID: TCfdiHAjS0yBWwtieX6T+g==
X-CSE-MsgGUID: U6KTQrwYQ8uRgDOcRje0kg==
X-IronPort-AV: E=Sophos;i="6.13,329,1732550400"; 
   d="scan'208";a="39754632"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2025 14:42:18 +0800
IronPort-SDR: 67c54180_fzO33gWFhHIIYWYS2dyNI6Qjmfskjc9vj6zc5VLRVMvxXhK
 yCGc50Q2DRJ1GZqJH6PY1u5B4HlEPKUHvIv1ttg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2025 21:43:28 -0800
WDCIronportException: Internal
Received: from 5cg2021mh7.ad.shared (HELO naota-xeon..) ([10.224.109.170])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2025 22:42:18 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: fstests@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] tools/run_privatens: check if it is mount point for --make-private
Date: Mon,  3 Mar 2025 15:42:09 +0900
Message-ID: <20250303064209.602577-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While /tmp is mounted with tmpfs in the most setup, it still can be a non-mount
point. For example, I'm running the fstests in a container, which does not
mount /tmp inside the container.

Running any test case on such system results in having the following error
printed, which leads to all the test cases fail due to the output difference.

  mount: /tmp: not mount point or bad option.
         dmesg(1) may have more information after failed mount system call.

These lines are printed by the "mount --make-private" command. So, fix that by
using mountpoint command to check if the directory is a mount point or not.

Fixes: 247ab01fa227 ("check: run tests in a private pid/mount namespace")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tools/run_privatens | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/run_privatens b/tools/run_privatens
index df94974ab30c..c52e0128b8f9 100755
--- a/tools/run_privatens
+++ b/tools/run_privatens
@@ -8,7 +8,7 @@
 
 if [ -n "${FSTESTS_ISOL}" ]; then
 	for path in /proc /tmp; do
-		mount --make-private "$path"
+		mountpoint "$path" >/dev/null && mount --make-private "$path"
 	done
 	mount -t proc proc /proc
 	mount -t tmpfs tmpfs /tmp
-- 
2.48.1

