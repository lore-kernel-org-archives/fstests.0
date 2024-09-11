Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1043BBC9
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026826; cv=none; b=rBrtDeK5nYsfwz4j+J07ni40nkQ8INcUxAfdS/725oDbfMA9GzSVe0qvMuGF4ZSGrBObNQF0UC7A9051cJQPATw2pXc7dqYkKCpRLVOuv0D5k4GvUtgoIA8JkCnACruOjzIEMn2WWbbvWVABmQ6lefIYzJ94lrwzbDcEf90a8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026826; c=relaxed/simple;
	bh=H5GLR/N93RwE31i0ZuGsPxm03Sw1+cydaYxWTAr0FqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jN76iHs9mOrcwK4YkcGQMEQbljc44DpNDnp6fgd+QK5Rv9+kXU695+I7FRnCjOIs2Mtoc9NF8zARYXFPdD3wPi7dZwlq6XnlupMm/n5YDnXXuJkiFiXelS7K/avMr4h+Vto5AqrbANwUH8ot9KCoX8bKXfElx5ZTHqJRjWlwca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHJpyhCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHJpyhCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9002AC4CEC5;
	Wed, 11 Sep 2024 03:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726026825;
	bh=H5GLR/N93RwE31i0ZuGsPxm03Sw1+cydaYxWTAr0FqA=;
	h=From:To:Cc:Subject:Date:From;
	b=kHJpyhCxWVy6mFuQyF8MOCdxXrcUBgvcUxBcCsgXp1X2uvbwzCCdEceLfOZOyvBXu
	 wm07ziDDLGXXlr5oF68kgwZ+q1KITtqNaHGfasbvOKy4FQ1bLgr1GDBxitcjvSZTnT
	 GYZf09y4yW+RYTbNs5nRoa/QB20kfKx9aYUnAXBQgEw2WwfIchEed9+WzgVniXxIyc
	 nOY8zijD085GRpWRUjRTSRY+7JfNUBg9Tko9I8f9l/TURr8R3UHo++T1HLtgKzX2PQ
	 xEUITLBX0E09+92YQGP0XUWx17/5z18lNjyZN4q7mdZQh8eA+RteeMQSeNRmxwl2fw
	 j5xU1AZVqk7ZA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] src/min_dio_alignment: don't return invalid dio_offset_align
Date: Wed, 11 Sep 2024 11:53:33 +0800
Message-Id: <20240911035333.364961-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If returned parameters of statx() are: a)STATX_DIOALIGN is set in
stx_mask, b)stx.stx_dio_offset_align is zero, it indicates filesystem
supports DIO, but the file doesn't.

It needs to avoid returning zeroed stx.stx_dio_offset_align value,
instead, we can fallthrough to get alignment size of block device or
page size, otherwise, it may cause potential deadloop, e.g.
generic/465:

align=stx_dio_offset_align(it equals to zero)
page_size=4096
while [ $align -le $page_size ]; do
    echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
    $AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
    align=$((align * 2))
done

Cc: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 src/min_dio_alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
index 131f6023..c1d7112d 100644
--- a/src/min_dio_alignment.c
+++ b/src/min_dio_alignment.c
@@ -28,7 +28,7 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
 	if (fd >= 0 &&
 	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
-	    (stx.stx_mask & STATX_DIOALIGN))
+	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
 		return stx.stx_dio_offset_align;
 
 	/*
-- 
2.40.1

