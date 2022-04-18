Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA654C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 17:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbiDRRKV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiDRRKV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 13:10:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C0201B2
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 10:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC124B80E5B
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 17:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCE9C385A7;
        Mon, 18 Apr 2022 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650301658;
        bh=RAWsL6aVod1FKyjzsv4EUfwmOU5Z/edFDiU9+E2XAaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8j7Y7qypgYjkqfSZaWiToH2369MysSG/Fm58MGvGoco5UFdFGblJsozWV4yUzfUt
         grjVlU2faatVKCoixr+YM2sOIUMXmkwwQHdyi0lioiSNgX/7BTHAixud06Wd7fMD3y
         uoLpQ+AdcNUoLON1F9eBIDrbpJzowdUsOR4NBhh4xhPINIfTLHY+ZDUub62Ul3aRvb
         GELT1pqMY5xJuGyjGt/2HBw+Pb4dGuF8PagKeyBZ14sCHaWg4ztBLsKlRVeZfYQIA/
         D2JZ6/RO7KcaH48upAMJIVOkoWkn8ZKcuvX0fy9J9+lJ+BAXPc5Qu0XRZ/JCOE4jR4
         scR66db+KluYA==
Date:   Mon, 18 Apr 2022 10:07:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220418170737.GE17014@magnolia>
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
 <20220413002656.GL1609613@dread.disaster.area>
 <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox>
 <20220414191643.5udsx6kdarlumyfn@zlang-mailbox>
 <CAOQ4uxhA7pnfRE6sSQkKOAJRDP1WmNWZBj7T_THQEjYrD7SaxQ@mail.gmail.com>
 <20220416141126.wwzvkzyzbvjczfae@zlang-mailbox>
 <CAOQ4uxg8G1AkcyzpALy8Nc7duuENCYatLOqY9vF6PL5maM4NWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg8G1AkcyzpALy8Nc7duuENCYatLOqY9vF6PL5maM4NWg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 16, 2022 at 08:13:59PM +0300, Amir Goldstein wrote:
> On Sat, Apr 16, 2022 at 5:11 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sat, Apr 16, 2022 at 12:20:22PM +0300, Amir Goldstein wrote:
> > > On Fri, Apr 15, 2022 at 12:56 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Fri, Apr 15, 2022 at 12:25:44AM +0800, Zorro Lang wrote:
> > > > > On Wed, Apr 13, 2022 at 10:26:56AM +1000, Dave Chinner wrote:
> > > > > > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > > > > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > > > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > > > > > >
> > > > > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > > > > >
> > > > > > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > > > > > Kill them in the cleanup function so that they don't have to be
> > > > > > > > > manually killed after interrupting the test.
> > > > > > > > >
> > > > > > > > > While touching the _cleanup() function, make it do everything that
> > > > > > > > > the generic _cleanup function it overrides does and fix the
> > > > > > > > > indenting.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  tests/generic/019 | 6 ++++--
> > > > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > > > > > index db56dac1..cda107f4 100755
> > > > > > > > > --- a/tests/generic/019
> > > > > > > > > +++ b/tests/generic/019
> > > > > > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > > > > > >  # Override the default cleanup function.
> > > > > > > > >  _cleanup()
> > > > > > > > >  {
> > > > > > > > > -    disallow_fail_make_request
> > > > > > > > > -    rm -f $tmp.*
> > > > > > > > > +     kill $fs_pid $fio_pid &> /dev/null
> > > > > > > > > +     disallow_fail_make_request
> > > > > > > > > +     cd /
> > > > > > > > > +     rm -r -f $tmp.*
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > > > > > >
> > > > > > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > > > > > wait, but should be fine as-is:
> > > > > > >
> > > > > > > I agree. Better to avoid killing other system processes. Or how about this place
> > > > > > > does (avoid killing system useful processes):
> > > > > > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > > > > > $KILLALL_PROG -q $FIO_PROG
> > > > > > >
> > > > > > > Another picky question is, do we need to use a while loop checking, until the
> > > > > > > processes really get killed? :)
> > > > > >
> > > > > > Do we really need to paint the bikeshed over how best to kill a
> > > > > > process? I don't have time to do that, this is just a drive-by fix
> > > > > > that works for me....
> > > > >
> > > > > Sure Dave:) The while loop checking is a little picky, I just ask what do you think, no
> > > > > objection if you don't like that. Due to quick cleanup and exit is a good reason too.
> > > > >
> > > > > I think it might be worth doing "$KILLALL_PROG -q $FSSTRESS_PROG $FIO_PROG" at least, to
> > > > > avoid killing other processes might be useful.
> > >
> > > That has much more likelihood to kill processes not spawn by the test
> > > then pid wraparound.
> >
> > Yes, you're right. But generally we don't run xfstests with other testing, to avoid other
> > testing break dmesg checking of xfstests. (Is there a way to help different process get
> > independent dmesg out? If there's, I'm very glad to know how to do that, then I can run
> > xfstests concurrently in one system:)
> >
> > Anyway, we can choose another way -- "unset'ing the "fs_pid" and "fio_pid" variables
> > after the wait", both are fine to me.
> >
> 
> Fine by me

The change to clear the fs_pid/fio_pid variables was not correct and now
causes generic/019 to fail.  I'll send a patch shortly.

--D

> Thanks,
> Amir.
