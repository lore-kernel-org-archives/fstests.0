Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E225A2BA
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907526; cv=none; b=QAqPKYa+YwU2j2p+GrRyepXExXCoTJ/aD+fCHIpMVlAZPIjkBKoB89KAv1kqruPdClHQfaYiUsctnquoJV8fqrBjuqZpP8Y3H7SkVUoJPBnZtH0/fQ7/B64yBwiV8S0A6NcGHoaNsG8ByHDrYjUupYAiyLEJjZkMaJn7MZrNb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907526; c=relaxed/simple;
	bh=MjEyGyyl7AWswcFK7usJ4ngiXueb/ZAlQKbJoWJUfJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQBd9jQF0wYEloaS00tsiGV2Bi5CO6O0iby3n5DoooT1aDuNYghfWLfaZaprgkQfoDrwmEDVEMmo85sYeOj0RK3kERJs8MHWznBoLguMcp7yx0VXjHsE16evip4xllZMueCtlN+qmhUGbBEr+UsybhGVVsFNQ+Ky4rojFw9UWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btgm8qLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btgm8qLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25095C4CEEF;
	Tue, 25 Mar 2025 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907526;
	bh=MjEyGyyl7AWswcFK7usJ4ngiXueb/ZAlQKbJoWJUfJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Btgm8qLKkZb/zIk2pHCPlr/V+crjFxJoB4Bkp5HYSDmP5/LLlKA34qHmP3cZCYsre
	 qKXWL3dHTVhqYsI1fc0pGXUKajrJAnW7wIyJDQCAS2rU9TXkpVClB54iaOXqx/jD6J
	 RMddRb2nbRsvEOg6F6Fbl8hGVoMfMg3v87jKlYSRsGhL95N93kwjk03/OJ5REFb6CZ
	 3CoEAM64pPh1azcL4Qe3W4rTYp6mmMTj4dGVwVkJUWazmYeEfRfI8hXpNn3sZ6sM3S
	 GVKoRl0/k/nj0Pi5wpvPoL1MugiBFhD7KSFhZZLeI/w2O8RRc9UxFXEFvUqi85Kx7k
	 wAdMgll41nVLw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 3/6] common/config: export F2FS_FSCK_PROG
Date: Tue, 25 Mar 2025 20:58:21 +0800
Message-ID: <20250325125824.3367060-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's export F2FS_FSCK_PROG, then we can use it in
_check_f2fs_filesystem() later.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 7d017a05..79bec87f 100644
--- a/common/config
+++ b/common/config
@@ -317,6 +317,7 @@ export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
 export F2FS_INJECT_PROG=$(type -P inject.f2fs)
+export F2FS_FSCK_PROG=$(type -P fsck.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1

