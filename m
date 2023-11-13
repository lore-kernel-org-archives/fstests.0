Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11672233E
	for <fstests@vger.kernel.org>; Mon, 13 Nov 2023 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlmNY6n1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FE4C433C9;
	Mon, 13 Nov 2023 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699895314;
	bh=bv+9pF24mDlcDR2ATUFkNxwT6YSwOpWYhhRPcNK0Fu4=;
	h=Subject:From:To:Cc:Date:From;
	b=KlmNY6n1MoFRw61dHja+gRFyu6qXoUhb4miLHQvfNJkcp2l5JRPwdfeySRAzb7c2B
	 3DIP8T+PpZl1d622Lcd1Sbxt0FFCfy/zq4eoIFQWM6ktmEa4MV2DVuOBZlawpsj1C3
	 jYgaN9OmO27g0803hdDcueuapT4m6bEos8R3GtxQwLzrtGh2gOJd09a7+qDT41/Fjq
	 xwRcLNtx/8L74xsMC8KjPpHdZ1VZjxxeXlp1iL2Y/7enruN/jTNt1MwAAeAsRc096z
	 W7RXwu7XwnOVMifa5hrx2dgnk1e6zBImI8ctbZVdtfPLEe+DSGSY2dx4Wn+1Lh9CTc
	 mfMVa+ElX1K3w==
Subject: [PATCHSET v2 0/1] fstests: updates for Linux 6.7
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@redhat.com, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
 Catherine Hoang <catherine.hoang@oracle.com>, linux-xfs@vger.kernel.org,
 fstests@vger.kernel.org, guan@eryu.me
Date: Mon, 13 Nov 2023 09:08:34 -0800
Message-ID: <169989531418.1034466.15629933501843921475.stgit@frogsfrogsfrogs>
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
This time around it's merely a functional test for a locking relaxation
in the xfs FICLONE implementation.

v2: implement review suggestions

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
 m4/package_libcdev.m4     |   13 ++
 src/Makefile              |    4 +
 src/t_reflink_read_race.c |  339 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1953        |   75 ++++++++++
 tests/generic/1953.out    |    6 +
 7 files changed, 439 insertions(+)
 create mode 100644 src/t_reflink_read_race.c
 create mode 100755 tests/generic/1953
 create mode 100644 tests/generic/1953.out

