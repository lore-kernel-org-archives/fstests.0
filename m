Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDEB341BA
	for <fstests@vger.kernel.org>; Mon, 20 Nov 2023 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvWfvxv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6177C433C8;
	Mon, 20 Nov 2023 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700508920;
	bh=Oyk70GbW6Tj0CE5UHvYe7fszuQmextVmqY/WFoNDt6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JvWfvxv2PzsaviUjgyubDrOxzn82b/2DPAi0eG30NMDQ7J7IcaehUsJB8KomxImlY
	 qFgADVt+mZ+ajnOZfxlmoYPH1D/PlC/AaU5EmNlRfPTVXua/ugr/PQ5L3fIgi+0UxN
	 Bpmj06BNevsRIsVgk6jofA4Siin/5NVeCKnMIBig683VU8Ixv/502CCEvhwjtaRPWx
	 8AR4hXw0dd9WgTLo/8FtQLE2UR1si/3JLCjAFqzI5lIKnZGOSg04U11sjUxZQYiSdO
	 +hTovDlSMx7ye8nojwgp7TT3Y020KB6dkNTTY8Nf5Ut6Lof2gzlsg4kd8nPLQnJlvO
	 52mNAcHUJbH+Q==
Subject: [PATCH 2/2] xfs/604: add missing falloc test
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: linux-xfs@vger.kernel.org, guan@eryu.me, fstests@vger.kernel.org
Date: Mon, 20 Nov 2023 11:35:20 -0800
Message-ID: <170050892015.536459.5750821914760062267.stgit@frogsfrogsfrogs>
In-Reply-To: <170050890870.536459.4420904342934916414.stgit@frogsfrogsfrogs>
References: <170050890870.536459.4420904342934916414.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This test requires both the xfs_io falloc and fpunch commands to run.
falloc isn't supported on alwayscow=1 mounts, which means this test
fails there.

While we're at it, update the commit id since the fix was committed to
6.7-rc2.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/604 |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/tests/xfs/604 b/tests/xfs/604
index 50cdebcd50..bb6db797e5 100755
--- a/tests/xfs/604
+++ b/tests/xfs/604
@@ -13,9 +13,10 @@ _begin_fstest auto prealloc punch
 
 _supported_fs xfs
 _require_scratch
+_require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_test_program punch-alternating
-_fixed_by_kernel_commit XXXXXXXXXXXX "xfs: fix internal error from AGFL exhaustion"
+_fixed_by_kernel_commit f63a5b3769ad "xfs: fix internal error from AGFL exhaustion"
 
 # Disable the rmapbt so we only need to worry about splitting the bnobt and
 # cntbt at the same time.

