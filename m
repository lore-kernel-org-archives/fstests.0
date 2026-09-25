Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771440EB91
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333125; cv=none; b=N3W51zfUP4pz2zxuptga8i9cfXV6de7EuLeE5w4AJYnJJlXhvewuNJVyrEn4s8mPXgq8NfBpaadS9WxL5qwRsRghUH0vWCsXMreGxIhy65GzhzbChkd17248H11Xc2X5pYSRnIutQxgnrQpTVHMruuQDW1yux97GZa12XCSme4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333125; c=relaxed/simple;
	bh=OHitdGo0IxPP2DTg/z+UzazGvaIY+1/OLY3V1N/gsKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7LXRynG06LthjiMQ/bD6cPipFNtmpUEyXKW0i//hjbDvtJChKcrN3P27zvq0TOl5Sa4IygP5Z8ndXob0k5Uh0ovD0VQK0mRdYOLl303Or5MvyDjOL7B8sYvL2THHCn62cCx/RrCNVAY7O95I4BkAwZDf2tXWKIkWswFR37bLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNvCAWf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNvCAWf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681F51F000FF;
	Fri, 25 Sep 2026 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333119;
	bh=LwlVnk654ma4HPtP0q4IZraLL0AB3Wxc5t80r1/xunY=;
	h=From:To:Cc:Subject:Date;
	b=QNvCAWf/WHAmtZDIHi8GXTcwYh4RL8DaVSa4qGzlPZBKXl+RzhYWsmASTUCTuHhBW
	 77FxY5gQtOEnmWYOZo0iP3/IWV2RhwDVzbl9ANxOcc1dJfvsmtPVzRfVn/bQ9i/0RE
	 Zig8//PVF3cgch0qWBaQJ6yI42hea41MdYQ2/RNejltuVQgV7x6FvF/SL2NEXZ+yZA
	 x/uOsNigRXgauvk0jTBpRGufGnI4mR8U8lWzkY+1SUvvW9iuAIT2NlbcCVTjN0HCN2
	 eNPCzLJf7jWs1dW4UawxOR+Gfb5C5JcCMJ7A1AUS8PwDqF14PR7Nn8RWb6qHUdmdxV
	 0tjV3NOkTyojQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v3 0/4] xfstests: random fixes
Date: Fri, 25 Sep 2026 12:45:08 +0200
Message-ID: <20260925104514.664260-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series contain a few random fixes I apply for xfstests in my
immutable test machines. These make it easier to work with read-only
xfstests package.

Changes from v2:
- Remove .out.good before running the test
- Fix "diff ..." message for tests with .out.good
Changes from v1:
- Add RvB
- Add comment in generic/452

Andrey Albershteyn (4):
  xfs/071: use _link_out_link instead of opencoding file picking
  common: link .out file to the output directory
  generic/452: make coping work with multi-call binary
  xfstests: fix permissions on system file installed by libtoolize

 Makefile                                  |  3 +++
 check                                     | 14 +++++++++-----
 common/rc                                 |  4 ++--
 tests/generic/452                         |  7 +++++--
 tests/generic/452.out                     |  4 ++--
 tests/xfs/071                             |  7 +++----
 tests/xfs/071.cfg                         |  1 +
 tests/xfs/{071.out.64 => 071.out.default} |  0
 8 files changed, 25 insertions(+), 15 deletions(-)
 create mode 100644 tests/xfs/071.cfg
 rename tests/xfs/{071.out.64 => 071.out.default} (100%)

-- 
2.54.0

