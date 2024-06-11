Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C19176252
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096347; cv=none; b=ZAIi+xtLKCPZMvL6NsXPE4r22EixUUpTHCHqzijTv0uMBIqSLjRMBgZBPYrHmuL00CSQNO479RBlBINT2aTvDdRAOYJp5c8C1/ZkQqdRLs0PByOeEc3p9Q4It2m7RkjLwo5jmECL7eP2xkocI8DoCOXsJFmelVj9DKehnjB/SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096347; c=relaxed/simple;
	bh=Er2jEdwHjFW6zZ6kleAXr7Ln/5d6gzUVGS80eHdlNj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hE6qG4gvWopE3I//uB+qQjY0ofIL9DkH75rquhnSb9W+lA5cav+22ZVkUrTo9T0CeIjLxkWol8PjVE2EDF+Wo1/RJoTs0lJvH8f24scEeF0Oba6BBPa+bIsfd4Kiwzc6jwUIkzmqzJf/gGI/jPyJtIGkHbDfvtR+MCEhPOkCxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XPZtjc3q; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XPZtjc3q"
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45B8x0DC015386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 04:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718096341; bh=wp9mhALZCOtu/W3V0bZVnoZM6s5NCxrt16gw/S1s6nw=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=XPZtjc3qnEshUAHxziIWntEdy1VWjFuyjxGeaS6drLvuc/DTG73ChQV+klIz3ELDU
	 NYp7nSrkDtlKGZGgHodl6M0pAokojdMm/+OjW7mdNonwWtK4pV+ydFSpVv5d0nZzxf
	 3w/6+7P/2S6TStmVHqlLjr2UXSN54mAKDa778mQ25vgK7VNrznFK1cwO8mUDYzYtuC
	 LRN40ngk3MuYvwe/o+OneqqCwEpe8s/2t/7Qk7k3N2WXR14+9ARY+X+pmxzqBhbv48
	 oOX9qOp+oimAo1hJqwSKME1alA6h3CvAyIvZTrQo4HQzvheDqxtcN8m3Kb2kF1wNVq
	 ceUvL5beBdCig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2052415C0579; Tue, 11 Jun 2024 04:59:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] ext4/045: skip test if the block size is 1k
Date: Tue, 11 Jun 2024 04:58:52 -0400
Message-ID: <20240611085853.200102-1-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the file system is 1k, this test will fail because with dir_index
enabled, the directory tree will get too deep, and the kernel will
return ENOSPC and log the EXT4-fs warning "Directory (ino: NNN) index
full, reach max htree level: 2".  So if the blocksize is less than 2k,
_notrun this test.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/045 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ext4/045 b/tests/ext4/045
index 4f0ad4aa7..5ae7a45b5 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -44,6 +44,10 @@ workout()
 
        _scratch_mkfs "-O extent,dir_nlink,dir_index -I 256" >> $seqres.full 2>&1
        _scratch_mount
+       blocksize=$(_get_block_size $SCRATCH_MNT)
+       if [ "$blocksize" -lt 2048 ]; then
+	   _notrun "blocksize $blocksize, too small"
+       fi
 
        # create directories
        mkdir -p $3 2> /dev/null
-- 
2.43.0

