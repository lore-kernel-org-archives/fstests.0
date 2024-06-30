Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911316B3A3
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845523; cv=none; b=eSLQ/FkzaS+L2mKmt2vhsRArA6FcZ/90aaH4Knh+G5Q3fNtedfkK5K/6ljcsZeM8d69Gz3S+TvYiuHSHvyoUEASYnvSs3GpZn1e5zF5CbX3HigIpskas5uiENZ+ngdBJsQMZ68MWbOuOlUWbvfAJivsbIoQBb4T+BYoYeUQK8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845523; c=relaxed/simple;
	bh=UO+aCQx6URI5GnD+mRUicgGgUdR0otIjO5rPIgpz7iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMpNkng8utlvR16MfkYgwE500wB1vx07iaeMvgQTDd1GOfwyqjKDBNI6Wh/o9T6D97qKuwK/PW9G2WZb0lf5lZaz5ThlDdZ90347PyEdxx+c4hcSEtYg9ymuzry1AD2Z4k6VSBIbFfQ0jQ5GtRk9Ceu/9/IWpOjjDkk2bg6NuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+TDigG8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+TDigG8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 025BCC4AF12;
	Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845523;
	bh=UO+aCQx6URI5GnD+mRUicgGgUdR0otIjO5rPIgpz7iU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z+TDigG8OSQYRLRm8rmhgZBN6atXDAQH1avbXL/5FwZUyeZeBEris3CMeK0zA52D3
	 Cj31pGOXfthf0BHxhHXFQ4IPbL1k2jrtZ3RpTtxvnievuMiI2JOrGTGGPGW9dNCcwf
	 m5b80SBOJwZfJz+G0FYLv5W5eC7a65U0k4U+CcCvs23N2RAFv7cH3HY0UqrDzldOII
	 W7rVSDF6Iw6HKz22euzOw6zyE4e+x+dusNu4230VNVesMugJH1a4pgJksG5NQXnNi1
	 Vo2RwhvAJK/qH8LgVGtkoq7Q0YYg4rgBHROaREmLswv8CdH0gfXqxLkZEI17Rkc78c
	 jHZp31M5aTIdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC9C2BD09;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Sun, 30 Jun 2024 23:52:43 +0200
Subject: [PATCH v2 4/5] common/rc: read config section mount options for
 scratch devs
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
In-Reply-To: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
 mcgrof@kernel.org, gost.dev@samsung.com, 
 Samsung Samsung <"Daniel Gomez d+samsung"@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719784382; l=921;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=MX1imlIj5wPkWMzNR8hoaaX8VaXzFw2Asr5Fz/o5nGY=;
 b=sZz/YXpGLXnqglUBlMLprRd857skhUZFF4h9qsrcaP+g8raHaTR9bt4iBvhYEgIxZCvS59uth
 pkBi6FswA49D0EMaHHpSQBne5q53TZiFolBkHIWsIRNf5foPlcuI5lx
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

MOUNT_OPTIONS for scratch devices do not have specific fs mount options
values (such as TMPFS_MOUNT_OPTIONS) from the config section. So, allow
the scratch mount options to inherit section config values by reading
them from _common_mount_opts().

Move $* to the end so scratch device can be umount/mount. Otherwise, we
end up with multiple mounts in the same scratch directory.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 51827119c..627dbaaaa 100644
--- a/common/rc
+++ b/common/rc
@@ -231,8 +231,8 @@ _scratch_mount_options()
 {
 	_scratch_options mount
 
-	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
-					$SCRATCH_DEV $SCRATCH_MNT
+	echo `_common_mount_opts` $SCRATCH_OPTIONS \
+					$SCRATCH_DEV $SCRATCH_MNT $*
 }
 
 _supports_filetype()

-- 
2.43.0


