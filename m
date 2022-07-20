Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CEC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 16:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiGTQpH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiGTQoH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 12:44:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F065D69
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 09:44:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KGi1Rl023377
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658335442; bh=AIzu4VJztWwnObEvSYY2SkP2mZUTgzVGm+WQb6YZjAk=;
        h=From:To:Cc:Subject:Date;
        b=nymk8XH06Pv/rpzSRJWIO5kpVhrf9PsKuQ3MUNs/hyMN6Iy1sC0N3fnkN6TnTxMLA
         himjhvifape1zogRolqsBAh4EtTCaVA0UXmLXEXZiCU1qkXOhGlnIbkTjt/kZUTuY3
         m4DPxqOLTtx9c6/3ebfpNpcwY0pqzuSvvQZtpMSW2C9vi5T+avEScId5ei3S5GmZ0z
         VEVsFjn2q+md6Gi1SDoKDdFDI9Vzc9tXyXL3WdxJ4cDcY2ycZFIGhiBRjqWBqMeFL9
         c1lWWG6HKEy5QJ8RbLbWNthClKT8W9RUYM7LmLXnZt1oTO4fRLJgNvfgpX194cS2y4
         9ih81um1hR1uQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 05EE015C3EBF; Wed, 20 Jul 2022 12:44:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] fstests: more random fixes from Ted
Date:   Wed, 20 Jul 2022 12:43:52 -0400
Message-Id: <20220720164356.4078789-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Here are few more hopefully non-controvial patches from my tytso-local
branch on https://github.com/tytso/xfstests.  The xuniit-quet patch
has previously been posted; this has a minor clarification in the
commit description, but is otherwise unchanged from the previous v2
version on the list.

The other fixes fixes some problems found when running tests with an
external log, and to address generic/556 failing on older LTS kernels.

Theodore Ts'o (4):
  report: add support for the xunit-quiet format
  generic/556: add a check to make sure ext4 supports encrypted
    casefolding
  dmflakey: don't run dmflakey tests with an external log device
  generic/475: skip test when using an external log device

 check             |  2 +-
 common/casefold   | 17 +++++++++++++++++
 common/dmflakey   |  4 ++++
 common/report     | 21 ++++++++++++++-------
 tests/generic/475 |  4 ++++
 tests/generic/556 |  1 +
 6 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.31.0

