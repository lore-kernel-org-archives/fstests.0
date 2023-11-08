Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F176374CA
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHRrHcx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFF3C433C7;
	Wed,  8 Nov 2023 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699478948;
	bh=Sq/aYzPT6j+i7p6ITsCC14O95GyOxmkIEUJwxuTT67g=;
	h=Subject:From:To:Cc:Date:From;
	b=sHRrHcx6cfL7slhOKEZ55FwWPttRbgHCMemzWn8p/HeaEF9HxYhQlRtI8rAv2VDeI
	 m0DBUwo9GcTsa+HWEF3UoWOQUpS18hXurMKj63GXyogBXuYtsZnsRVCOJJtwCp2Zid
	 FZf9NpCFa8n8FYZx1YgMbLmMjGCqxNpWSDLqaztJX0Y/fNZshx61B4lpXdaI/sJjf1
	 JZRLHvneK5JWc8eZc2ZyEwvHPmOOYy36DAmHgX7a4FJdgTZd8tgYg8NtGEGZgiZVBl
	 xZk9b/dG+rT1RzEiVyXMVWzCHRoyTM12ogUhimUX0gKf8OXoBntXX7dDzaz6z8B84y
	 b3NdNtuPIz6TQ==
Subject: [PATCHSET v3 0/2] fstests: reload entire iunlink lists
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: guan@eryu.me, david@fromorbit.com, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org
Date: Wed, 08 Nov 2023 13:29:08 -0800
Message-ID: <169947894813.203694.3337426306300447087.stgit@frogsfrogsfrogs>
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
 tests/xfs/1872     |  113 +++++++++++++++++++++++++++
 tests/xfs/1872.out |    5 +
 tests/xfs/1873     |  217 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1873.out |    6 +
 tests/xfs/329      |    4 -
 tests/xfs/434      |    2 
 tests/xfs/435      |    2 
 tests/xfs/436      |    2 
 tests/xfs/444      |    2 
 tests/xfs/516      |    2 
 12 files changed, 385 insertions(+), 10 deletions(-)
 create mode 100755 tests/xfs/1872
 create mode 100644 tests/xfs/1872.out
 create mode 100755 tests/xfs/1873
 create mode 100644 tests/xfs/1873.out

