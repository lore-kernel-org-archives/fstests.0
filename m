Received: from newman.cs.utexas.edu ([128.83.139.110]:40197 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfAPRra (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jan 2019 12:47:30 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id x0GHXmTY038227
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Wed, 16 Jan 2019 11:33:48 -0600
Received: by mail-ot1-f50.google.com with SMTP id f18so8428525otl.11
        for <fstests@vger.kernel.org>; Wed, 16 Jan 2019 09:33:48 -0800 (PST)
MIME-Version: 1.0
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com> <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
In-Reply-To: <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
From: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Date: Wed, 16 Jan 2019 11:33:37 -0600
Message-ID: <CAHWVdUV-oy9s=LteB_DfbZjAMenjDeaBqJqWf0v2cyNfP2G2rg@mail.gmail.com>
Subject: Re: Any way to detect performance in a test case?
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

> I mean if it's possible for a test case to just fail when hitting some
> big performance regression.
>
> E.g. one operation should finish in 30s, but when it takes over 300s,
> it's definitely a big regression.
>
> But considering how many different hardware/VM the test may be run on,
> I'm not really confident if this is possible.

It is a lot of work, but one-setup-agnostic way of doing this is the following:
- Run test with some older version that is known to be correct/stable,
measure time
- Run test with latest version, measure time
- If newer version is 2x (or some configurable threshold) slower than
old version, warn developer

Since both old and new versions are being run on the same setup, we
don't have to worry about hardware or setup differences.
