Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8825A2AC
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907526; cv=none; b=EYL/HJN1QCAeFbOZotMh2fqMuQHYSj6bRIY3TehvdbRKSQ12ZSR1cEmnIdV5iLT0qfsydPOFjCVzWOILo+lFzcfSu5LEC+Zq8rtlWMZ2HZ+sNlG3hhjVBJQebE4w1JF3hQn3g+FZBpUrs88d4tH23NK8cZUSf+cb6xxslajwYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907526; c=relaxed/simple;
	bh=5VTc25eco32/jJpLDGVrxDEmip6J9yQmzC0ntM+IaW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b96j3G4JKoS+3KxQpuJX+ad01JtUBpNgf8gBMXoUfe7dmvO6EMe1pxEh+GwTWnU8oBMeXDQDxDTWdUBRZR3KrYhFpRq2iaCGCwft4hrA10i9AqNK3C71HrnhW50bxDcmprIHB/ib1B/2FxfPo8o03wOYPnGR+rXVEtvCfsBzHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KomJ+VR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KomJ+VR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4798BC4CEED;
	Tue, 25 Mar 2025 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907524;
	bh=5VTc25eco32/jJpLDGVrxDEmip6J9yQmzC0ntM+IaW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KomJ+VR+P1yXuLnJB++XCYLC0x3Xa0BhnyumNnCUyl4rCDC3J4yyYcBnxEs3IYadb
	 2KXCOUUPUklnglYzk9u36kGbQT06i6iihgy+ja2t/zMResmuH30168jBn+xS5arWn8
	 U3tuwinI8bMaH6NWRiJvQI+yy3x8a2xrTtgCYyZ4rC1hXF3AeTgVZ/uVrmj6oq0Aa3
	 a6kIjTUaXN5ZusHC7ktP2uFzpciHOfA5FLeizq+t1DADqdWKQlDnk8Zwr//Hift9lG
	 zwd6Otlt5SHftBEd5KFFDLR3SnCkfXkIuo2v4mzVvibw291qSDip1uexfNH6+Lc0yy
	 onLjQGaL4Qw5g==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 2/6] common/config: export F2FS_INJECT_PROG
Date: Tue, 25 Mar 2025 20:58:20 +0800
Message-ID: <20250325125824.3367060-2-chao@kernel.org>
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

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index aa525825..7d017a05 100644
--- a/common/config
+++ b/common/config
@@ -316,6 +316,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
+export F2FS_INJECT_PROG=$(type -P inject.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1

