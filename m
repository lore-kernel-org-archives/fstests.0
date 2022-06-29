Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14326C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiF2MwQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiF2MwQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:52:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26914369DF
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:52:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCq8FV026771
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656507129; bh=/PJ64JywK2GP0tAdhkBbAMbaL3T0Cz5N8OzFPebYGmw=;
        h=From:To:Cc:Subject:Date;
        b=bQE02/nEFwtxp5Tvo6WIZ6MPdRQhz603AbpYqbEzg72BnOprdetdbRtUHKo9RhWzW
         O9sh1tUowokFD6o+UAIMSpqnQmycSrp4oOz7gqdyKfXSJ99wORWWXLQajSo7mWMIJQ
         mMl6nW124GkxPCT2ASXyFiyqsotCf7hvkptW+7BtHoFeJVgh11LyDrd111QNk3ssST
         Q8kMIHJFkdaE8sU5+XNrTg5mwbndnuRI1yt+blxSOquBrW0pGyNUEZghabu5j7bMTF
         DxPdFh/vwZDIGcHUbNStsDf/F+gPG+iAkohyuXrUt56eRpvD0415q/cJ6OVvCU6pUz
         gaTz+1f4IF11Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6154E15C3E94; Wed, 29 Jun 2022 08:52:08 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/2] xfs test excluses needed for realtime_28k_logdev
Date:   Wed, 29 Jun 2022 08:52:05 -0400
Message-Id: <20220629125207.176710-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These are tests in my out-of-tree patches to xfstests, which were
cherry-picked from Darrick's out-of-tree patches.  They are needed to
prevent a huge whackload (that's a technical term) of test failures in
the xfs/realtime_28k_logdev test config, which uses:

XFS_MKFS_OPTIONS='-d rtinherit=1 -m reflink=0,rmapbt=0 -r extsize=28k '

and uses an external logdevice as well as an external realtime device.

This test config is being used in the xfs 5.15 backports testing,
since it's one of Darrick's upstream acceptance test configs.

Darrick, any objections if I ask Zorro to consider these for upstream
xfstests?

Darrick J. Wong (2):
  misc: skip remap/fallocate tests when op length not congruent with
    file allocation unit
  misc: skip extent size hint tests when hint not congruent with file
    allocation unit

 common/rc         | 16 ++++++++++++++++
 tests/generic/031 |  1 +
 tests/generic/116 |  1 +
 tests/generic/118 |  1 +
 tests/generic/119 |  1 +
 tests/generic/121 |  1 +
 tests/generic/122 |  1 +
 tests/generic/134 |  1 +
 tests/generic/136 |  1 +
 tests/generic/137 |  1 +
 tests/generic/144 |  1 +
 tests/generic/149 |  1 +
 tests/generic/162 |  1 +
 tests/generic/163 |  1 +
 tests/generic/164 |  1 +
 tests/generic/165 |  1 +
 tests/generic/168 |  1 +
 tests/generic/170 |  1 +
 tests/generic/181 |  1 +
 tests/generic/183 |  1 +
 tests/generic/185 |  1 +
 tests/generic/186 |  1 +
 tests/generic/187 |  1 +
 tests/generic/188 |  1 +
 tests/generic/189 |  1 +
 tests/generic/190 |  1 +
 tests/generic/191 |  1 +
 tests/generic/194 |  1 +
 tests/generic/195 |  1 +
 tests/generic/196 |  1 +
 tests/generic/197 |  1 +
 tests/generic/199 |  1 +
 tests/generic/200 |  1 +
 tests/generic/201 |  1 +
 tests/generic/284 |  1 +
 tests/generic/287 |  1 +
 tests/generic/289 |  1 +
 tests/generic/290 |  1 +
 tests/generic/291 |  1 +
 tests/generic/292 |  1 +
 tests/generic/293 |  1 +
 tests/generic/295 |  1 +
 tests/generic/352 |  1 +
 tests/generic/358 |  1 +
 tests/generic/359 |  1 +
 tests/generic/372 |  1 +
 tests/generic/414 |  1 +
 tests/generic/501 |  1 +
 tests/generic/515 |  1 +
 tests/generic/516 |  1 +
 tests/generic/540 |  1 +
 tests/generic/541 |  1 +
 tests/generic/542 |  1 +
 tests/generic/543 |  1 +
 tests/generic/544 |  1 +
 tests/generic/546 |  1 +
 tests/generic/578 |  1 +
 tests/generic/588 |  2 ++
 tests/xfs/069     |  1 +
 tests/xfs/180     |  1 +
 tests/xfs/182     |  1 +
 tests/xfs/184     |  1 +
 tests/xfs/192     |  1 +
 tests/xfs/193     |  1 +
 tests/xfs/198     |  1 +
 tests/xfs/200     |  1 +
 tests/xfs/204     |  1 +
 tests/xfs/208     |  1 +
 tests/xfs/209     |  1 +
 tests/xfs/210     |  1 +
 tests/xfs/211     |  1 +
 tests/xfs/212     |  1 +
 tests/xfs/215     |  1 +
 tests/xfs/218     |  1 +
 tests/xfs/219     |  1 +
 tests/xfs/221     |  1 +
 tests/xfs/223     |  1 +
 tests/xfs/224     |  1 +
 tests/xfs/225     |  1 +
 tests/xfs/226     |  1 +
 tests/xfs/228     |  1 +
 tests/xfs/230     |  1 +
 tests/xfs/231     |  1 +
 tests/xfs/232     |  1 +
 tests/xfs/237     |  1 +
 tests/xfs/239     |  1 +
 tests/xfs/240     |  1 +
 tests/xfs/241     |  1 +
 tests/xfs/248     |  1 +
 tests/xfs/249     |  1 +
 tests/xfs/251     |  1 +
 tests/xfs/254     |  1 +
 tests/xfs/255     |  1 +
 tests/xfs/256     |  1 +
 tests/xfs/257     |  1 +
 tests/xfs/258     |  1 +
 tests/xfs/280     |  1 +
 tests/xfs/312     |  1 +
 tests/xfs/315     |  1 +
 tests/xfs/322     |  1 +
 tests/xfs/326     |  1 +
 tests/xfs/329     |  1 +
 tests/xfs/346     |  1 +
 tests/xfs/347     |  1 +
 tests/xfs/436     |  1 +
 tests/xfs/507     |  3 +++
 106 files changed, 124 insertions(+)

-- 
2.31.0

