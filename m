Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE71374CA
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAQN0cED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC436C433C9;
	Wed,  8 Nov 2023 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699478963;
	bh=lqdUq1BT0SiiIXlHKNFMwHYoDoCphfCt83UQy6yVFdA=;
	h=Subject:From:To:Cc:Date:From;
	b=TAQN0cED5xfGFg1JYqt20cN382cmK5NjPtF4XSfdL6/oaU/SHGIOHhCFO+uQwqqQZ
	 hVKREs+/IGmRtdDVFBhnYXXk8OXpKLEsIpyNqE3roRxwZQR4wwVJPnRgEdayIMNyq/
	 zBLeauWuBQ+v5Qyai6lzSgeG6lvdEj988c7FdvwgQSogUHkOabJZ34nfxp28maOarW
	 xfLyFSrq++CpADNP+mwPSnEyJNWN9OQowQu8RcbIcYk5hbeZ4KLi3AoyjO9f09t6XO
	 ByDOTBbrhWUfSiB2bnNbmW9VtckpgkeeVn6k4569qlulKhQH7sUGVMr4VVeXCDgYWT
	 xMKCrHFRlyOiQ==
Subject: [PATCHSET 0/1] fstests: updates for Linux 6.7
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: Christoph Hellwig <hch@lst.de>,
 Catherine Hoang <catherine.hoang@oracle.com>, guan@eryu.me,
 fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Date: Wed, 08 Nov 2023 13:29:23 -0800
Message-ID: <169947896328.203781.17647180888752123384.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is pending fixes for things that are going to get merged in 6.7.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=xfs-merge-6.7

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=xfs-merge-6.7
---
 configure.ac              |    1 
 include/builddefs.in      |    1 
 m4/package_libcdev.m4     |   12 ++
 src/Makefile              |    4 +
 src/t_reflink_read_race.c |  339 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1953        |   74 ++++++++++
 tests/generic/1953.out    |    6 +
 7 files changed, 437 insertions(+)
 create mode 100644 src/t_reflink_read_race.c
 create mode 100755 tests/generic/1953
 create mode 100644 tests/generic/1953.out

