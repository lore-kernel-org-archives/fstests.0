Received: from newman.cs.utexas.edu ([128.83.139.110]:48905 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbeLBTAW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Dec 2018 14:00:22 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id wB2J0JRQ010621
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Sun, 2 Dec 2018 13:00:20 -0600
Received: by mail-yb1-f169.google.com with SMTP id x144so263737ybg.10
        for <fstests@vger.kernel.org>; Sun, 02 Dec 2018 11:00:19 -0800 (PST)
MIME-Version: 1.0
References: <5c041202.1c69fb81.ce73c.02e7@mx.google.com>
In-Reply-To: <5c041202.1c69fb81.ce73c.02e7@mx.google.com>
From: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Date: Sun, 2 Dec 2018 13:00:06 -0600
Message-ID: <CAHWVdUWCy79-_s2CyPNvoMJ30nhdsXtqyg2PvT7ec6aT=3ZXjg@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to fd532405deaf
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 2, 2018 at 11:10 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. This update mainly pulls in the first piece of the
> CrashMonkey tests from Jayashree Mohan, many thanks to Jayashree for the test
> and to Filipe Manana and others for reviewing and providing review comments!
> The new test currently fails on btrfs, but the fix is pending on btrfs list.

Thank you (and Filipe and others) for working with us patiently as we
submitted our first patch to xfstests! We hope to contribute more
tests in the future.
