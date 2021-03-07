Return-Path: <SRS0=cgbt=IF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF9C433E0
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Mar 2021 23:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AD665165
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Mar 2021 23:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhCGXMP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Mar 2021 18:12:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59885 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233298AbhCGXLv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Mar 2021 18:11:51 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 127NBcPu015448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Mar 2021 18:11:38 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 16A2E15C3AAC; Sun,  7 Mar 2021 18:11:38 -0500 (EST)
Date:   Sun, 7 Mar 2021 18:11:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test which tries to exercise AIO/DIO into
 unwritten space
Message-ID: <YEVdqb9kcOV004ZO@mit.edu>
References: <20210210205818.1494305-1-tytso@mit.edu>
 <YET+QSgT3e+R/yzO@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YET+QSgT3e+R/yzO@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 08, 2021 at 12:24:33AM +0800, Eryu Guan wrote:
> > +trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
> 
> Better to trap a _cleanup function, even we only do "rm -f $tmp.*" in it,
> so it's consistent to other tests, and it's easier to add more cleanups
> in _cleanup() function in the future if needed.

Done.  I had based this test on generic/299 and generic/300, and a lot
of your comments are applicable to them as well.  I can send a cleanup
patch to fix up those patches as well..

> > +_require_odirect
> 
> _require_aio

Hmmm, generic/299 and generic/300 are missing _require_aio, while
doing async I/O.  I'm a bit surprised this hasn't caused problems for
other file systems.

> > +
> > +_workout()
> 
> There's no need to add the leading "_" to local function, it's reserved
> to common functions.

Done.  (Actually, if we're not unmounting $SCRATCH, then we really
don't need a workout local function at all.)

> > +	run_check $FIO_PROG $fio_config
> 
> run_check is not recommanded and should be deprecated (maybe I should
> send a patch to document it in comment), as it hides failure in
> $seqres.full and exits if command returns non-zero.
> 
> Just call $FIO_PROG command directly and check return value if
> necessary.

Thanks for suggesting dropping the run_check.  I found a problem in
the fio receipe which was causing a FIO warning that I had been
missing.

BTW, all but one of the generic are still using run_check, and in the
one exception, generic/095, which uses --output=$seqres.full which is
causing us to lose all of the output of the earlier commands which
redirected their outputs to $seqres.full.  So there's clearly a
"target rich environment" in terms of test clean up opportunities.

> > +if ! _scratch_unmount; then
> > +	echo "failed to umount"
> > +	status=1
> > +	exit
> > +fi
> 
> Is above _scratch_unmount check really needed? The test harness would
> umount $SCRATCH_DEV after test anyway.

Done.

Thanks for the review,

				- Ted
