Received: from mx1.redhat.com ([209.132.183.28]:46050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbfB1Ol3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Feb 2019 09:41:29 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 0/2] fstests: prevent dm-log-writes out of order replay issues
Date: Thu, 28 Feb 2019 09:41:26 -0500
Message-Id: <20190228144128.55583-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

Here's a stab at addressing the out-of-order write issues reproduced by
generic/482 on XFS v5 filesystems. Patch 1 refactors the code to allow
for use of an arbitrary device and patch 2 fixes up generic/482 to use a
thinly provisioned replay device.

This could be factored in different ways and/or be implemented across
the other tests, but the focus here is on generic/482.

Brian

Brian Foster (2):
  common/dmlogwrites: genericize log writes target device
  generic/482: use thin volume as data device

 common/dmlogwrites | 24 ++++++++++++++++++------
 tests/generic/455  |  8 ++++----
 tests/generic/457  |  8 ++++----
 tests/generic/470  |  4 ++--
 tests/generic/482  | 20 ++++++++++++++------
 5 files changed, 42 insertions(+), 22 deletions(-)

-- 
2.17.2
