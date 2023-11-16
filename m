Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759F341BB
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMaAXho6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47201C433C8;
	Thu, 16 Nov 2023 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700155832;
	bh=hK9n+5IEXIzvqFK2so19votrvVnEE8T2XLLkdRWlfIw=;
	h=Subject:From:To:Cc:Date:From;
	b=BMaAXho63yZBTSesl3m2H1rb66k9C/uGZQqJ+LGT4TNTJDQm0jHA706X+AebZQUOa
	 ZeQWdajIbOW89oyAp4M2vIXClgIUm5P8dasr5j6RLq3tuy73cZccwcxaTWetf+RL97
	 AhLtEoQI3UoL4uFbkm4SmLOsB0tj0dZvTP5/uIe87moUL5VdexIj2HOAj4Xx5dpRlh
	 aOVCUvOCIekoyMv434IOdowxc/R/3+neoOrNwvx4tj6bEh8xTPt0FTN/ygDspwI6LK
	 zwT7Hi5LsHYzoWDIOKPDTaXzQhfggelfwz99G8vpgqpvBcuCPCVNiMwjpcO51hSOYd
	 AXWLRGTins2Tw==
Subject: [PATCHSET v27.1 0/2] fstests: FIEXCHANGE is now an XFS ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@redhat.com, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org
Date: Thu, 16 Nov 2023 09:30:31 -0800
Message-ID: <170015583180.3369423.8659956273233504193.stgit@frogsfrogsfrogs>
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

Minor amendments to the fstests code now that we've taken FIEXCHANGE
private to XFS.

v27.1: add hch review tags; rebase and maybe fix merge problems?

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=private-fiexchange
---
 common/xfs            |    2 +-
 configure.ac          |    2 +-
 doc/group-names.txt   |    2 +-
 include/builddefs.in  |    2 +-
 ltp/Makefile          |    4 ++--
 ltp/fsstress.c        |   10 +++++-----
 ltp/fsx.c             |   20 ++++++++++----------
 m4/package_libcdev.m4 |   20 --------------------
 m4/package_xfslibs.m4 |   14 ++++++++++++++
 src/Makefile          |    4 ++++
 src/fiexchange.h      |   44 ++++++++++++++++++++++----------------------
 src/global.h          |    4 +---
 src/vfs/Makefile      |    4 ++++
 tests/generic/709     |    2 +-
 tests/generic/710     |    2 +-
 tests/generic/711     |    2 +-
 tests/generic/712     |    2 +-
 tests/generic/713     |    4 ++--
 tests/generic/714     |    4 ++--
 tests/generic/715     |    4 ++--
 tests/generic/716     |    2 +-
 tests/generic/717     |    2 +-
 tests/generic/718     |    2 +-
 tests/generic/719     |    2 +-
 tests/generic/720     |    2 +-
 tests/generic/722     |    4 ++--
 tests/generic/723     |    6 +++---
 tests/generic/724     |    6 +++---
 tests/generic/725     |    2 +-
 tests/generic/726     |    2 +-
 tests/generic/727     |    2 +-
 tests/xfs/122.out     |    1 +
 tests/xfs/789         |    2 +-
 tests/xfs/790         |    2 +-
 tests/xfs/791         |    6 +++---
 tests/xfs/792         |    2 +-
 36 files changed, 99 insertions(+), 98 deletions(-)

