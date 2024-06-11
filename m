Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9118EAB
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144831; cv=none; b=X03ZcIqNcU8Eizrx6ElMxwteyZIKvptc0+ZN7ol2lCZELXHrjnaRjeX5xvsrWKlcF++iG18wu7ef3XLZlkXZUbRkYzc9ZfuI5pC6vNbDAEGAq/FjyJQz5/4eaeAkgt0iB2YgkPtk4Zp6cgk1psmDlYvJeLovwBahU0pB7YFPGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144831; c=relaxed/simple;
	bh=Zp49IO5i3xmdy4qDUyLEoh/zfbVaGjWCsgWZt0ig4r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRl99GaTKBN1Iia9OY94uBkm0hABIJZsPN7+WastE9OTGXJwEBsz1eInuI7UP77M9JI6PC8uRBJhqvFyT6rZ2Wf7M6TIL791Eq7/RMr+qlHBEzd1FJDJyLNUr6zUEyncEvlDDh1iM75BwKMPsAIbzbCBiH05DgyanECCw49G0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jFImUMoV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jFImUMoV"
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45BMR3l3005887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718144824; bh=qSWomZEqcEdr+p0dP9wGSrvjBTl7zCW5GHqvfmuNrx8=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=jFImUMoV2ldkQyHtmu0QNJlBk9arDEs38ndnBQZvOfTTBDzNMpy7iRVNa48WCMOX6
	 vnn7mwWS+WLSiBU408YZOcCZTHzlGU0oq/lSpt5A5+dF3DZKMV9uFuv0f3oCb9bZdH
	 MmTwlhhRcEXwgG7sJg9X49UcR2ftHneU+gBoVaVixLyO8Nlc1bc2x1QTuaTnweDCRr
	 O7FLlko04rTfVbFVadNFRRs0+yOsR+MzyIRr40BcHXRN0Iu64FMNATeHf6J4F/vnpH
	 eTeP+tFmTMMdcyna8K1/yFapusgVehq+9iXCKIz9J6y1kvrU70OkCG56WIWHKxZ1w2
	 w28XSiPuLDxzQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2984B15C0579; Tue, 11 Jun 2024 18:27:03 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2 1/2] ext4/045: use the large_dir feature to fix test failures with a 1k block size
Date: Tue, 11 Jun 2024 18:26:58 -0400
Message-ID: <20240611222659.256476-1-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the file system has a 1k blocksize, this test will fail without the
large_dir file system, because the depth of the dir_index tree needs
to be greater than 2.  So enable the large_dir unconditionally, which
also gives us better test coverage of the large_dir code paths.

As a result of requiring large_dir, this test will get skipped if the
kernel is older than 4.13 --- which was released in 2017; and that
seems to be reasonable at this point.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/045 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/045 b/tests/ext4/045
index 4f0ad4aa7..a90ae1ba3 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -20,6 +20,7 @@ LONG_DIR=2
 _supported_fs ext4
 
 _require_scratch
+_require_scratch_ext4_feature large_dir
 _require_test_program "t_create_short_dirs"
 _require_test_program "t_create_long_dirs"
 _require_dumpe2fs
@@ -42,7 +43,7 @@ workout()
        echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
                "Parent dir: $3" >> $seqres.full
 
-       _scratch_mkfs "-O extent,dir_nlink,dir_index -I 256" >> $seqres.full 2>&1
+       _scratch_mkfs "-O extent,dir_nlink,dir_index,large_dir -I 256" >> $seqres.full 2>&1
        _scratch_mount
 
        # create directories
-- 
2.43.0

