Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A14D5AB
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155754; cv=none; b=RAGf8v2/+WH69zN++ej3aJxyEAhFoTmBrOJvbCQjh7g6kHVbXW1YNxTW7GBttNsOdiAhaa+TXhS2IkGysxa7hAuqfyBmYBuUY3GAqwN+R+85lZuTfnDW1bgjJnbk+LgQKmAZALwB4KY/06vgWG16O53UMMUd7HY32CvMzu/hex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155754; c=relaxed/simple;
	bh=OZVixTlvDtXjwmV3i8AGK/lnqyfY0ViFN0ZRgMMfxtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mZeQcEFtA4uEQ+C4eBB7JB3dxlGgozMA+9SGB36Xir1CjvB6YwZbCn8OGkpxqpqxRZzfn4LQLt769BkAgIq7MqpvBJnKFGH7UACk2L/2wUBv4u0OcV8qjGUVb3chJe22ZiSpeHr7sNtJeocPtaGpBaXOWGoMHPPRvqX1XPJDiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+73Aqyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+73Aqyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611E8C433F1;
	Mon,  5 Feb 2024 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155753;
	bh=OZVixTlvDtXjwmV3i8AGK/lnqyfY0ViFN0ZRgMMfxtw=;
	h=Date:From:To:Cc:Subject:From;
	b=r+73AqygiVPZBJ4Ukdd+RSw7o/6Ael6voxBCMK/wk8JgiPSJBnN1QBybpn8Cb/V62
	 9VBPD4POvsVfW+RQLcfxEGqSFqulOM055wk2oZRcMF3VuSbkBOqDEFT5UwXWyi0pyA
	 Gqiku+bKdY2dQZRwHAHOv92KOY3WPvANWBZEaOHcOitZx7PhTIBmTnbycb/qfYKJOS
	 H2aVw7GyQJyu+2b8ldHOVHzFrnK/bxJIOCEhl37oCuPydtZssRAN59QwFX4w4t+Nz/
	 QC6vG3RgiNeKKYnEcccBhDGZGEKvL1/PZaLpEweufIkGhj0vKx/Ab6x6Vrhy6JanM5
	 jb5HsEIjFS7dQ==
Date: Mon, 5 Feb 2024 09:55:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH] common/metadump: fix _cleanup_verify_metadump system
 destructor fleet
Message-ID: <20240205175552.GJ6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

Zorro reported that the cleanup function in common/xfs_metadump_tests
zapped one of his test machines because of a well known shell variable
expansion + globbing footgun.  This can trigger when running fstests on
older configurations where a test adds _cleanup_verify_metadump to the
local _cleanup function but exits before calling _setup_verify_metadump
to set XFS_METADUMP_IMG to a non-empty value.

Redesign the cleanup function to check for non-empty values of
XFS_METADUMP_{FILE,IMG} before proceeding with the rm.  Change the
globbed parameter of "rm -f $XFS_METADUMP_IMG*" to a for loop so that if
the glob does not match any files, the loop variable will be set to a
path that does not resolve anywhere.

Longer term maybe we ought to set -u or something.  Or figure out how to
make the root filesystem readonly when we're running a test.

Reported-by: Zorro Lang <zlang@redhat.com>
Link: https://lore.kernel.org/fstests/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
Fixes: 85c1e0f518 ("common: refactor metadump v1 and v2 tests")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/xfs_metadump_tests |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/common/xfs_metadump_tests b/common/xfs_metadump_tests
index 5a5579b6b9..c8652f16ea 100644
--- a/common/xfs_metadump_tests
+++ b/common/xfs_metadump_tests
@@ -15,12 +15,23 @@ _setup_verify_metadump()
 
 _cleanup_verify_metadump()
 {
+	local img
+
 	_scratch_unmount &>> $seqres.full
 
-	losetup -n -a -O BACK-FILE,NAME | grep "^$XFS_METADUMP_IMG" | while read backing ldev; do
-		losetup -d "$ldev"
-	done
-	rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*
+	test -n "$XFS_METADUMP_FILE" && rm -f "$XFS_METADUMP_FILE"
+
+	if [ -n "$XFS_METADUMP_IMG" ]; then
+		losetup -n -a -O BACK-FILE,NAME | grep "^$XFS_METADUMP_IMG" | while read backing ldev; do
+			losetup -d "$ldev"
+		done
+
+		# Don't call rm directly with a globbed argument here to avoid
+		# issues issues with variable expansions.
+		for img in "$XFS_METADUMP_IMG"*; do
+			test -e "$img" && rm -f "$img"
+		done
+	fi
 }
 
 # Can xfs_metadump snapshot the fs metadata to a v1 metadump file?
