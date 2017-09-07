Received: from mail-wm0-f46.google.com ([74.125.82.46]:37247 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdIGH0L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 03:26:11 -0400
Received: by mail-wm0-f46.google.com with SMTP id i198so1769334wmf.0
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2017 00:26:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 0/5] fsx additions for crash consistency tests
Date: Thu,  7 Sep 2017 10:26:33 +0300
Message-Id: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,

This is a re-post of v3 fsx patches with a correction to
the 2nd patch which introduces -j <logid>.

Amir.

Amir Goldstein (5):
  fsx: add support for integrity check with dm-log-writes target
  fsx: add optional logid prefix to log messages
  fsx: add support for recording operations to a file
  fsx: add support for writing constant instead of random data
  fsx: add support for keeping existing file

 ltp/fsx.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 214 insertions(+), 60 deletions(-)

-- 
2.7.4

