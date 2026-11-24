Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516596;
	b=huVsTeJu0oEHzogjspDqdkcsg2OdAtsORmDoR1eC5yO4OTklFEOdlPhcfwocsCg/yZrX
	 8we7Flox8dbdYOWFouiW7L6W6erUEZF8BPgjJG9L4ae1QDvTNb48EuyD1589Ab7mTjfgp
	 GP6EnJG7qAiPw4KmKaLlaE0N4ojDN83AZZZWa9nYPsnfB/LivbcQBYcrS1gIh6D9qJ2J0
	 FG1N82qU4s08+GagenN7oF2R7/rZ1WImddEGLpJ/a+3dvCGYESYpzkSGkew65NV4o+N4n
	 3FdWgzfoYdr0gyS3wzxKCce0/++1+Rw7RQB7LOvb7dlXeGnwzMJmjO/WBeg2FDW736w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5/jdjGDbH01qpM9CoSNKgxl9X95h2YCH0P3QprQbt5g=;
	b=ev+havnAtjSBW4EyMcPYraX+P30oL/NzT6Pn/iIVTGLh/FlUPXCqS51jK83iIqr840Ci
	 +1ziHguHECu8JyiE71BtJwCWhlAumMxjg0VNt+FrldPWnmmtVRhYeoCuu/UV7Dqvlg29N
	 /5PMEmmieKpl+7Xu6dRcpR+6zUaTt8aFPHkswskDFOlE2Qm52RglUsdmIixJHv2WJdB3F
	 xgaVpe2mI8nMZ7Gt02oPg6nrfP36Epz+s2mhC/gIBzrpRnz2R+BSUFphjQTbVtkrc4M7H
	 osm3WVNnQsIE8krLFSLfZlNcHWufjveh5YTvtU+MGDnB+M79RcooZ/LzAyqI+Z6QUiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgoDTXzm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF494606A31E
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgoDTXzm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EDE1F000C0;
	Tue, 24 Nov 2026 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795516596;
	bh=5/jdjGDbH01qpM9CoSNKgxl9X95h2YCH0P3QprQbt5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XgoDTXzmt4Cpjfk5mW5wxjTBXWsnqMLdwgvcMsRduBFT0ec4x5oZVcSM+phSxKhI4
	 ZUAYsFC1KNkJ7zHN1h9lE9PWiaJtkc77VDHH4EeN0mQEaNnF5nzS7Enl6FFjdl3OOv
	 wilnvVGOxG244Stqslu6NZXOwQMicgwhAm85FGlN68DLUYkksKhN+ZpMagLg5mlzhy
	 BEZ/DuVjKPSroMFhGtz8LtpRxh7bOvITslJjTqCo6Saf9d9+24Kd3ICAQdHAlYrF/1
	 kq5jNKBDqf0hsw1TQ78nWsYOEiibE+FBoCr7HI9X578JPEeUD6xb4uxFoNxWIOHIw6
	 ckx5ZHe9SIL7A==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: "Zorro Lang" <zlang@kernel.org>,
	"fstests" <fstests@vger.kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	preichl@redhat.com
Subject: [PATCH 2/2] xfs/349,xfs/556: both these tests require online repair in the kernel
Date: Tue, 24 Nov 2026 11:36:15 +0100
Message-ID: <20261124103617.4012647-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124103617.4012647-1-aalbersh@kernel.org>
References: <20261124103617.4012647-1-aalbersh@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both these tests run xfs_scrub without -n (scrub only, no repair),
therefore, scrub tries to repair found issues. However, without online
repair enabled in the kernel scrub exits with a message that online
repair is not supported, breaking the golden output.

In the xfs/556 case, online repair will not repair anything but just
prints a message that unrepairable issue found.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/349 | 1 +
 tests/xfs/556 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/xfs/349 b/tests/xfs/349
index a03ab812dc9e..0940ced42121 100755
--- a/tests/xfs/349
+++ b/tests/xfs/349
@@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
 
 _require_scratch
 _require_scrub
+_require_xfs_io_command "repair"	# online repair support
 _require_xfs_stress_scrub
 _require_populate_commands
 
diff --git a/tests/xfs/556 b/tests/xfs/556
index f5ad90c869ba..022a8e674a5a 100755
--- a/tests/xfs/556
+++ b/tests/xfs/556
@@ -26,6 +26,7 @@ _cleanup()
 _require_scratch
 _require_scratch_xfs_crc
 _require_scrub
+_require_xfs_io_command "repair"	# online repair support
 _require_dm_target error
 
 filter_scrub_errors() {
-- 
2.54.0

