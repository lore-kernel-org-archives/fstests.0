Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DF1A239F
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140833; cv=none; b=K/bwz7mcUL8fhJoi6UsWS5mxRNRFj1MFBuCjiI3j5dmb3mlrUd5s6ken4WFsaJM6IhkhhkIsLOJKWVjC3iOIdFWEj+/witDr4avowFmnZuiNuo3DMWpmguGbqbTLK4vDyVJuVQp8pl5m/PFHAvbYwZJ6IUvchT0BU5Gp7D4NQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140833; c=relaxed/simple;
	bh=5vyfjpMSFsJriah0dm+tVLQaZ/qFXCjGTFFAAWmLHnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAOjcUlLzzLiapzi9CO/rA+jtwL4wZ0+zkCiCUA2TFI4/FWuJxfspXP4HO96GiCPJS6tvRHaNUtMfLPO9zrwzQ334RHxoWPp1YOm7fYKkCW158H2tv3YWIwJKwDPm5aQWc2GcsyoTd0zhFduXcrPY/0ljywxhd4RjJ5YOz6eG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZiX8mhP3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZiX8mhP3"
Received: from cwcc.thunk.org (pool-173-48-114-200.bstnma.fios.verizon.net [173.48.114.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50HJ71x8026561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 14:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737140823; bh=L5hfQywHMWxOjaXaEONqwiZwfdXeV4xk+8t7uDj0TVA=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=ZiX8mhP3xgYwXHW4q/P94VwuTFK0yNN4LvQCCnJW/iv2LkTqgHF33OzQ+VTmBteZd
	 I8VS48/6NSbQoypm0z2h9gxJ8KJ9OlUA/+ChcATniAOZ3d6HqE7zikUMxIQel/p0R6
	 KuUCdc6nL8XiIi4uZEPkjGae00ggA9MSnjraxU05MmuWjJqOt0fb/v2f8vcsaG6aBi
	 vLgaIWGrGYwKCBdxPZh5Gz0WX4xM2umYFDuotbx9vfAwAA5VO2qbiVmwTjFIPozT0d
	 dmb5LXpl38nm6hxNtFcZpLb+tNfoJRZ/Q4bPJlyn8550Ms13O11ipuzSMOPKUGU+aZ
	 v+nkq7j5JAl+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7505115C011B; Fri, 17 Jan 2025 14:07:01 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] xfs/32: fix test failure on kernels which don't support bs > ps
Date: Fri, 17 Jan 2025 14:06:59 -0500
Message-ID: <20250117190659.3189518-1-tytso@mit.edu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When trying to mount a file system with a block size > page size on
kernel which doesn't support this, suppress the error messages from
showing up in the output file lest it cause test failures.

Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/xfs/032 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/032 b/tests/xfs/032
index 41a9134d8..9c1741cf1 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -44,7 +44,7 @@ for ((; SECTORSIZE <= 65536; SECTORSIZE *= 2)); do
 		if [ $? -ne 0 ]; then
 			continue
 		fi
-		if ! _try_scratch_mount; then
+		if ! _try_scratch_mount >& /dev/null ; then
 			if [ $BLOCKSIZE -le $PAGESIZE ]; then
 				_fail "mount $(_scratch_mount_options $*) failed"
 			fi
-- 
2.45.2

