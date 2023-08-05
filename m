Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B21CC001DB
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Aug 2023 16:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHEQUd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Aug 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHEQUd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Aug 2023 12:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3434200
        for <fstests@vger.kernel.org>; Sat,  5 Aug 2023 09:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155CE60B18
        for <fstests@vger.kernel.org>; Sat,  5 Aug 2023 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71597C433C8;
        Sat,  5 Aug 2023 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691252430;
        bh=rJgH9D1HQJR6E/Wn33HgdABhLgE8qIyqFc8c1pdPGrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYvWTCcJfEOga7KkpPAoRbszXZov/o8QFv8dc8YB48I5DBMc+W8zjTfyS614Dh65I
         BPq64TmnaLhu5gXkCKBU7rxU2EwBSK0nuQbor7trjYDLMDU+6WYdm9e/SVB78F8OIP
         1vnK6WgLywRrf94x4e60B1IaZo3Qev83moA8BvgV+vHbqFqYC+sEWIJoCEqXikjPM5
         INil7B7W/skl8H/E61DcVgxw00+Ye6yrc+nx+qp2Ul4gi8I3bay+FVQPbxnUAhqgGu
         WWNrFdmRkaRa3CUalxP0zV78aJorUK9pXiFivJo6g+3cRTMS2o9z1Rnz0Q6ErBrVwD
         lmsNCqAUJYQxg==
Date:   Sat, 5 Aug 2023 09:20:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: add missing -K in usage() and cleanup
Message-ID: <20230805162029.GN11377@frogsfrogsfrogs>
References: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
 <20230804211704.GM11340@frogsfrogsfrogs>
 <20230805095040.pizumjuwhdxvl63z@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805095040.pizumjuwhdxvl63z@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 05, 2023 at 05:50:40PM +0800, Zorro Lang wrote:
> On Fri, Aug 04, 2023 at 02:17:04PM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 04, 2023 at 01:40:03PM +0800, Shiyang Ruan wrote:
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > 
> > Yes, thank you, this is much more readable.
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > --D
> > 
> > > ---
> > >  ltp/fsx.c | 27 +++++++++++++++++----------
> > >  1 file changed, 17 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index ffa64cfa0..753c472f4 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -2393,11 +2393,17 @@ void
> > >  usage(void)
> > >  {
> > >  	fprintf(stdout, "usage: %s",
> > > -		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
> > > +		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > +	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > > +	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > > +	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > +	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> > > +	   [--replay-ops opsfile] [--record-ops[=opsfile]] [--duration seconds]\n\
> 
> "--duration seconds"
> 
> > > +	   ... fname\n\
> > >  	-b opnum: beginning operation number (default 1)\n\
> > >  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
> > >  	-d: debug output for all operations\n\
> > > -	-f flush and invalidate cache after I/O\n\
> > > +	-f: flush and invalidate cache after I/O\n\
> > >  	-g X: write character X instead of random generated data\n\
> > >  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
> > >  	-j logid: prefix debug log messsages with this id\n\
> > > @@ -2412,15 +2418,15 @@ usage(void)
> > >  	-s style: 1 gives smaller truncates (default 0)\n\
> > >  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
> > >  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> > > -	-x: preallocate file space before starting, XFS only (default 0)\n\
> > > -	-y synchronize changes to a file\n"
> > > +	-x: preallocate file space before starting, XFS only\n\
> > > +	-y: synchronize changes to a file\n"
> > >  
> > >  #ifdef AIO
> > >  "	-A: Use the AIO system calls, -A excludes -U\n"
> > >  #endif
> > >  #ifdef URING
> > >  "	-U: Use the IO_URING system calls, -U excludes -A\n"
> > > - #endif
> > > +#endif
> > >  "	-D startingop: debug output starting at specified operation\n"
> > >  #ifdef HAVE_LINUX_FALLOC_H
> > >  "	-F: Do not use fallocate (preallocation) calls\n"
> > > @@ -2449,18 +2455,19 @@ usage(void)
> > >  #ifdef FIEXCHANGE_RANGE
> > >  "	-0: Do not use exchange range calls\n"
> > >  #endif
> > > -"	-L: fsxLite - no file creations & no file size changes\n\
> > > +"	-K: Do not use keep size\n\
> > > +	-L: fsxLite - no file creations & no file size changes\n\
> > >  	-N numops: total # operations to do (default infinity)\n\
> > >  	-O: use oplen (see -o flag) for every op (default random)\n\
> > > -	-P: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> > > +	-P dirpath: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> > >  	-S seed: for random # generator (default 1) 0 gets timestamp\n\
> > >  	-W: mapped write operations DISabled\n\
> > >  	-X: Read file and compare to good buffer after every operation.\n\
> > > -        -R: read() system calls only (mapped reads disabled)\n\
> > > -        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> > > +	-R: read() system calls only (mapped reads disabled)\n\
> > > +	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> > >  	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
> > >  	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
> > > -	--duration=seconds: ignore any -N setting and run for this many seconds\n\
> > > +	--duration seconds: ignore any -N setting and run for this many seconds\n\
> 
> I'm wondering does "--duration" need the "=" or not, or either?

glibc getopt_long doesn't care either way, but I suppose we ought to be
consistent about the equals.  Perhaps leave it the way it was?

--D

> Looks like fsstress.c and fsx.c recommend using "--duration=xxx":
> fsstress.c:
>                 case 256:  /* --duration */
>                         if (!optarg) {
>                                 fprintf(stderr, "Specify time with --duration=\n");
> 
> fsx.c:
>                 case 254:  /* --duration */
>                         if (!optarg) {
>                                 fprintf(stderr, "Specify time with --duration=\n");
> 
> 
> And each case contains "--duration" tends to use the "=" too:
> 
>   $ grep -rsn -- "--duration" tests/
>   tests/generic/642:52:test -n "$DURATION" && args+=(--duration="$DURATION")
>   tests/generic/521:38:test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
>   tests/generic/476:37:test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
>   tests/generic/522:32:test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
> 
> 
> As this patch hopes to tidy the fsx options, maybe we can clear that, better to
> have a  consistent usage?
> 
> Thanks,
> Zorro
> 
> > >  	fname: this filename is REQUIRED (no default)\n");
> > >  	exit(90);
> > >  }
> > > -- 
> > > 2.41.0
> > > 
> > 
> 
