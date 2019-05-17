Received: from mx2.suse.de ([195.135.220.15]:49340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbfEQLY0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 07:24:26 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CE12AC32
        for <fstests@vger.kernel.org>; Fri, 17 May 2019 11:24:25 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/2] Use numeric user and group IDs in getfacl
Date: Fri, 17 May 2019 12:24:20 +0100
Message-Id: <20190517112422.20671-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Hi,

I just saw generic/319 test failing in a system where /etc/group didn't
had the 0 group ID defined.  I guess that's not a common setup, but the
test can easily fixed by having getfacl returning the numeric IDs instead.

Running 'git grep' showed that overlay/023 seems have a similar issue and,
although I didn't tested it, I'm sending the fix for that test as well.

Luis Henriques (2):
  generic/319: use number user and group IDs in getfacl
  overlay/023: use number user and group IDs in getfacl

 tests/generic/319     | 4 ++--
 tests/generic/319.out | 8 ++++----
 tests/overlay/023     | 2 +-
 tests/overlay/023.out | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)
