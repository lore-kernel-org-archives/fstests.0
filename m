Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC98EB64DD
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Aug 2023 10:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHEKCz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Aug 2023 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEKCy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Aug 2023 06:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7556469F
        for <fstests@vger.kernel.org>; Sat,  5 Aug 2023 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691229725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5oZMOQLN6i06pjqUEVHweeu6mAEvm6blxX8p4EnUy+I=;
        b=c5l8coEspebI85x12qj1kCKComqovjRhZt+wW2MgWRdnxVvWLhUphNc3McZnehxUHue/h5
        NwxQ78fT1yote4lA+FsUlALywRT7zZe/KsGFn+8iR5x3QSPTNO3HrH90CVdTKhVZO0n4eJ
        41x/wqLCDF/pHFln5uvaLHCIxzNX+bo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-w4Ib-AjqMDGaUI_NtyNsHw-1; Sat, 05 Aug 2023 06:02:04 -0400
X-MC-Unique: w4Ib-AjqMDGaUI_NtyNsHw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bc4abfca29so14315405ad.3
        for <fstests@vger.kernel.org>; Sat, 05 Aug 2023 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691229723; x=1691834523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oZMOQLN6i06pjqUEVHweeu6mAEvm6blxX8p4EnUy+I=;
        b=h+h/CjB6QfYjCwzGvtRnL9FeNbNwtr6F3pGkqhdbZYEYfGBJ6BddLCErJOQcXSE4Au
         qrrIGvzoCDI3d3uJm4QRwGStgCBJ6/fq7opYptHNmCa5JEMNzLTklp7Ole+hOzM8sycW
         wfV0Px/zL7I9DF8pO/qfW+R0ZirwAF9WDJFG6H+l2fkgmFKuM30oJiIXt5NDLbEgeZPR
         S5P7VOxLQQU57vGY3znT2k5FtZXaqlUTW6lmbrma31Ok7S7kof+acS1HkKgyPRG1mU9d
         tU7X3MTBldsLTYJ75v4QF/gQhZMnrukeTsSdsbFZ7lfRTBgMpTuCv1D6Uu1gltaLad4u
         vdXQ==
X-Gm-Message-State: AOJu0Yyl5J7Tixh7qSBIPbXwoODngWeL4vO6YifjbMSmfpUeqS5T8/Xx
        sPpFOFdVd6+6hrH+wMTq29rNqeCki6p4mNamG4oH+TrYr9El+p4eb4wZsYEdn9YV/SalCU0kK7y
        DEwEw2Ss/1dHSKWUZEXRRKl9ve2hNUeo=
X-Received: by 2002:a17:902:e847:b0:1bb:ee1b:3cc8 with SMTP id t7-20020a170902e84700b001bbee1b3cc8mr4524686plg.61.1691229723114;
        Sat, 05 Aug 2023 03:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxzFrHspAdB+s9Q3/A8/9fUQKmn5oiChSxEjKo+Z+G4/pMZSKhBiDkSPvNhgbn+drpshP8rA==
X-Received: by 2002:a17:902:e847:b0:1bb:ee1b:3cc8 with SMTP id t7-20020a170902e84700b001bbee1b3cc8mr4524671plg.61.1691229722806;
        Sat, 05 Aug 2023 03:02:02 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b001b87bedcc6fsm3153833plb.93.2023.08.05.03.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 03:02:02 -0700 (PDT)
Date:   Sat, 5 Aug 2023 18:01:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: add missing -K in usage() and cleanup
Message-ID: <20230805100159.knqdrsfes3jsrp6x@zlang-mailbox>
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

BTW, as this patch trys to tidy the fsx's options usage mostly, and "add
missing option usage" is part of this job. So I'd like to change the subject
of to  "fsx: tidy options usage and format" (or other description which
can reflect the main job you did in this patch.) Then you can describe more
details in commit log, likes adding missing -K option and so on.

Thanks,
Zorro

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
> 
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

