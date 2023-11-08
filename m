Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F1DF43
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVwxZPzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F4FC433CC;
	Wed,  8 Nov 2023 21:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699479921;
	bh=yGcXQaz+88ExucXh/JZc6d9VqW2YiOC6j2/6v9a+HzY=;
	h=Subject:From:To:Cc:Date:From;
	b=pVwxZPzgKnjFHdUzw6L2CjbeyUxdcK2gL1rm/OPceNO6c8q/Eu/nmcfWij6zBiSEK
	 r1te1y1dr6rVoc1HDkijwe7RA7Zy9cWEY6kAqi0vmndZZHzxqddpEZXTE7W12EdR0I
	 qV8NoeTqmEAX8EpNqPSfIPKoMH54vAVrnVQ3jUdvoombUSfAG/7RHVlYzaWsofzYQY
	 mzZHTlKv5UociUUhd7qpIWDKt+qFVdB4fXa3rhLlT7QMA43jTtB32Y0AA8A8jI2iIE
	 7KwCbfqGFA25WxGcT33S1viXGWDO8L6pH4NgLKThTeRtMAZm0sIb0/ztug09PKESca
	 +ydXtBKYuTD3w==
Subject: [PATCHSET v27.0 0/2] fstests: FIEXCHANGE is now an XFS ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: hch@lst.de, fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
 guan@eryu.me
Date: Wed, 08 Nov 2023 13:45:20 -0800
Message-ID: <169947992096.220003.8427995158013553083.stgit@frogsfrogsfrogs>
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
 m4/package_libcdev.m4 |   19 -------------------
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
 36 files changed, 99 insertions(+), 97 deletions(-)

