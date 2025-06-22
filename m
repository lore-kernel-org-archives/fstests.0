Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331E1EFF8E
	for <fstests@vger.kernel.org>; Sun, 22 Jun 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624792; cv=none; b=KI78pwNrmywU11hHfqqXVFi8gi2ijustXr8EUEg5d5Tn9rOIJFBP9fKtVM1FlEGrEtSk3woNKDH3L2LiCNDbZq9AmZaYv+lp6hmu4/rF9NSx2Jc9vfD2oTDd8DTpXUi2NwSVnVDohi40I0rahVGLtNY0alZN0CAHqd14QLQPfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624792; c=relaxed/simple;
	bh=bs8nKyDHNK1CM+QQD74GERyOUD/Hr5ZYS9KDi3QHKcs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoYA9yVNvwcHKseybjewRjSENU+9DGk3Pbc4ceQtakRVEqZZUGbx+z4x2wd6zFZBXWLCGSOG5Ri7mkslCEL4sXQrNTV2bIN6DU3Q6CGB/fgatF2cD7ByvSGYxpkU/CprdVFYH/aH9Rwf2T8krYd2mBkntQTmuINS5F/WVXPIMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSL0F0zg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSL0F0zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94BDC4CEF2
	for <fstests@vger.kernel.org>; Sun, 22 Jun 2025 20:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750624791;
	bh=bs8nKyDHNK1CM+QQD74GERyOUD/Hr5ZYS9KDi3QHKcs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TSL0F0zgu6W1j/B8j4LEQtCjlLXPMqlkGYPYKlvqkNgHgrJd6ss+0W2GrfQicxXNE
	 yZSuFMLBJw1nF+erHeBLHCpb319u3TilcDMXkdKMSEJggjiwmlf0Va7a8fBAIrG9a+
	 l2Wnn1oqZGDT2Z2jWS7A5QTSN/z0XRG69PUbDzYBI+ToJT6eTSf9AVDPYXUS0GpIRA
	 M5f2EzP4QSr+zO7T0bxYYNtIOVRKJnNtOy7dsXoHjRAffNei5AnnPgn3/USA+rgsic
	 EYscdM/KV6bO9b37o0IW/TOkHVS0CUCPZwBQ7fIIBCYxahOn3AFmnHSxTSVLb7Rd2t
	 MKMJ1HaCpS4uA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH 2/2] common/rc: _add_dmesg_filter returns when RESULT_DIR is null
Date: Mon, 23 Jun 2025 04:39:47 +0800
Message-ID: <20250622203947.797199-2-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250622203947.797199-1-zlang@kernel.org>
References: <20250622203947.797199-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I always hit below error on a system with readonly rootfs:

  ++ _xfs_prepare_for_eio_shutdown /dev/loop0
  ...
  ++ _add_dmesg_filter 'Internal error'
  ++ local 'regexp=Internal error'
  ++ local filter_file=/dmesg_filter
  ++ '[' '!' -e /dmesg_filter ']'
  ++ echo 'Internal error'
  ./common/rc: line 4716: /dmesg_filter: Read-only file system

The RESULT_DIR is null, due to xfstests/check calls _test_mount and
_scratch_mount before RESULT_DIR creation. And _test_mount does
_prepare_for_eio_shutdown -> _xfs_prepare_for_eio_shutdown ->
_add_dmesg_filter "Internal error" when RESULT_DIR is null.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index a27f87a0b..549f42135 100644
--- a/common/rc
+++ b/common/rc
@@ -4800,6 +4800,12 @@ _check_dmesg_filter()
 # Add a simple expression to the default dmesg filter
 _add_dmesg_filter()
 {
+	# This function might be called before having RESULT_DIR, do nothing
+	# if RESULT_DIR isn't created
+	if [ ! -d "${RESULT_DIR}" ];then
+		return 1
+	fi
+
 	local regexp="$1"
 	local filter_file="${RESULT_DIR}/dmesg_filter"
 
-- 
2.47.1

