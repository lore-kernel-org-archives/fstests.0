Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4F4CB2B
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522814; cv=none; b=mzDC8Y9bKD/3RYMltOi16hiGG82bqjcDtir83Cret5rZg88i3XyXPXB/iJDRin0vcSB60RSDiKx5/BwqA1e6wUYi88La7FW+lCieQD43k8qZVJszBRlC1NcjUHDR3IZ+AhqZM9SHqHpQE/FT7nJCOR5QpvFO/b8GABenpEm4b/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522814; c=relaxed/simple;
	bh=IySWL/rCEiWe0GOKrQU5GyvUVq7mYchJ66Ser1L90c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olkLyq1Ei6pZZrOAtR7VzXhIeUT7yVUE9mkYf3kmOeej3vMmHf1kjMtm1n6qlmQRMamPjXNWilkeldmORkKowY/keHsTajVIIhxiGVLKlK21AkvPgyKaLzGYNmy8K3Nn5RbQL5GTUZ9XKfo7+VnN/Ypc6ymz0ro3MgNYEPrwdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WvNXcFhL; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WvNXcFhL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710522810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjvWWODOH4e4DK+Q55L5x7gEhKaP0VpKK092WhRW060=;
	b=WvNXcFhLu8NROUFVjipGlwRn5xJD45Il465tDfKOPuYJy/O/nm+Knjc7UlJjZBxVJdl/1F
	uobyHPBVc29w/5JxieVYqhDPWplG/5gnOFSHOifMz9pMrXdc1p9I0y+U8GrMotv+4xn0sT
	P1dHLytFtHV+6h3bZwKFw4c+dlfjAMo=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 2/2] ext4/006: take into account updates to _scratch_fuzz_modify()
Date: Fri, 15 Mar 2024 17:13:25 +0000
Message-ID: <20240315171325.2885-3-luis.henriques@linux.dev>
In-Reply-To: <20240315171325.2885-1-luis.henriques@linux.dev>
References: <20240315171325.2885-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Test ext4/006 takes into account the number of lines produced by its own
output.  However, changes introduced to function _scratch_fuzz_modify() by
commit 9bab148bb3c7 ("common/fuzzy: exercise the filesystem a little harder
after repairing"), modified the output.  Namely, the following three lines
were removed:

	echo "+++ touch ${nr} files"
	echo "+++ create files"
	echo "+++ remove files"

And a new one was added:

	echo "+++ stressing filesystem"

However, the usage of 'fsstress' also added an extra line with:

	printf("seed = %ld\n", seed);

So the delta is one line (-3 + 2).

Modify test ext4/006 to take this change into account.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/ext4/006 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/006 b/tests/ext4/006
index 8792167bd9c2..b73692aa5b81 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -131,7 +131,7 @@ echo "++ check fs (2)" >> $seqres.full
 _check_scratch_fs >> $seqres.full 2>&1
 
 grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2fsck failed" | tee -a $seqres.full
-if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
+if [ "$(wc -l < "$ROUND2_LOG")" -ne 7 ]; then
 	echo "e2fsck did not fix everything" | tee -a $seqres.full
 fi
 echo "finished fuzzing" | tee -a "$seqres.full"
