Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53772393DDC
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263404; cv=none; b=XDRzOHcBmKLZuueTTQSvBAb+6A5fISVczx0anv5yG+na7l4Ba/G/meqiBLdFHdtbTgglr4tuhYNzmOXHPpFEEBqsn6vBj84JZ21QxYMMRE9rvjRetf/MCvJJBIsKsAXvPys6f6A7ewqWLL5DvJ5w1+5ddnvDISRnzKWjQYr4Kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263404; c=relaxed/simple;
	bh=UXsKMvscZq3AsGWBkAA0J6AqsKjRbSTgU1A+MkSCZho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AmbYSG3OjJHqjpzcySO8iHMWNm98HUrC1U6V3Q/DigMHCqQzIWja6vO5oRAao5duyNWMjo51oi4IUGAu3U5Mrz2wjkM5nRBHxlt+Lm2FDdX+/pneaUMayjOipO106317IwfTcjmfoWp0ikI2vBq5qs/mHUcDmBh4FjL5+1z8thI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWO1+Bad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWO1+Bad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C691F000E9
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779263403;
	bh=oxRSS82D4MZz5uChPJJD85nz+IxtLyPLTpJxf2mMafY=;
	h=From:To:Subject:Date;
	b=dWO1+BadkQOxc5FHV5HhntdhrFP8+Vw9HwwuMlGMHJ2jLv0NxanSIZ1yF6/hw70uX
	 VghhBt4g6CEOrAPGNc7EN+MlfHiGkYwAn55hWwLvloRfL3BOjBSZV+eFDWj0a5vXal
	 PhoC4bmQieXwvkxNh1JWFYsVCgw/3gpyZddctheFNuCLdAFnWVjZpP9mFcav6mCC4y
	 w9c2lRCbSi5ZLo7PvfXxSvYCGfG0c61+w6L80QSef3ECyfFmjfmn7yWFDnPCZbUb+I
	 c5J3Qz83UgB1hYYROepFLMAOfIF3QV1kHyQit73yp7HCPIz9vnTIK/cZGYPt588yvl
	 b9Tf1lX5QjrFQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH 0/2] align the "# FS QA Test" format
Date: Wed, 20 May 2026 15:49:50 +0800
Message-ID: <20260520074954.1877984-1-zlang@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent of this patchset is straightforward, to reduce maintenance
overhead by unifying the format of the '# FS QA Test' line. This also
standardizes the output format of related maintenance tools.

Please feel free to tell me, if you have any concern or suggestion.

Zorro Lang (2):
  tools/mvtest: align the output format between new and mvtest
  tests: unify "FS QA Test" comment format
