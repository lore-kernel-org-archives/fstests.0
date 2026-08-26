Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33B3B811F
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740151; cv=none; b=Rzjbvd8ADlZ8B2Lk/5Xa4K1xBsJ2keH0Ae5gftn6Pn/Oo8WNxsqqOe7Iwh6Pb2QbY1es2gFdW0hnSAcGY5PIt/q6w97NWhNmDT5SRYLsiE1u6/vNht65wBe9nWkg78pR0ZRhZx2kgIyjyyjaXoDKNfVhCQPod0PNNF9VyL84WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740151; c=relaxed/simple;
	bh=fUtt4NAA2V0pQsl4bj8QcvVlmBeQgnRl8pT/yh2jsTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpPxUaHq9JLYrAIRkTqPmN7iGNenkzT5l40Ywfvpzu5zx0W93tWA5RGcDUP0+m3UgoY9sB8GTsYScSLv1gzG9OHHjODc/oY06uvKBCygSpEMsC/wRvODO6c+1ZLY7Jp7rRxvQOfoNea761qTj+d+984I1LkaMzbOsioDmCz8qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIDvvfpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIDvvfpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62C1F000E9;
	Wed, 26 Aug 2026 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740150;
	bh=i1Za59lrNUceXxx7VcdfVcwLLrar87i/4+KajxjVUvU=;
	h=From:To:Cc:Subject:Date;
	b=EIDvvfpyEke6NYjG/kiWQGKYoupRnRfXy2GJ+ZUbv0DJ6fiCkbZLxmDTIf6Iv0SYP
	 fazxtv7cguat9XtB4mk8OR/iDv2P1XgQ0+GXcSPAU7vwYr9mCGk6xkY4KQ27s23Ame
	 C2GMiFwh9g2c61rAZyW87zzt9fNN9GXRyfpGD1aK8g8joREHbqO5IlH7xuvHAJEdEA
	 ZeARl90uIo53kz+S9HZhOTccJIZPvJ0+cWakOeM5j/gz3l5cCOQm9jBElW0dXcibHY
	 lsEvQTZ6K/1b5mKjEJmHmYFIQDjrl5/+Lpm2EKcfMZfw4W4olYyMYt+jNQChruhbaM
	 HiKN22waTAljA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 0/4] Rewrite the check argument parsing
Date: Wed, 26 Aug 2026 18:28:53 +0800
Message-ID: <20260826102857.3224318-1-zlang@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset here were motivated by a previous RFC discussion regarding:
https://lore.kernel.org/fstests/afzmt7SFA4jWhi6U@zlang-mailbox/T/#t

This patchset refactors the argument parsing logic in the 'check' script.
The current positional parameter handling is becoming hard to maintain as
we add more options.

I've replaced the manual parsing loop with *getopt* to provide a more
standard CLI experience, and ensured the functionality remains identical
to the previous implementation.

Besides that, I also tried to make below 3 changes:
1) Introduced --fs <fstyp> option, to replace all those filesystem-specific
   options, e.g. -nfs, -overlay, -cifs and so on.
2) Updated all long-format options to strictly use the double-dash (--) prefix.
3) For backward compatibility, I tried to support legacy non-standard options
   to ensure existing user workflows aren't broken. A deprecation warning is
   now issued when these old options are used.

I hope this patchset can facilitate future additions and adjustments to
arguments, making the code logic cleaner and more standardized.

Any concerns or review points, please feel free to tell me :)

P.S. last RFC version:
https://lore.kernel.org/fstests/an3ir0ZLiV260AFu@zlang-mailbox/T/#t

Thanks,
Zorro

Zorro Lang (4):
  check: refactor argument parsing with getopt
  check: update usage and README to reflect new argument parsing
  check: consolidate argument handling into function
  check: add deprecated options warning

 README         |  10 +-
 README.overlay |  18 +-
 check          | 440 ++++++++++++++++++++++++++++++++-----------------
 common/config  |   8 +-
 common/rc      |   2 +-
 5 files changed, 308 insertions(+), 170 deletions(-)

-- 
2.55.0

