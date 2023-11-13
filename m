Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B822313
	for <fstests@vger.kernel.org>; Mon, 13 Nov 2023 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsWD2O9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D4C433C7;
	Mon, 13 Nov 2023 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699895299;
	bh=wydyMDTpST19nV+iNla6ZzL5i1b4Gdi3WnmV5mZ0Yj4=;
	h=Subject:From:To:Cc:Date:From;
	b=PsWD2O9foNjBvxliFFx0Nuz0C6SqIpayAbl62mvoxP6Su0NneEtKQarEknuDfzXyc
	 29Umq6icwmsRG4yGNLTJxZ+0QUXkLtfqBT1xxofchnnI4H0xvjqUMOYkJZNvixeEMJ
	 ACIrXxH93XFEEx0VkmYD3elC/962MrfVybba36Cz5po1a4SmnTQv2NU6GMxKdMh755
	 BpwRQRfN50iSSwtqMKuwsjr4o9UXVIaJW6fnVH465yWyYSrJu7Cbn9QIxLNDcMpW+g
	 YcQpv30q5+ieCLmxxaOfZx/cUk8p8mY8i/YQpEgcYV0G5jCpGrrJ4+4BvQ9VlqpaH3
	 PUrULB0KUW+Gw==
Subject: [PATCHSET v4 0/2] fstests: reload entire iunlink lists
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@redhat.com, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
 david@fromorbit.com, fstests@vger.kernel.org, guan@eryu.me
Date: Mon, 13 Nov 2023 09:08:18 -0800
Message-ID: <169989529888.1034375.6695143880673011270.stgit@frogsfrogsfrogs>
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

This is the second part of correcting XFS to reload the incore unlinked
inode list from the ondisk contents.  Whereas part one tackled failures
from regular filesystem calls, this part takes on the problem of needing
to reload the entire incore unlinked inode list on account of somebody
loading an inode that's in the /middle/ of an unlinked list.  This
happens during quotacheck, bulkstat, or even opening a file by handle.

In this case we don't know the length of the list that we're reloading,
so we don't want to create a new unbounded memory load while holding
resources locked.  Instead, we'll target UNTRUSTED iget calls to reload
the entire bucket.

Note that this changes the definition of the incore unlinked inode list
slightly -- i_prev_unlinked == 0 now means "not on the incore list".

v2: rebase to for-next, resend without changes
v3: add necessary prerequisites
v4: fix accidental commit to wrong patch

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fix-iunlink-list

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fix-iunlink-list
---
 common/fuzzy       |    4 -
 common/rc          |   36 ++++++++-
 tests/xfs/1872     |  111 +++++++++++++++++++++++++++
 tests/xfs/1872.out |    5 +
 tests/xfs/1873     |  215 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1873.out |    6 +
 tests/xfs/329      |    4 -
 tests/xfs/434      |    2 
 tests/xfs/435      |    2 
 tests/xfs/436      |    2 
 tests/xfs/444      |    2 
 tests/xfs/516      |    2 
 12 files changed, 381 insertions(+), 10 deletions(-)
 create mode 100755 tests/xfs/1872
 create mode 100644 tests/xfs/1872.out
 create mode 100755 tests/xfs/1873
 create mode 100644 tests/xfs/1873.out

