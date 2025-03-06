Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305820AF67
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254568; cv=none; b=q7VhwD0s6xR81Lpf5YizKOFp05gNuqaYM2Y9lfK9FEvl4L2D/lbOT28YhEpAOsyWaXzNi3J+lpiUpdSAY2YDYKysaqDaA5t1Dh+Z9bRUPNlTJpXKhtra5bsy9ZiyHdD46Q9az/VmCH6zLgbirRCPMCZhQ0ePxbFeNsaQWUTTtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254568; c=relaxed/simple;
	bh=zqfA5Qitpd+p9lpoey6PM9655vdh7QzavNV/0DenD8s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tlF/tk1T1VMmUBvsjzraQVH+GyMDEaSSep91Pj3UsKFbmPZEqSInLRJco9VE95U2uXlaISGHlSUhl5SXrj8dMLu6nh0BW4ffGlgiwEjTShWja7euS6mPg5VGggVaMgZe9VoZJlPbdxoCieaNCcHDqniC0BSVhj14ZZfziwQcPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxcDSsEC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxcDSsEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD9C4CEE0
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254568;
	bh=zqfA5Qitpd+p9lpoey6PM9655vdh7QzavNV/0DenD8s=;
	h=From:To:Subject:Date:From;
	b=BxcDSsECBjWGAP31MfvQL+XXEoZdgqM8ln7HClOtxegO3U23GS8wh/NRLL+aZ+dYC
	 yzH8YMMF4N+g1Z39sdxW1gjmczNnSbYjUUNmFdA8Ze5tlpht7dDUuKn72IQr5PkX9a
	 Wzxx3CGSVYd1gPDZq5ibmT5wl0gaO+8Jnv4Qj2yI/ZyvSmdhgIpssyg4aVV1HwlV5i
	 sHhktJzKer+U2Zev6y8rPfI1dH9zuW1OCSb7vSxgUKLmZWSIpzWyKjyB1AqNYk9DIe
	 4UYAM8ov+nfHhTzCGPUEAFc0pI9KbxciDxBORvhxH0OEkHfPKCIlKowA8u8amF8aTa
	 eyNd0o4frxFfQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH v2 0/2] isolate privatens way
Date: Thu,  6 Mar 2025 17:49:22 +0800
Message-ID: <20250306094924.1353269-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is a workaround for 2 targets:
1) Avoid the regressions of lastest xfstests release.
2) Give us more time to improve the "privatens" method.

And compare with revert that commit directly, this patch trys to
give "privatens" method a chance to be enabled and tested (by
export TRY_PRIVATENS=yes).

V2 uses a separate patch to remove the deprecation.

Thanks,  
Zorro

