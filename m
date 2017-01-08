Received: from mail-oi0-f44.google.com ([209.85.218.44]:33234 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030891AbdAHNGu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Jan 2017 08:06:50 -0500
Received: by mail-oi0-f44.google.com with SMTP id 128so469714430oig.0
        for <fstests@vger.kernel.org>; Sun, 08 Jan 2017 05:06:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170106034507.5915-1-eguan@redhat.com>
References: <20170106034507.5915-1-eguan@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 8 Jan 2017 15:06:49 +0200
Message-ID: <CAOQ4uxgPOKc=qUyTfKW1g-uwCrfxYHwE3NSwNY3R=0Tj-LpSPw@mail.gmail.com>
Subject: Re: [PATCH] fstests: cleanup tmp files in tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 6, 2017 at 5:45 AM, Eryu Guan <eguan@redhat.com> wrote:
> $tmp.* files should be removed in _cleanup() even if the test is not
> using any $tmp.* file explicitly, because common helper functions
> may take use of them too.
>
> So cleanup tmp files properly in tests, and add a _cleanup()
> function and trap it on exit if the test doesn't do so, to make all
> tests consistent on the way they do cleanup.
>
> Also remove other tmp files used by the tests and the harness so
> that we leave no new tmp files in /tmp dir after a full test run.
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

So much duplicated code!!

Did you consider consolidating all those lines that MUST start every test
with:

# Always start a test with this line
. ./common/prologue
# This is the standatd cleanup trigger - remove to implement a private
cleanup trigger
. ./common/cleanup

And while at it, why not put exit \$status inside the generic _cleanup()?

non generic cleanup implementations could looks like this:

trap "my_cleanup" 0 1 2 3 15

my_cleanup()
{
        # my cleanup stuff...
        # generic cleanup and exit $status
        _cleanup
}
