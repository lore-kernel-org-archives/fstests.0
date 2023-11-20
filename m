Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051436AE5
	for <fstests@vger.kernel.org>; Mon, 20 Nov 2023 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDOCzXBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5092FC433C7;
	Mon, 20 Nov 2023 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700508909;
	bh=z5t+NDwY5/kJc2KrzYF7jl+E61eWwxJU1dAPnD0f9mk=;
	h=Subject:From:To:Cc:Date:From;
	b=ZDOCzXBTOFH3QqXejTYEJcdu33/qd5GMCVmsSFbM0VsrgnNP6YlPFohFA2DwVj9Ln
	 SeAA1v00ACK46FyHriRn3nRdCs5Vy354syrcQ9n7lfOijzOUKdOi9HDUzhA1saAkIL
	 9yHCI6EhUr6kg72Jj9Uj5MH7SfPYMftePvSjShtC6g/kbkzLhEhZHxIsNFv34b9Uu7
	 LdWiUWG59Wl8NIKxQ565Gv2FeSuEi16pL/tW3lmnkQXsLqcFeCuIldKwDDLaukIfmO
	 uv6A/xjV4kvwP/Br7H6src4cxjqjYtnBTI+QqFWMgmVW2OyjMoy/MUjsPNse5DzR4c
	 jOBaOuRReoZjA==
Subject: [PATCHSET 0/2] fstests: random fixes for v2023.11.19
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: linux-xfs@vger.kernel.org, guan@eryu.me, fstests@vger.kernel.org
Date: Mon, 20 Nov 2023 11:35:08 -0800
Message-ID: <170050890870.536459.4420904342934916414.stgit@frogsfrogsfrogs>
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

Here's the usual odd fixes for fstests.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=random-fixes

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=random-fixes

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=random-fixes
---
 tests/generic/734     |    3 ++-
 tests/generic/734.out |    2 +-
 tests/xfs/604         |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)
 rename tests/{xfs/601 => generic/734} (98%)
 rename tests/{xfs/601.out => generic/734.out} (78%)

