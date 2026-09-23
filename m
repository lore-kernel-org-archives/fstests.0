Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACF435EFA
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155997; cv=none; b=LpmsHEmdDD3GRi34psuj9d0THEPT3Q1JNYlshhX9ZPh62oatLeqREoqQ5//33sW9XqOy3NM2HyEp9s8szdBmQH9ZobTAuaPYhLoZwFuoIImq8mgqh3Elptgz2DJkZE2tzVL0OZdPRdibn2oOPTCi+gt+hrEGc6gKcQOfCqlsB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155997; c=relaxed/simple;
	bh=dMIZP73HYlWSEcpkrzNHY5rT+sUIhPceCaA+kyDkmTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvZ1zSCXUE+oIDIrKKAQLIKW3ksSasV2yFiTJnVGZhHlLoI1GEikFDCvWUpm3Ytctxp4Ap4ACXoiF49cGFYdjjkSc7pFGkHx1GZCifl5/8kSKntRIuGtiZ3QiE+x5et1GHyPhIrX5UrOdJYgNgDiCfrlgsAyL9yd4kOrSazBPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDLYUC9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDLYUC9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEEF1F000FF;
	Wed, 23 Sep 2026 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155996;
	bh=t2iLZRhzD7braCleapaVgGSsstk0kViRLxegoKE/m7o=;
	h=From:To:Cc:Subject:Date;
	b=YDLYUC9x5qFtc7fuAj63DGlogLyx6nfBKDXGlk7dQxY3jGfc4d5QWfLPH5kQ9rOsz
	 0MshddI1BlmWyFAoJqzhNa4MJBLgwCQw/xDRCjyWfMsm+6RUEr34QpLPMyp/8dLE3h
	 ac9eu5FCqZ/8+UKzhLf9FUsc6T94gMVITQ+Q6sdIsAsq7chWzBu3O7dVO6F0mut8rK
	 VlAEE+tvix3KgLlnUpazHqj6XOfD7pMWEuwIkuLhZagWwM7BIMvkcdABv+4OeH+05f
	 sMMbT8kWYT/rUn3zVaf9qYoIt7tW2qJNjloWhWAi7laex8V2oXHDiqT+WactbqNzEl
	 GU7bVwuQ8vByw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v2 0/4] xfstests: random fixes
Date: Wed, 23 Sep 2026 11:32:51 +0200
Message-ID: <20260923093259.16199-1-aalbersh@kernel.org>
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

Changes from v1:
- Add RvB
- Add comment in generic/452

Andrey Albershteyn (4):
  xfs/071: use _link_out_link instead of opencoding file picking
  common: link .out file to the output directory
  generic/452: make coping work with multi-call binary
  xfstests: fix permissions on system file installed by libtoolize

 Makefile                                  |  3 +++
 check                                     | 12 ++++++++----
 common/rc                                 |  4 ++--
 tests/generic/452                         |  7 +++++--
 tests/generic/452.out                     |  4 ++--
 tests/xfs/071                             |  7 +++----
 tests/xfs/071.cfg                         |  1 +
 tests/xfs/{071.out.64 => 071.out.default} |  0
 8 files changed, 24 insertions(+), 14 deletions(-)
 create mode 100644 tests/xfs/071.cfg
 rename tests/xfs/{071.out.64 => 071.out.default} (100%)

-- 
2.54.0

