Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB3286D50
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206442; cv=none; b=hPaxr0YV9Pjyke/cswBR9QgRzWuNhJCwjcLjkPOIGw2LkMa8hPtDoIlWXUy5nEaNNqplCe5A6LpMrHbMjy0eM8gwlI5qtMLWhvYfK+2isj3D9uX/O4DS0yb0jchSMrQnFajm52607YljKbZH9tIZVb1p+/hTRyoXD1QVO/UrsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206442; c=relaxed/simple;
	bh=w4lpI8a9gyg5bw4dRD7mihnaAQ42K+mPkzb85u5CoV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlxslY4OZIuA4nU/P1mxJld+3lxVeO2DKQM6jPDZ1KHZKbwF/soIaCoWCLSAQdCb0zGD/uZTn2DqzHVD9XoYCEHb/kDSmW9vgZY0dgHxKL4IwWlT1GzHoiF/Qs4AXuQtyJecfO+R/PomWrs0VTygmmYJn26a/+d4HJ7ZZwp5f0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=KVjQuc/y; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="KVjQuc/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1749206440; x=1780742440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dVg/D45T+/fE8MrE/Gw158OWu2Ky9dIdzWdlyMm3H1M=;
  b=KVjQuc/y8sImBa45rZD/yfB1GE2ubWmLhSFsbKyLh2h3cKVGv/BqxjJr
   DxZ1K3fKv6H1grYnI6+HHqezmYfa5HsZQQS/ibE6C+QwGgawQNRVHVtpH
   aVonNgTy5kbQ88L+Iw4mWrXwtopO1IpVTAuJzmJR1QJ9Gsxksfe87cV0a
   BFCwrntyTxSYdhqI8UVxxHkxO//JvAcPkzAo6EicTbQHyRmtJfHbNrUGU
   MXpJAGHLQwck9M0FEiZv670rRaKkmPsq5XwwjVFe1SO19MkPYcb8j17lC
   fauj+jv3RM14JtIXGQU+IJjBcOZ9/zztCNyD+ZkRMY7yNFCq+6Bf0S+26
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 19:30:31 +0900
X-IronPort-AV: E=Sophos;i="6.16,214,1744038000"; 
   d="scan'208";a="538750734"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 06 Jun 2025 19:30:30 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1] generic/622: fix for exfat
Date: Fri,  6 Jun 2025 18:28:55 +0800
Message-ID: <20250606102854.3348648-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit(f761fcdd289d exfat: Implement sops->shutdown and
ioctl), shutdown is supported by exfat, this test can be run, but
fails because exfat has a 2 second granularity for access_time
and no timestamps for metadata changes.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 tests/generic/622 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/generic/622 b/tests/generic/622
index 0c744fde..a67931ad 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -116,6 +116,9 @@ do_test()
 
 	echo -e "\n# Testing that lazytime $timestamp_type update is persisted by $persist_method"
 
+	# exfat does not support last metadata change timestamp
+	[ "${FSTYP}" == "exfat" -a "${timestamp_type}" == "ctime" ] && return 0
+
 	# Mount the filesystem with lazytime.  If atime is being tested, then
 	# also use strictatime, since otherwise the filesystem may default to
 	# relatime and not do the atime updates.
@@ -128,6 +131,10 @@ do_test()
 	# Update the specified timestamp on the file.
 	local orig_time=$(get_timestamp $timestamp_type)
 	sleep 0.1
+
+	# exfat's timestamp for access_time has double seconds granularity
+	[ "${FSTYP}" == "exfat" -a "${timestamp_type}" == "atime" ] && sleep 2
+
 	case $timestamp_type in
 	atime)
 		# Read from the file to update its atime.
-- 
2.25.1

