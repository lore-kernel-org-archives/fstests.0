Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD27745CB
	for <fstests@vger.kernel.org>; Thu, 14 Mar 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437122; cv=none; b=Q25qi7M0Uas+DEY74NBAJfufrHDwFAG4q67ipe40W53wajLRtFmHiUZ28psBlKIywo40w3MWm6wa2ox5J7E8e0oDO5Z4sXRKDojCXXYlzXZuWJCA1bfBk/CMlN+yPUA4BMM1m1rk2Doz7VMO2vOzmwlbgtaTwwRR2sub+vGvyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437122; c=relaxed/simple;
	bh=ZkbPmd84aZrgU7Mr1IZoSTtzNCeHg9NtPgujA39y6q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcw4FkL2GcHywga6aLXNPQ8t6qvGCkGUZvT/gbrs004eP+ck0t59mQhqiUnXLjA72SUBj5AVIx5mGmTh8qxfftsX3zzPVxH7n8kr8RjA4kKMsaqncLjA96skb9J9ySD83JZIEx+5EXqFji5xkm5TkZOaEvM5hWrDdMpJDZFF5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hotRRs2I; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hotRRs2I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710437118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XdGgO1TEOOTezEM+4yrtkN01oqGzC47rk9XV3xA9uc=;
	b=hotRRs2ImNzkMr5dTnLYkI2nmJMRODAs4em1IU7wonWs2FLhYMzeaNw/bm0PJ3TnoP8LEq
	L9/HhDU9b6AFCkoFxJVkhmTGo9+1YIDK5N3hObAWSPyjDpYNhMzDyH6BoHxI0koqzbu18+
	cP6Ga9Fu6WrAlU6EQUz/59D/9/RQQzY=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 2/2] ext4/006: take into account updates to _scratch_fuzz_modify()
Date: Thu, 14 Mar 2024 17:25:12 +0000
Message-ID: <20240314172512.28293-3-luis.henriques@linux.dev>
In-Reply-To: <20240314172512.28293-1-luis.henriques@linux.dev>
References: <20240314172512.28293-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since function _scratch_fuzz_modify() has been updated, its output has
changed.  Modify test ext4/006 to take this change into account.

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
