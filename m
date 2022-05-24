Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5289EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 08:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiEXI3c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 04:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiEXI3b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 04:29:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81AC692AA
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 01:29:29 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id cv1so1590490qvb.5
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVB3fULD0gEch6Ti0Y/oscbpiL4zTe6IpkkNrX8rFQk=;
        b=VDozAKtxyvh/JnF/4yM7eS0QXjuyr612obbkB5BcD9uv3tttzRXVAO7OLAgzF/6GNv
         Z+9y5Zw6B+k91Z5Iei1+/4Y6A/mryoPhr7NRJcy+KyU3LT093NSaPObPtqMK3ioEOUmX
         812o2hPGmpH2CxxgwcN4gT5KecRoWsp5l1N00VH6rYL8vvxrFgdyd0QTAMVNfuIbGaJm
         89jeyPYF1HgNwQCtaBCElVKDGL6kia+O6F6UC+oRI8fM3J47LH0XhUm4wT1mUCOlsoyR
         LEMc16z7dSpiqxHfClMgiOuUqebwQEHR/nIIJZGV3TpOGcSPHIw1CXwk0ADGDPtzJxi3
         bfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVB3fULD0gEch6Ti0Y/oscbpiL4zTe6IpkkNrX8rFQk=;
        b=wMWIH8igTw6/RME2fxogNgu0JGtWTq0GmMl+AxjfEeDDNvgrSfRdBIydngc9VRNti7
         O7YToegA2FeSCRC3e+t5SMnAkRjXPS/Iqsfzdd22j5LVAGRHBbuBJHH4XUL0wVS+SFS6
         rupA0mqA9/QOnZT+y6+Dk1OhF9O+4WaohqNTir7wInM0L8F7qv+mTaU1uofhAm2E4/av
         RVou9qqMuEgEfCoCeJ0l1nzkvUb2gHKKorB048BUB82bNUKEEM78xZny+oOq7EErALVA
         94aZhX+bqDp527jEWQKxKpX9qbI8KjoHh/TVnwWIPsOL0lLf0r3rkD2uelywJG+MsOLS
         WHQQ==
X-Gm-Message-State: AOAM5335Z4Rl9X8VbG1ov7K9Ot65devX9z1ramGemSjXWxRzJAgoQcro
        +2QesRJGj0bei0gLWSc7zoaRevggtDW+Vjl6cN9xb2Wk
X-Google-Smtp-Source: ABdhPJwaTviDH93tmsfPcLgXOU2ZTQbDCbU45gSbUrJRv038IDecWsZHGwp1i61BmwKYGx7uZq/oO5lbbL2VgRzY+3k=
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id
 ib3-20020a0562141c8300b00443674951f8mr20163179qvb.74.1653380968988; Tue, 24
 May 2022 01:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 11:29:17 +0300
Message-ID: <CAOQ4uxi9gFQ4Zr6pfvia8WgjzyQqc2LnAwamw_XDuyR0ndGjBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 11:01 AM Dave Chinner <david@fromorbit.com> wrote:
>
> Hi folks,
>
> I pulled on a string a couple of days ago, and it got out of
> control. It all started when I went to kill a test with ctrl-c and
> it, once again, left background processes running that I had to hunt
> down and kill manually.
>
> I then started looking a why this keeps happening, and realised that
> the way we clean up on test completion is messy, inconsistent and
> frequently buggy. So I started cleaning it all up, starting with the
> tests/xfs directory because I saw a lot of low hanging fruit there.
>
> Essentially, we use _cleanup() functions as a way of overriding the
> default trap handler we install in _begin_fstest(). Rather than
> register a new handler, we just redefine the common cleanup function
> and re-implement it (poorly) in every test that does an override.
> Often these overrides are completely unnecessary - I think I reduced
> the total number of overrides in tests/xfs by ~30% (~190 -> ~125),
> and I reudced the number of *unique overrides by a lot more than
> that.
>

That looks like an awesome improvement!

