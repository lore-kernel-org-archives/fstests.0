Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C950AC07
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752761; cv=none; b=dF8pUBhcwrU99dvGbFWYVFRviQ1I0WOCGwob2dVqGxBmuEKB5zO16GXRJ+5YJBw+3YdHKtKgKUWPT3GsJPawGHWnTyT6AF8XglKULntQ0qnbv8K5yWkPPnuHy0CxtDVjnLTWJBrz9jx7URL8Q533hQBb6oMwPualzNuQgucW8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752761; c=relaxed/simple;
	bh=ZWy5O2VAj/0mxauvMdSblYavpAYOOT3bhrExovnJDxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7Zu5Z6QfmkNokEW3JyGc9wFzaBTmL32wLWQG620fW7cVoU73RNeXvsr6hQbrKhMaMXWgwssVTNRZgI3PGbAgej9Id5biHFnx8QVIodil3hOi/FAnDep4GZJ5m0wXWMU9Dh/QDajMttMIpV3HKlfW+u4xNw1OnyJHAH16HRUhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzFHs3qd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzFHs3qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CB91F000FF;
	Fri, 18 Sep 2026 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752752;
	bh=vp0qzREEHmqlF/CULvbNVFPMYFv+tC7d4bQMUfavnpg=;
	h=From:To:Cc:Subject:Date;
	b=CzFHs3qd+00mG5qnJ3nlq4Z/fZqlNaNLQXF8OmpLh+V1qNv2h+cecvwo6yoxTrumK
	 AOQB2vFSYnATQaaXvrk0h92jSLL2ZeDcdceyyr1bQpvA/1as5PM2aQ/ul7hK7LGmQt
	 KG3NTij2vnmDz1QJbUEBrYhG0DjsYngn36cXj3ZaC1CRYhHG3vRFMzi4Q/vjGWLwm1
	 N4q86Iavza0uMLajEunj0JcZBeYBVAXxv0Mo6I4nSj9YTx12N/r/oJ+1KJNENoJorU
	 DF4Zz68ndfchwMtfUil8ZnneG5CLfn3BVIIFs4Y/75WyEJ7GkDM3KksjAvQahU5YFv
	 8ng6hjXCh9FyQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/4] xfstests: random fixes
Date: Fri, 18 Sep 2026 19:32:05 +0200
Message-ID: <20260918173218.1254465-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series contain a few random fixes I apply for xfstests in my
immutable test machines. These make it easier to work with read-only
xfstests package.

Andrey Albershteyn (4):
  xfs/071: use _link_out_link instead of opencoding file picking
  common: link .out file to the output directory
  generic/452: make coping work with multi-call binary
  xfstests: fix permissions on system file installed by libtoolize

 Makefile                                  |  3 +++
 check                                     | 12 ++++++++----
 common/rc                                 |  4 ++--
 tests/generic/452                         |  4 ++--
 tests/generic/452.out                     |  4 ++--
 tests/xfs/071                             |  7 +++----
 tests/xfs/071.cfg                         |  1 +
 tests/xfs/{071.out.64 => 071.out.default} |  0
 8 files changed, 21 insertions(+), 14 deletions(-)
 create mode 100644 tests/xfs/071.cfg
 rename tests/xfs/{071.out.64 => 071.out.default} (100%)

-- 
2.54.0

