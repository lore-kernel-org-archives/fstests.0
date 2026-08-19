Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD14481257
	for <fstests@vger.kernel.org>; Wed, 19 Aug 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153249; cv=none; b=CPpjCIsCH9b4SrF7Enh3TUksG+gi2N/3D4MtMsrujg3uMW+gdaYM/SPCfs2FT07dFfgtRD7z8QmzvyXaJI8/yjmYjkZ3hYF5K6C+zCWfnThINlFIOcQRFyymJn+IWt1or6z/D26rklT/8CosY7KQQ0B0PBmJIL9xbwaU+sk0y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153249; c=relaxed/simple;
	bh=GMq3CXWBGidU9rbjhhxLA0bkbhSZiF6vcERu8tS4NVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bty8lARjzI5gHtyaPrBPNdZDESkhk06Dj1pSleEoehAJaWmevjMKzr5DYkFUrblESOwq6/NAWQy9X3YXmcWqLVxDZ1oubLzqWQH7788l1De07l3vN9B4YK2Eg6DeP5otkk0pfvc6wCpkFh1fSZNhyCp8PAqXq1dEnbbhrJMmq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWS6w3Sm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWS6w3Sm"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7106F1F000E9;
	Wed, 19 Aug 2026 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153247;
	bh=9Lio/cIjKqPTxyDqA/PqbBOXFSlh8HRUCizjRyib8FE=;
	h=Date:From:To:Cc:Subject;
	b=MWS6w3SmS1TS/TVgQ0f1xuVmvtpsNfggL9IMXdEDZjn9+VhvAfWN1TqVZosuSDXe1
	 5EdhM4rRlNksGDKcNKPTcEqh2V5TQuMxuxI4MAG+En9jQcXs1yQ+3dsJE3Z+0jm3OG
	 6mmBhp+BScHxSXksRs8Ok2/W7x1kP0PwSjXne70jr94cqeTJumkkvWbNl6dIJVjLMF
	 Owui0wOiIjCZeuXOBN4TCYX0+Ak+5wL6eOCujXzoR7kElzREkCJKjHIjgg+qzZgrSi
	 nmn83GcCEUqmk6YCCEnt5zCQvYKvT0zDbO09ULn3/W3ukGmc1+nO21rrmI56GZg+iu
	 ZhKRmC1xl3WOw==
Date: Wed, 19 Aug 2026 08:27:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: wqu@suse.com
Subject: [PATCH] generic/800: TEST_DIR, not TEST_MNT
Message-ID: <20260819152726.GA6060@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

Fix this new test regression:

 --- /run/fstests/bin/tests/generic/800.out	2026-08-18 09:30:13.655513087 -0700
 +++ /run/fstests/logs/generic/800.out.bad	2026-08-18 16:30:24.107110215 -0700
 @@ -1,2 +1,4 @@
  QA output created by 800
 +/dio-read-source: Read-only file system
 +dio read failed
  Silence is golden

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/800 |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/800 b/tests/generic/800
index 52a664a17e448b..b79c1a0c052876 100755
--- a/tests/generic/800
+++ b/tests/generic/800
@@ -32,8 +32,8 @@ _cleanup()
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
-# Create the 4MiB target file on TEST_MNT as the read source.
-$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4M" "$TEST_MNT/dio-read-source" >> $seqres.full
+# Create the 4MiB target file on TEST_DIR as the read source.
+$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4M" "$TEST_DIR/dio-read-source" >> $seqres.full
 
 # Another 4MiB target file on SCRATCH_MNT as the mmap dest
 $XFS_IO_PROG -f -c "pwrite 0 4M" "$SCRATCH_MNT/mmap-dest" >> $seqres.full
@@ -42,7 +42,7 @@ read_workload()
 {
 	_register_cleanup "wait"
 	while true; do
-		$here/src/dio-read-into-mmap "$TEST_MNT/dio-read-source" \
+		$here/src/dio-read-into-mmap "$TEST_DIR/dio-read-source" \
 			"$SCRATCH_MNT/mmap-dest" &> /dev/null
 		if [ $? -ne 0 ]; then
 			echo "dio read failed"
