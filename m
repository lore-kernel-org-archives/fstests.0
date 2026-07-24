Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD32286D5E
	for <fstests@vger.kernel.org>; Fri, 24 Jul 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862757; cv=none; b=ko1roIrKfGnBBb8uHCwiQLMh6CEyf7KYrQCEYOmGz3d6RjRUutyMMRhpNj1Mhamepb7SETIADWk+xQ/xX6+j6vzsT2HFhjUqmgd0NiT0zwo2pmVIizfo5dT5RpsnVs6a/WY5MEKb+3oJIuJ6QsNbgYozelCuF0U3sQ0GuRm9DxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862757; c=relaxed/simple;
	bh=kT8fXw48GA90xYFzXC6PVtJSsjx1Ljxdu/pcwjMrORE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGg+7q5qOgRwKX3Y1PXM/smqmBSbCjD0LLjTLr74c67OB2VaO7lXwdW2bUuY0UldTyyFETyw54dbZhP0+39z2O02CBh8WkDl/P1r47hKCA7DKeLTe7TOMXrcKaFue7Dl0yGtHbj3c4iH00otbguCnXYTY2xYAxkgW2PWn9iMQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=iF27km2e; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="iF27km2e"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1784862750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zV7EcMguRzNIbr6K1is2ZOzospwqJItfpqXu67VyszI=;
	b=iF27km2eavhAGPLodyOD6pFEE0hDC1dvXzIRvAsqSm7bTJoekfZ1pwVxH85uqWdwBXcMwQ
	YFh7CdbhV4mHGopVR5JMnXFLqDU4UjtA3tmh2JW2PLAbid1J3FT+Yhp2GrZ7L/+IEdmO35
	fV1iNcMneL05T3xLPNOnYckMkp1Ww87lrAup6B4PaSYkdpHlBhYAycvBQFSqyDYCciN9n2
	Uwv9TXW7QswdYsAMzKufx3oRjE51fWVxe1qvel3CvuA/y929u5ibk3V37fdokhWiDnZ/Mx
	KLuagWtwsTKKHevsAEAsqZ6cXULLz3PArIhqm6hjtFpbGqFoOYatRkfHpLdCvw==
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	senozhatsky@chromium.org,
	dhowells@redhat.com,
	metze@samba.org,
	zlang@kernel.org
Cc: linux-cifs@vger.kernel.org,
	fstests@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v3 xfstests 0/2] generic: new test to check nlink returned by fstat()
Date: Fri, 24 Jul 2026 03:12:08 +0000
Message-ID: <20260724031210.332153-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

v2->v3: use `xfs_io -c 'stat -r'` to call fstat().

v2: https://lore.kernel.org/linux-cifs/20260720163502.732454-1-chenxiaosong@chenxiaosong.com/

ChenXiaoSong (2):
  generic/002: simplify the hardlink count test
  generic: new test to check nlink returned by fstat()

 tests/generic/002     | 16 +++++-------
 tests/generic/002.out |  2 +-
 tests/generic/798     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/798.out |  2 ++
 4 files changed, 69 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/798
 create mode 100644 tests/generic/798.out

-- 
2.43.0

