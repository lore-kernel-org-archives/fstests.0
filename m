Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DE3812F7
	for <fstests@vger.kernel.org>; Tue, 12 May 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592356; cv=none; b=ehY72MzF1l9rcnhDWd3BWcAzXewbRAdkgEMlBbyW3TleZMspjSQZoVkninOIt1VqP09Zr2NTt8an/hqPKLG9ikuke9t9R1BLf7tNl0LBuLG9gEnbm8VDcw/VUdYI+PjpIlCFnRmBcgQDtY/H/JTwPNrdc/gQcu5FcsSH4sQMSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592356; c=relaxed/simple;
	bh=XxkI1iTCsDMIFYpHbwivSvIpM5fDfs7QDmVBazLrnUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blHSanjv8BtGmNRDk+IP/wgpf0vUM5uLtIvQ9wEJm6oah1hpyd35JyWb6nUpPrUaaBCqkpK9TIaqEHIwZLkZusy9EZmJjELgtGXbjXbbMwa+mI8c+uB4fkTynJZ5G3B4XpzpWFsggx5Pv/K+AOW3Z48kCHWDGxn4FVg2WIlBJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Ighc+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Ighc+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA81C2BD00;
	Tue, 12 May 2026 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592355;
	bh=XxkI1iTCsDMIFYpHbwivSvIpM5fDfs7QDmVBazLrnUI=;
	h=From:To:Cc:Subject:Date:From;
	b=m4Ighc+gzWSBJzPmB5NhOxKH+pdusxYfBtYW7EYAXpjOGERGEOdriBM9iGT2+SBD9
	 p0uH8uzNpA+juRTXojBhjdz51m39ePLe5fz+/XtJ8MamnvI+9ShYxjQ0KpPIeTusb+
	 E7zEELqibcnBB6q7lvATH6OeOHSS7eS6e761sBG99fc/PEYNSIIXp4MsJ52h6vxnfi
	 0sXf4Be8qHtGrvNQC2gF3KAAU+Rp8xRTrmt9MjtoKfH0pQvN0Qy2rRUc2zft0o6IpQ
	 ws72nB+rB14ZGJo+30vroYsNCdvzjSVNQiGmV6OC7ghFqY1wEuxZ3wRfaE+gg9B4sp
	 pIIiFrBA4WWpA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [RFC PATCH 0/4] Rewrite the check argument parsing
Date: Tue, 12 May 2026 21:25:35 +0800
Message-ID: <20260512132539.931482-1-zlang@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Thanks,
Zorro

Zorro Lang (4):
  check: refactor argument parsing with getopt
  check: update usage and README to reflect new argument parsing
  check: consolidate argument handling into function
  check: add deprecated options warning

 README         |  10 +-
 README.overlay |  18 +-
 check          | 435 ++++++++++++++++++++++++++++++++-----------------
 common/config  |   8 +-
 common/rc      |   2 +-
 5 files changed, 303 insertions(+), 170 deletions(-)

-- 
2.54.0

