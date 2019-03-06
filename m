Received: from mail-yw1-f67.google.com ([209.85.161.67]:38452 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFHpH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Mar 2019 02:45:07 -0500
Received: by mail-yw1-f67.google.com with SMTP id o184so9196463ywo.5
        for <fstests@vger.kernel.org>; Tue, 05 Mar 2019 23:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20190305114744.129633-1-yuchao0@huawei.com> <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com> <20190306050049.GA23020@dastard>
In-Reply-To: <20190306050049.GA23020@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Mar 2019 09:44:54 +0200
Message-ID: <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Chao Yu <yuchao0@huawei.com>, fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

> > >
> > > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > > and generic/311.
> > >

Right now 311 is not "quick".
That means adding quick tests to it without breaking it up or declaring it quick
is not a good idea.

> > > Can we please consider rolling all of these "do something, fsync,
> > > drop-writes, remount check" into fsync-tester.c and do the same for
> > > all future one-off "did fsync persist X" tests?
> >
> > Let me add this testcase into fsync-tester.c, still we need add new
> > testcase in generic/ directory instead of changing generic/311 directly,
> > right? since as I remember that Eryu mentioned that:
> >
> > "Usually we don't add new sub-tests to existing tests, so new failures
> > introduced by the new sub-tests won't be treated as false regressions.
> > Please add a new test instead."
>
> Yeah, sure, but there's no point in adding a new fstest for every
> case we move/add to fsync-tester.c - that's no better than what we have
> now. i.e the whole point of using fsync-tester.c is to aggregate
> lots of individual tests full of copy-n-paste dm-flakey
> infrastructure into a single test. Copy-n-paste of fsync tester
> boiler plate is not an improvement.
>
> There are other 'aggregation' style tests in fstests, and we do
> extend them from time to time. Some that come to mind are the
> falloc/fpunch/fzero corner case tests, and we add new functionality
> to fsstress and fsx all the time which affects every test that
> runs them, etc.
>
>
> > https://patchwork.kernel.org/patch/10042149/
> >
> > Or to avoid redundant copied code from generic/311 in each fsync related
> > patch, do I need just add my case into fsync_tester.c? and before
> > announcement of fstests master branch, we can add one testcase into
> > generic/ directory, in that testcase we gather/test all new added cases in
> > fsync_tester.c recently.
>
> Gathering them all into fsync-tester is what I'm suggesting should
> be done....
>

We could introduce the concept of test cases into the test infrastructure.
For example:

--- a/tests/generic/311
+++ b/tests/generic/311
@@ -90,7 +90,7 @@ _mount_flakey
 buffered=0
 direct=1

-for i in $(seq 1 20); do
+for i in $(seq ${TEST_CASE_START:-1} ${TEST_CASE_END:-20}); do
        lockfs=1
        SEED=$i
        echo "Running test $i buffered, normal suspend"
---

Adding a new test cases (beyond changing fsync_tester.c)
requires:
- Creating symlink tests/generic/311:21..24 -> 311
- Writing golden output tests/generic/311:21..24.out

Test infrastructure will parse TEST_CASE_START/END
from test name.

"No regressing tests" rule not broken.
No boiler plate copy of tests.

Thanks,
Amir.
