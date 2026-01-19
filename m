Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006B22D7B5
	for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802088; cv=none; b=I4alZmwzfUb8S63fUMrf0MbJdSE3VpzyP/09PnJNmpqYI3UyL7io0AgK8ysg1+Xo97M9n6BPCcnPex0mhrHDmAhmgB+OVwbQV5NOSJlZ0RYwaKBuCh1AZpJ4H4DfK236GwCLInxdZNwHdVJEQZA7TOZ6dZmBj4VZbWcbMMxlVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802088; c=relaxed/simple;
	bh=SKtlzoj4ZCO/qwA2t0YGj1rEFFshUDGCVQBojdiJ7N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iagkeF3Tb1Po0TZUYamtXiuFBS9JIgTqMSbg3p4N0lhdgZWE87XDnxiEQiQ5CDHCjieTkrn+lqphTc8BbmWIo0qF38rpXXnDcX6R93HYBwnuCPuRH650PWc0CTVNEIbh8LkGDN96rmIKwA2LTYIMtBTex3NS4D9ABMQBYbBPzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lx8sXNmI; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lx8sXNmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768802076;
	bh=ZDC4awGUEztTjdwv6yJbRGGAEhkqhuzNymmBjcteGZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lx8sXNmIZ4HfOd5MGKyq0lBGcGJJNWITEsJ2AJrHNE8LqeG9Wi8LTLTyljvQ09aTj
	 gqlxuuRirRuecRm3cZ1bOllj1jYRRS42jPTTuq0dwTVfS5Vt10EYwZkaoOzcA2tL24
	 9kMsiJpmotCk26q53zWcE/059cJdGPjj61vMT7oQ=
X-QQ-mid: zesmtpip3t1768802062te8e6d48f
X-QQ-Originating-IP: sxfWwHPY/AWJIPMbNqE7k7rwzpZrImzuyfqfnPsrHKg=
Received: from gc ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 Jan 2026 13:54:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7080483370103243347
EX-QQ-RecipientCnt: 2
From: caokewu <caokewu1@uniontech.com>
To: fstests@vger.kernel.org
Cc: caokewu1@uniontech.com
Subject: [PATCH] ext4/307: allocate donor file size dynamically
Date: Mon, 19 Jan 2026 13:54:11 +0800
Message-ID: <996DAD8F7CC08BFC+20260119055411.1573173-1-caokewu1@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OCFGt05vYz7Y4TFnm+Mu7zt4GvIfP/LEwZ4Db9/FDm8GMjHF01pJCE30
	vHzRIrqdsglfPNo2xTtg95zpvrIF5G+dhPQ7k8qhQaHMjjbXsrfhzZ3au+AdOj6BuRqoQG3
	Tb2QYqp+IAxOYHqdx/RL/Rs4hKe9j8i6g3g1932nk+d50R53mlQ9oD7fPO9tdNHRRVWfR94
	EJDZxZSsg3ctMW+0nmIOVj8lHybKfMWXgzOPfd6goRD2lLy8rgPka9E+unQ4aPAZp6aN5d8
	BjdJSc49nkZegC7UnHVrDPqoVpWjCMuCoH/icILlpLVyz/yVAjaSDOBEqFA03R3aPBMdSeW
	gJeZn+4pG1m0TZpdhJ13PSR7ejH0xpxy2UbMpHBFyYuNXKb0lxkJlQ8BPiGjpSZRrtmIX8p
	IAr0oeNjd7GP/5jZwYkKiWc2nP1LSbwdxa5SQVzENUH2EDN15DSH6Am7JSY9y/K+igfBKV9
	8LmoyBuwZ1pkdRXrrldjJcxEt4565EuUCsoG5misr5MwF2ltNgxKxlCSAGdA+6xNwwuUeP4
	AbGQaM4XHgxrWoG/7DT6b53IlA1UzrLVkcMC6S6nnXaqNUWMsICEBwB5e5/Ul1cMeBK6/4Z
	8vC+MhHCJakSpej88nwhTiF1/gOIs9QyTSohtoZjuNA0Gvc+IWZxvzIBWH5N30Fza2AgEz/
	EYMyG2Tv5Xm/HNXlMjQZPk91SYr6Nw7UCfW7LpdLBsVOBXhBtAvCkvrgf3o5pxfQ8pw1nSd
	bP+Pr7FheldAmXcLlZEkIpV7fO/6UefRsQhbrrG604JwS/ItXHYyEn4kPw5Z16LfARfbOjX
	eqedGZAiQs0daBM6XfBdlXJs/CMmYq2iDiFVNinh6Uc7vNwlbycTUmAdlPE6nGUeZYBHf9y
	oJ7ScBddO8lJt3lKJILzmmmpUQh3NWq38kODtrfRBh3W2Fo4SNs+sRFEnOPs1oFWe+fpRQh
	mHpT75ILiELuYnFTjTl66AKLmglmqa4urxfPyuw6EaEbC8W+ZEcaak3ggfplERnziKwWC6t
	Xo4FMqDC4dDf+fApjWEM5rXAm3kqvEcY1IXE14EAlqGDAR9G7XE9nLA1UjqQx15gZGmvz5y
	mlng9bYGPn5
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Currently, the donor file size is hardcoded to 250M. fsstress can generate
more data than this limit, which causes the `e4compact` helper to crash.
Specifically, `e4compact.c:do_defrag_range()` contains the following
assertion:

    assert(donor->length >= len);

If the donor file is not large enough to accommodate the data being compacted,
this assertion fails (or validation logic rejects it), causing the test to
fail unexpectedly with an abort or error.

Additionally, the previous 'usage' calculation used `du -sch`, which outputs
human-readable sizes (e.g., "1.5M"). xfs_io's falloc command does not
support decimal values in length arguments, leading to syntax errors during
file allocation.

Fix this by:
1. Using `du -sm` to calcuate the required size in integer MB (rounding up),
   avoiding decimal issues.
2. Allocating the donor file using this calculated `usage` size instead of
   the fixed 250M limit, ensuring it is always large enough for the operation.

Signed-off-by: caokewu <caokewu1@uniontech.com>
---
 tests/ext4/307 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/307 b/tests/ext4/307
index 1f0e42ca..48073347 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -24,9 +24,10 @@ _workout()
 	_run_fsstress $args
 	find $out -type f > $out.list
 	cat $out.list | xargs  md5sum > $out.md5sum
-	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
+	# Use -m to get integer MB size to avoid decimals (e.g. 1.5M) which xfs_io rejects
+	usage=$(du -sm $out | awk '{print $1}')
 	echo "Allocate donor file"
-	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
+	$XFS_IO_PROG -c "falloc 0 ${usage}m" -f $SCRATCH_MNT/donor | _filter_xfs_io
 	echo "Perform compacting"
 	cat $out.list | run_check $here/src/e4compact \
 		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
-- 
2.51.0

