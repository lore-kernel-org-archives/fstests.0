Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5D1F4191
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050807; cv=none; b=qPxhyWso1yELN1YzlJYqFS/0FS7tVVM3QR52ZUUiA1h9H6Kn1D7RbgwUvMjQoOCi4mF6YAdxKfq5PxZwdaRg4z/dHETiT/6Cb833st+L5zHCgyrSvNOLnUC6+Tre8CQ56lRfz4vDT6BFYKPRMHFtfGY6eW6jE+onnVIyRrbOPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050807; c=relaxed/simple;
	bh=wih0uWB8TeWdk0JmQY1jji9J2wFv2VTyzuuiBwVkmkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lqM9d7Jfc+BQMJXW6A6Iywbt4pL/nzi36qXXq5Jh9gmDhBSCKJrs+X8qYNT+EBZtMw63vwz7Y3AX8FhGHOQ88hJex5TwELX47meVphJ4igN6qV/xxzQOUmB2I3os77KSec+1X7RODZXyzDx+5lf5jC0lY/2gaft4zOKDNaXwq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNAqZvMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNAqZvMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29248C4CED1;
	Thu, 20 Feb 2025 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050806;
	bh=wih0uWB8TeWdk0JmQY1jji9J2wFv2VTyzuuiBwVkmkI=;
	h=From:Date:Subject:To:Cc:From;
	b=DNAqZvMpVppE9HueOeIB0+9cMYmma5tr+783apvR4jG8gjWoPw/KABGV2eb2eeEWg
	 Xd9VK10HyV5B5e24++6msZBA425CXukky1qWMnLzyAdBn1xnOytsHYSf24ZAP3IWJY
	 lFNdKjuneWCvGhyi3yQlXFIX8481MW3xDxsX1T87P18hvRk12LvW45cxREUEzvzAE6
	 VJs2mg7u5XW8idI3PJyOaM+sIw9NqrkhbUu/MiPZWl+sZ8TCzpS4Cw+rb7fw2fZMxE
	 +pGSaFzkbK6p/oz5SUgy/tf2G3q2V+5U3AMdA+hBzgXvqfaBupsmStLtYtIga+N5Gy
	 z2Ow39kSbL7qw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 20 Feb 2025 06:26:38 -0500
Subject: [PATCH fstests v3] generic/126: run it inside its own subdirectory
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-generic126-v3-1-03a061b6ed50@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG0Rt2cC/3WNQQrCMBBFr1JmbSQzbZPWlfcQFzZO2qCkJSlBK
 b27ITtBl4/Pe3+DyMFxhFO1QeDkopt9hvpQgZlufmTh7pmBJLWSsBcj+2wYJCVsh0MtiUwzaMj
 CEti6V4ldwMaV4xrhmofJxXUO73KSsMy/egkFCokdN6yk6RDPDw6en8c5jKWT6L9L2WXd1toq0
 yupv9x93z/yrf/k6gAAAA==
X-Change-ID: 20250219-generic126-f81b3022c4b7
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
 Dave Chinner <david@fromorbit.com>, Zorro Lang <zlang@redhat.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wih0uWB8TeWdk0JmQY1jji9J2wFv2VTyzuuiBwVkmkI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBntxFwHspWf+3ye9pEtdf60ihYMnmjurmDd+Xhm
 U6W5e7yDjuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7cRcAAKCRAADmhBGVaC
 FRk5D/97d6bHhUVkToh8j1XDuEUAodqVn7r6CMlQuaevG3KVt2iAxFC0/yYEWGRVB9+u4N/eQMS
 UVOiTBPuzWE/7KFUOsPvWNMK+4DJRcKWetTEGGYz2XS6DJ7L9eBF15jfiDfLCiaUxO836i/TMFQ
 QWrzZWCOhTK38WJpxRQGSdZvY5KWH4Pt/rkT/BJifVM4scsZ0taQ0+Mkit2efoGWRnqu4hfmcwb
 amVdYKd7SybKXK1iD3gzxcCOWWG4gjCCUpbE4MtlsRXhnGxR4x6m4+3FKj7RFbMZnd75fAAeFOJ
 ZlhOApGL+8oSCl/oheg/KSSQ6q5GMGogTNXs0XKYmO6mSRJ3xDVI+p4RJSx/gEXANKbKNapXG4G
 8RxGGOD0CURuoRmYmyDGaUWp9MtAkJTJsQiHXmP0PVJjYc+uAA3bncXfjAxCZMbrhnh8rdGUimD
 1qBwM+ayuAMHRSmUyNHSPTTrlfe0Q3f4rYN7sfJEnHZfcMFa9H+V/ewNvpVo3HmYAfn9LMnVQ67
 mDsAVawwN1oNGVMD1nOpobHAcp/3aBds2hKePeFaHlmI4hxdccT9GoaD9bUnUMCEsub4PvMhlk3
 u+QzjiWBK3ajYBhZun+ecqgxKQk7mi4Yo2iHUoNd4/Zk+wOdOZJ3GVZgdC5c/gCK03vav31/blI
 EDxPSXqR5UeSEuw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I had been seeing some failures in generic/126 when running on NFS under
kdevops. The problem turned out to be that kdevops makes the root of the
NFS export mode 01777 by default (i.e. with the sticky bit set). This
causes some of these permission tests to fail because the open() is
called with the O_CREAT bit set.

Make the outcome of this test not depend on the permissions on
$TEST_DIR. Create a new directory to do these tests in, and clean it up
when done.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Add comment explaining the weird setup
- Move all of the cleanup into _cleanup()
- rm -rf $testdir before doing mkdir
- add call to _require_chmod helper
- Link to v2: https://lore.kernel.org/r/20250219-generic126-v2-1-e7537f6c9607@kernel.org

Changes in v2:
- add commands to _cleanup() to clean up test directory (Thanks Darrick!)
- Link to v1: https://lore.kernel.org/r/20250219-generic126-v1-1-018e4e60c811@kernel.org
---
 tests/generic/126 | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/generic/126 b/tests/generic/126
index 142d2bb97db706bafd2152856ef0993c5c273441..97b4a07344bd5d3d5e06b36831978c9ad314b9d7 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -13,6 +13,7 @@ _begin_fstest perms auto quick
 _cleanup()
 {
     cd /
+    test -n "$testdir" && rm -rf "$testdir"
 }
 
 # Import common functions.
@@ -20,10 +21,22 @@ _cleanup()
 
 _require_test
 _require_chown
+_require_chmod
 
 QA_FS_PERMS=$here/src/fs_perms
 
-cd $TEST_DIR
+#
+# This test is testing filesystem permissions. If the sticky bit is set on
+# the directory, that can affect the outcome. Create a new directory with
+# known permissions in which to run this test.
+#
+testdir="$TEST_DIR/generic-126.$$"
+rm -rf $testdir
+mkdir $testdir
+chown 0:0 $testdir
+chmod 0755 $testdir
+cd $testdir
+
 cp $here/src/testx ./testx.file
 
 # file_perm owner_uid owner_gid tester_uid tester_gid perm_to_test expected_result pass=1
@@ -46,7 +59,5 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
 $QA_FS_PERMS 040 99 99 99 500 r 1
 $QA_FS_PERMS 400 99 99 200 99 r 1
 
-rm -f ./testx.file
-
 status=0
 exit

---
base-commit: 8467552f09e1672a02712653b532a84bd46ea10e
change-id: 20250219-generic126-f81b3022c4b7

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

