Received: from mail-pg1-f181.google.com ([209.85.215.181]:40830 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISD3p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Sep 2018 23:29:45 -0400
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 18 Sep 2018 16:54:57 -0500
Message-ID: <CAH2r5ms8Z8jU60MpjvG0bYNK4PKAkt55x_-W6WwrseBkYq2cuw@mail.gmail.com>
Subject: xfstest warning on all tests when running with memory debugging in
 kernel config
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Running with kmemdebug on in the kernel config  I get this warning
before and after all non-skipped xfstests

Any idea how to get rid of it?

generic/001 4s ...
./common/rc: line 3491: echo: write error: Device or resource busy
./common/rc: line 3493: echo: write error: Device or resource busy
...

Basically it is doing (which returns an error when debugging enabled
in the kernel).  I am running xfstest as root

echo "scan" > "${DEBUGFS_MNT}/kmemleak"

Ideas?
-- 
Thanks,

Steve
