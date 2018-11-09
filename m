Received: from newman.cs.utexas.edu ([128.83.139.110]:43623 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGaW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 10 Nov 2018 01:30:22 -0500
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com [209.85.161.51])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id wA9Km3Z0011590
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 9 Nov 2018 14:48:03 -0600
Received: by mail-yw1-f51.google.com with SMTP id l2-v6so2129938ywb.9
        for <fstests@vger.kernel.org>; Fri, 09 Nov 2018 12:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20181105052217.GT6311@dastard> <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org> <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard> <20181108094045.GB6311@dastard>
 <CAHWVdUXSCo1UjGG+TL9SBq5KXOMszVP86E2od1RXqKfcwcYXvA@mail.gmail.com>
 <20181109031205.GC6311@dastard> <CAHWVdUXUtY+e-yuTzwV-E-2kvkg0YeNqxiK01pEJOuLBnWWtAw@mail.gmail.com>
 <20181109191704.GE21078@thunk.org>
In-Reply-To: <20181109191704.GE21078@thunk.org>
From: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Date: Fri, 9 Nov 2018 14:47:51 -0600
Message-ID: <CAHWVdUWk4CcjNkhEo6-8saKY=_UGzJ4-dh4zuJRL7UPjbJQi6g@mail.gmail.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, Jayashree Mohan <jayashree2912@gmail.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 9, 2018 at 1:35 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> How about creating a group "regress", and we can move them into
> tests/regress for better categorization, for regression tests?

"regress" group seems good, we'll send out a patch with that.

> And for tests that attempt find new problems, we already have a group
> "fuzzers"; and perhaps there should be a some standard guieline for
> how long a single invocation of a fuzz test should run before
> quitting.  I'd say something in the 5 to 15 minute range?  People can
> always run the fuzz test multiple times, and if the fuzz test can save
> test between runs, it should matter that it's broken up into multiple
> test invocations.

CrashMonkey doesn't do random tests for every invocation, so its
behavior is a bit different from a fuzzer. But we can definitely
modify CrashMonkey to randomly pick workloads in the target state
space and run for a pre-defined amount of time.
