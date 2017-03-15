Received: from mail-io0-f176.google.com ([209.85.223.176]:36771 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdCOBZV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2017 21:25:21 -0400
Received: by mail-io0-f176.google.com with SMTP id l7so11169502ioe.3
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2017 18:25:20 -0700 (PDT)
MIME-Version: 1.0
From: John Groves <John@groves.net>
Date: Tue, 14 Mar 2017 20:24:58 -0500
Message-ID: <CALz7SpVTJVxZQ0fu-6wWBzXsccNyhndHW52y7E4MoLf6zN5_3Q@mail.gmail.com>
Subject: TEST_DEV
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I'm bringing up a prototype file system under fuse, and I'm new to
xfstests but trying to use it.  My questions are noob-ish (in xfstest
context), and I'm happy to rtfm.

My current fuse fs has xfs has a backing file system, plus some
features that don't come from xfs (backing could just as well be ext4,
but I don't want fstests to white-box test it as something it's not).

When I set TEST_DEV=/dev/vdb (where xfs is), many tests run; but can
xfstests run with no TEST_DEV, or a TEST_DEV that points to something
that it doesn't recognize (and isn't in /proc/mounts)?

I want to test my file system as a black box, for correct behavior.
Can I do that? (regardless of whether TEST_DEV is involved.)

Any tips or pointers appreciated.

Thanks,
John Groves
