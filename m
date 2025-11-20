Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2D22257E
	for <fstests@vger.kernel.org>; Thu, 20 Nov 2025 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680537; cv=none; b=Us0Hmg74XE9vclFXEd1cPrts3qBO0KvxI2tP4szE2Up3S+/esPpbuVMEVNPEsw1bl0/oy2aUSlRRd1OSAdUl4xw1RVLx3FI7iUxuGBzA9ujkU4YWGfe4UV4PwgwI4kcngasKw2QRU8KdMMM1RDiZzs/JEYMd0Om4eESvEQQ0dQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680537; c=relaxed/simple;
	bh=lc7M/JeNaHxtkGdbFvzPrKB17fborAkUNGKx8myI8M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me6E5Rtt/27u8WE7xW3Uml2VH4+HdgHC+WnY/gR1813NSq9OZgBrQ5v/CIX/EAHJ+RTBY0u1+ojtJp+Ymq8aEL9iXl7LIPYFr7sYX1mLnSulw3lf8dOFmJP1Ei9okaSdWh8DgmZfYJC5DtEzdbz9CeK5zUH/BPUz/9d0DMenI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUXaBaOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUXaBaOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B83C4CEF1;
	Thu, 20 Nov 2025 23:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763680536;
	bh=lc7M/JeNaHxtkGdbFvzPrKB17fborAkUNGKx8myI8M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUXaBaOrICxY17+Uz/YJPnuvoL7EZnwZid15KSoiSTNva9nZXf65K1wgoZUbDxFDb
	 DKbFuFWIfyaPhu/DVqfxh7jrUM+MTXdrnlLQkMqgxWezwvQT4HoAyaMsGi1eVJiUVM
	 rr/Na/W28pENtjukJAcLBtlysShIpsaUF88TOmSRIjKdmGy1uN0a4zNNbpyFJiB3kZ
	 /BggerJy1kS+uJ9RKPvAgPTQTrHQ/AqRa0CFdJeJ0uBgbWMh+DbORYHUhFDlzVKu0f
	 yoCMHegTaQAqLUdKzulTZF2ywB2qcjfO+6Pp8cW3L8zX/prvd4x/dOzCwUasSUAzZ0
	 z2b+NcRh6f+FQ==
Date: Thu, 20 Nov 2025 15:15:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] common/rc: fix _xfs_is_realtime_file for internal rt devices
Message-ID: <20251120231536.GK196366@frogsfrogsfrogs>
References: <20251120160901.63810-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120160901.63810-1-cem@kernel.org>

From: Darrick J. Wong <djwong@kernel.org>

Now that we can have internal realtime devices, it's possible to have a
realtime filesystem without setting USE_EXTERNAL=yes or SCRATCH_RTDEV.
Use the existing _xfs_has_feature helper to figure out if the given path
points to a filesystem with an online realtime volume.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/xfs |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/xfs b/common/xfs
index ffdb82e6c970ba..8b1b87413659ad 100644
--- a/common/xfs
+++ b/common/xfs
@@ -253,9 +253,9 @@ _xfs_get_dir_blocksize()
 # Decide if this path is a file on the realtime device
 _xfs_is_realtime_file()
 {
-	if [ "$USE_EXTERNAL" != "yes" ] || [ -z "$SCRATCH_RTDEV" ]; then
-		return 1
-	fi
+	local mntpt="$(findmnt --target "$1" --noheadings --output TARGET)"
+
+	_xfs_has_feature $mntpt realtime || return 1
 	$XFS_IO_PROG -c 'stat -v' "$1" | grep -q -w realtime
 }
 