> The method for overriding changes to be "stacked cleanups" rather
> than "duplicated cleanups". That is, tests no longer open code:
>
>         cd /
>         rm -rf $tmp.*
>
> THis is what common/preamble::_cleanup() does. We should call that
> function to do this. Hence if we have a local cleanup that we need
> to do, it becomes:
>
> local_cleanup()
> {
>         rm -f $testfile
>         _cleanup
> }
> _register_cleanup local_cleanup

While removing boilerplate code, we had better not create another boilerplate.
Instead of expecting test writers to always call _cleanup
if we always want _cleanup to be called we can always implicitly
chain it in _register_cleanup():

--- a/common/preamble
+++ b/common/preamble
@@ -20,7 +20,7 @@ _register_cleanup()
        shift

        test -n "$cleanup" && cleanup="${cleanup}; "
-       trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
+       trap "${cleanup}_cleanup; exit \$status" EXIT HUP INT QUIT TERM $*
 }

 # Prepare to run a fstest by initializing the required global variables to
@@ -46,7 +46,7 @@ _begin_fstest()
        tmp=/tmp/$$
        status=1        # failure is the default!

-       _register_cleanup _cleanup
+       _register_cleanup

        . ./common/rc


It could be a bit weird for tests that call
_register_cleanup _cleanup

But you removed most of those in the SIGBUS patch
and even if they do exists, _cleanup() is re-entrant.


>
> While this looks more verbose, it means we can actually reuse the
> same cleanup function across lots of tests.
>
> A large number of xfsdump tests were all using the same override
> cleanup function to call _cleanup_dump. These are all changed to:
>
> . ./common/dump
> _register_cleanup _cleanup_dump
>
> and _cleanup_dump stacks like this:
>
> _cleanup_dump()
> {
>         #do xfsdump cleanup stuff
>
>         _cleanup
> }
>
> and we don't need to do anything else. There is one xfsdump test
> that needs it's own cleanup. It stacks like this:
>
> local_cleanup()
> {
>         rm -f $testfile
>         _cleanup_dump
> }
> _register_cleanup local_cleanup
>
> All the tests that run fsstress in the background now have a common
> cleanup function that kills fsstress processes defined in
> common/preamble. They just do:
>
> _register_cleanup _cleanup_fsstress
>
> And now every test that puts fsstress in the background behaves
> correctly and kills all the background fsstree processes when
> interrupted.
>
> The conversion is by no means complete. I've named the local cleanup
> functions by what they do so we can go back and derive commonality
> between them. The number of different variations on tearing down
> loops devices is crazy, and half of them are buggy. I haven't worked
> through these yet, so you'll see lots of tests with:
>
> _loop_cleanup()
> {
>         ......
>         _cleanup
> }
> _register_cleanup _loop_cleanup
>
> That have similar but different ways of cleaning up loop devices.
>
> I also added a _no_cleanup() function, as there are a large number
> of xfs fuzzer tests that want to leave a warm corpse behind so that
> debugging what just happened is easy.
>
> I also added BUS to the default signal trap set - well over a 100
> tests in tests/xfs had a line like:
>
> _register_cleanup "_cleanup" BUS
>
> just to add BUS signals to the set that would cause the cleanup
> function to run. Just make it the default!
>
> Overall, this significantly reduces the amount of boiler plate in
> tests, and sets us down the path of common cleanup functions that
> tests may not even need to define. e.g. just including
> ./common/dmflakey registers the _cleanup_dmflakey() trap that will
> do all the necessary cleanup when the test exists. This makes the
> tests simpler, more robust and reduces the maintenance burden of
> over 1700 individual tests....
>
> I won't put the full diffstat in this mail, but the benefits should
> be clean from the summary:
>
> 360 files changed, 420 insertions(+), 1781 deletions(-)
>
> I've lost count of the number of test bugs I killed in removing
> all this code, and that's largely just in the tests/xfs directory.
> So before I go spend another couple of days on converting the rest
> of fstests, I figured I better make sure everyone is OK with these
> changes.
>
> Thoughts, comments?
>

Thank you for taking this on!

Amir.
