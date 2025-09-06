Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010722EFDAD
	for <fstests@vger.kernel.org>; Sat,  6 Sep 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164647; cv=none; b=Dk41vF4Q0wxr3xieCTHGyJdaSX7zQUbdP9PsZHwBZ8ZIY4RTdKaweqbVCrHNFwjIWwVqyISB8Y3Zn0QBPE7JXm3aSgoKUcxHqaG2FvZDT+SwGrYt2LBk/bC4X0oDC8Gwlhy+994VSDRZy6FqnUWE3pP9vPxJ4oP2ieYCKyFlAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164647; c=relaxed/simple;
	bh=lcY6kfXsOFKUROZwNB0gn3jPYPWwbN+4G2hgbZaucfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJ7E4NnRtUviYd4nfowJbF2biW0OQSJATC9HsDMeI64U31bcmjqcN3WO/Yfv7J6nbRx364AXcOYj1WjVpd2QyBw26izd05DbeYvgRC2UjKh3/noLS9auTwUsxQLHL4ElMPqLCbXghdNJlqFmvO77H4bhouYZkYMUqS567mGmHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWnys/ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWnys/ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC754C4CEF4;
	Sat,  6 Sep 2025 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164646;
	bh=lcY6kfXsOFKUROZwNB0gn3jPYPWwbN+4G2hgbZaucfA=;
	h=From:To:Cc:Subject:Date:From;
	b=rWnys/ymTF+2vRc8NcaB9XH6ou7bWXo+NINCqmtRNdmGmN8YpjpTARtP2gR5EuN8r
	 FM3KyirpMlsFDyTFm+RSt73HzVoTDyPfbJv2x88RQ9xp83pvx/sBQWdCbVKMbV4Tgu
	 2rYvXsLOVXdlUkbLZkhACu3CS/ODXnYMj/wDiwcHsdqItLS8U1/k45xPkMZ+wjatjW
	 JSS12yGYhA/Qn2luY+mU2HCay5MbLuB2vn+8X7RdZwI8OCaqNSBCPn5GaZ/eUEj3OY
	 r8ui88JNQsb4vZBQADXKntRAcS5cySCTRQNIsf9wj4PvdkIsbvQ6S+l/Ypl1bYK0ty
	 1fx2+kHnnLIKQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH] common/atomicwrites: fix _require_scratch_write_atomic when awu_max_fs is empty
Date: Sat,  6 Sep 2025 21:17:22 +0800
Message-ID: <20250906131722.1333025-1-zlang@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a kernel doesn't support atomic write, _get_atomic_write_unit_min
and _get_atomic_write_unit_max will get nothing.

  local awu_min_bdev=$(_get_atomic_write_unit_min $SCRATCH_DEV)
  local awu_max_bdev=$(_get_atomic_write_unit_max $SCRATCH_DEV)

If $awu_min_bdev and $awu_max_bdev are empty, then the logic likes
"[ $awu_min_bdev -eq 0 ] && [ $awu_max_bdev -eq 0 ]" is meaningless,
and it causes g/767 hang on system which doesn't support atomic
write.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/atomicwrites | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/common/atomicwrites b/common/atomicwrites
index 33526399d..bbcc4e7c5 100644
--- a/common/atomicwrites
+++ b/common/atomicwrites
@@ -47,8 +47,9 @@ _require_scratch_write_atomic_multi_fsblock()
 
 	_scratch_unmount
 
-	test $awu_max_fs -ge $((bsize * 2)) || \
+	if [ -z "$awu_max_fs" -o $awu_max_fs -lt $((bsize * 2)) ];then
 		_notrun "multi-block atomic writes not supported by this filesystem"
+	fi
 }
 
 _require_scratch_write_atomic()
@@ -58,7 +59,8 @@ _require_scratch_write_atomic()
 	local awu_min_bdev=$(_get_atomic_write_unit_min $SCRATCH_DEV)
 	local awu_max_bdev=$(_get_atomic_write_unit_max $SCRATCH_DEV)
 
-	if [ $awu_min_bdev -eq 0 ] && [ $awu_max_bdev -eq 0 ]; then
+	if [ -z "$awu_min_bdev" -o -z "$awu_max_bdev" ] || \
+		[ $awu_min_bdev -eq 0 -a $awu_max_bdev -eq 0 ];then
 		_notrun "write atomic not supported by this block device"
 	fi
 
@@ -75,7 +77,8 @@ _require_scratch_write_atomic()
 
 	_scratch_unmount
 
-	if [ $awu_min_fs -eq 0 ] && [ $awu_max_fs -eq 0 ]; then
+	if [ -z "$awu_min_fs" -o -z "$awu_max_fs" ] || \
+		[ $awu_min_fs -eq 0 -a $awu_max_fs -eq 0 ];then
 		_notrun "write atomic not supported by this filesystem"
 	fi
 }
-- 
2.49.0

