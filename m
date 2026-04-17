Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801C34E774
	for <fstests@vger.kernel.org>; Fri, 17 Apr 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443008; cv=none; b=lhzOS4NOt444H/Q3LiGl/npBOQF4UeVpis8PKm9PM8vGmIvecB1di6l1Fk0tfLY21lEapu/Kdr+ANmZj5L58cpa9yhCZshwTcaAXewimB8Hetl58JP7KRc32/uopsdFub+0F+KbtVLyRyibxbSoTWJvY6oSD52i5ZXRicUen3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443008; c=relaxed/simple;
	bh=hDwixIjPMrXutYWe45Gt3PbjhV3UZPUzWLQVTRhVutc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiiaXBdfU5aRnhMAnFIwkjhyqyhJkfI5N7g1we1GyHZoLp083DxYRox6AspcY6y7Hf+RjwvhK3SpOd8Wj14XDqPBWac811mp1TqXchf9tqRljeTjg6NA9caCQJueBvn07VLz37+5gbHW9HYRhV75nR8WJk/9zFiX+t2s9JdDy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceM9T/Sz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceM9T/Sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D320AC19425;
	Fri, 17 Apr 2026 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776443008;
	bh=hDwixIjPMrXutYWe45Gt3PbjhV3UZPUzWLQVTRhVutc=;
	h=From:To:Cc:Subject:Date:From;
	b=ceM9T/SzbHYzAhBZFSjXg4zgxe2+ImcJ6wK6fvY0o5VY1CPQDK5l5iSEY+uE8tez2
	 p2ep3Qar4DGvCu3gflW06M2YCkz5Ky05XjFes/hhZ9sCmN5QMUzv7VkXtXl3oH+Cky
	 FEYUwDddb9sMiFI37QMgkJA8jlPDv9zA/TSnrVKbvtVpApzAhyd92rb745AzaDQeNU
	 L0errY0XkOTwSD82Ihxj+N4AoNl8Mfs3kH5No90TfAzjHQm6YJai7YEcQN+wm+lE4I
	 /p6EM4DS9bpMgszt3VzOnwH1gVejWND6iAk4I0+7jiLDI+6piGJFhsQm8lCEctQkFR
	 p1ccITVokL6HA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH] xfs/653: require realtime
Date: Fri, 17 Apr 2026 18:22:43 +0200
Message-ID: <20260417162245.690716-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test fails to mount without CONFIG_XFS_RT.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/653 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/653 b/tests/xfs/653
index 12d606c436f0..bba59cc36626 100755
--- a/tests/xfs/653
+++ b/tests/xfs/653
@@ -24,6 +24,7 @@ _cleanup()
 
 _require_test
 _require_loop
+_require_realtime
 _require_xfs_io_command "truncate"
 
 fsbsize=4096
-- 
2.51.2

