Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5238BF72
	for <fstests@vger.kernel.org>; Mon,  8 Jun 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902019; cv=none; b=DoUgWxvTtrlkgwvxvlf+A4SQUF/nxUVDchDzIL1n6/scEJ7ZRPG5kA7RJT5Elc16DousDARcx2Ocri5OH1syX7V9lE6AETMUxmIgfToZy1lgZW9wuiBN62MrpqzuCF9BRVZNB3mpW06EVgqMgpbMJVONs5mC9+comQQo0aQ2ksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902019; c=relaxed/simple;
	bh=x2mSJhrK1anqIbNz/MDg4oFkDncEid5Gj6L9g/NGlZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rO84KsY8TuufRhruEcMQ/mJT9s5JQqVvm8mYjyDECk2c2wC2eXWEz6FgWhvGQlnEf3iBDa3lajPQEwtj7YnqOiJtzmDrAE3bEtr+zdmvMTmf5btgrnCdv5lOeH1V7kzQIm3B2ru5Zz7L8A8MAcXqJoRf5mN9LjB0hRwPdxizfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KIWYafEM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KIWYafEM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FwhKuCDvl6yKCLFs5R4IW0DxiEX03S7x8oAsnKlnWRE=; b=KIWYafEMNpe84NqL0vGI85eXq6
	FOqJF2NYJqLSa+CwF/MeomtkVqLTBqjOL3hoUErcf+DbZEpA5VykS91S7RiCHv9zYVYkkPs9StkpX
	1s54rZuDODr6KkweMRNtl2QxNSfmuCKCrPEjbDi1CGzBH4vbaQuIu+0ld0ZJLenJoCnqRlLO9PIie
	hwacJudAv5eXYOYeHCpXmBy6DOCU/SkDWvVuAadErA7c8nrMvQK2heDb7mAr5gid5z4T0KtLs6IJD
	1wV+r7K0OuuUVuiI1VO2CNMPECGK7SQ2W1P0awdB2GAKvDWZ04LXMf+p5BHbVge+yH8J+EL7wsPrv
	Q4Qce5Bg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWTy1-00000002vwU-42jD;
	Mon, 08 Jun 2026 07:00:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/366: check minimum dio size correctly
Date: Mon,  8 Jun 2026 09:00:10 +0200
Message-ID: <20260608070010.1285677-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

min_dio_alignment requires the file system to be checked to be mounted,
so move the call into the main loop.  Drop the pointless blocksize
argument to _require_odirect, which is only tested on the test device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/366 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/366 b/tests/generic/366
index 271a01bc2eac..ef69bf09d6ff 100755
--- a/tests/generic/366
+++ b/tests/generic/366
@@ -20,7 +20,7 @@ _begin_fstest auto quick rw
 . ./common/filter
 
 _require_scratch
-_require_odirect 512	# see fio job1 config below
+_require_odirect
 _require_aio
 
 _fixed_by_fs_commit btrfs xxxxxxxxxxxx \
@@ -30,7 +30,7 @@ iterations=$((32 * LOAD_FACTOR))
 
 fio_config=$tmp.fio
 fio_out=$tmp.fio.out
-blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+
 cat >$fio_config <<EOF
 [global]
 bs=8k
@@ -60,6 +60,12 @@ _require_fio $fio_config
 for (( i = 0; i < $iterations; i++)); do
 	_scratch_mkfs >>$seqres.full 2>&1
 	_scratch_mount
+
+	blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+	if [[ $blksz -gt 512 ]]; then
+		_notrun "512 byte dio alignment required"
+	fi
+
 	# There's a known EIO failure to report collisions between directio and buffered
 	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
 	# at here.
-- 
2.53.0

