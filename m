Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439040F74C
	for <fstests@vger.kernel.org>; Mon,  3 Aug 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761172; cv=none; b=N6hA3Z6e8OVo5FeVTTNgJeHrbNAc2lnO0UcwYBvEzyTzTdGI6DV8gZisMj/VU8KP73IlrRerTDyZZxuRxI1AU3378cEC+cBb/wkrevbPVcqc25G8bCVtQRypODQE6hokCYC62D2GqSWWWXv2UStZpD8TnS7CIoc4VoX9C8PA1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761172; c=relaxed/simple;
	bh=+5HfwxnoU7G89Vk4LVxvFgzEKrjEF9YRnVrCIJMG4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeI84FVkmFCrv3tnAWFBwkDb5jS72nKs10fFlXy5FaU19Pf/UqmnzggnheKHX/zvRhAjvTC9q3llfDvX5lY2VrDoYY0XhLloa/VV9BuEMUytzYlFdxM2/sEku6qhnEZUm2AJ8Z4Wm/khUyBdf4UrqxqynARY/23XVxkNe8uNLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=iAzQub5G; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="iAzQub5G"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1785761166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m9x9OZeqKA43VmdzLgAjofy3Ft+7/yhL4+yJje3kXHE=;
	b=iAzQub5G2tPSlz/hYgJetMLzBsms8z7br6hnGToeZTTRkePWXz3VNoCOJWseaf37y780MM
	z38NQrsN3iKYgmGOE2aGsrQCbO7+SGT8S0YsBAv4GOxRtRkXBN3KN68ErO/zenJey6vvg7
	vHQuyLuyT0YL49stUCT9OijhoRXGyFCCe7z8hnRonMHUVUgi7MW5/D3PL9AJ5IQRjzIfWV
	bMb476fC4/hv1ym3moznvUw8GaW9LtlD45s3eibGFjDvRxjxrPET1UDsbz9VobgqFyA2LH
	X6ow7WkGcrylFnBHVVljFC+RWFGDEAY3OTqUS6MDBFCv1wu8FxTB4EKL8/Aipw==
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	hch@lst.de,
	zlang@kernel.org
Cc: linux-cifs@vger.kernel.org,
	fstests@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH xfstests v4 resend 0/2] generic: new test to check nlink returned by fstat()
Date: Mon,  3 Aug 2026 12:45:21 +0000
Message-ID: <20260803124523.238457-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Resend it to fstests@vger.kernel.org.

Christoph's review:
  - https://lore.kernel.org/linux-cifs/amgkQi1o99dX9meD@infradead.org/

Zorro's reviews:
  - https://lore.kernel.org/linux-cifs/anBwHPuds0VQjHuu@zlang-mailbox/
  - https://lore.kernel.org/linux-cifs/anBvmrwo6SvhVFuu@zlang-mailbox/

v4 on smb mailing list: https://lore.kernel.org/linux-cifs/20260730021238.51634-1-chenxiaosong@chenxiaosong.com/

ChenXiaoSong (2):
  generic/002: add test to hardlink group
  generic: new test to check nlink returned by fstat()

 tests/generic/002     |  2 +-
 tests/generic/798     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/798.out |  2 ++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/798
 create mode 100644 tests/generic/798.out

-- 
2.43.0

