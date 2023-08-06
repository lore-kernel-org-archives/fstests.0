Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01287C001DE
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Aug 2023 04:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHFEge (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Aug 2023 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFEgd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Aug 2023 00:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6C1FDB
        for <fstests@vger.kernel.org>; Sat,  5 Aug 2023 21:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691296545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uX2ZHHWQjCvO7NT8cSxsEUrC26tgwBO5g+hfpVJk69o=;
        b=T4386qlJBy6536GYwo9NoYlQfBtVzl//ax0xVMGVXvtl5wqGzkd9z94RZIH3zDKBxK+Tdg
        sfRebRxRHbaYtEYrUPDdxJ4D7jmd4xOYszjVBftuGCdhws0GGtqVmKH0CDCWCCZW34CKUj
        jasj+q0cPlw8s+fwksYiav6nzUDz4wI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-Eev0LwgoPli1jbkznXgQWQ-1; Sun, 06 Aug 2023 00:35:44 -0400
X-MC-Unique: Eev0LwgoPli1jbkznXgQWQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55c04f5827eso2263062a12.1
        for <fstests@vger.kernel.org>; Sat, 05 Aug 2023 21:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691296543; x=1691901343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX2ZHHWQjCvO7NT8cSxsEUrC26tgwBO5g+hfpVJk69o=;
        b=hVWYYIUrnCm0YVcttQXFc0tPKhAWs5A39W7Mas91sG5qPzQTmTeUZBZd7k/nJNIUen
         yLjEw55ApsH43Ea6kKsxn8jaOH+LRKCL53jdoPqciGbXnDcVCBJ9rKeYnOT7hVVB3OG+
         uBiZ+mwP1WjvK9babli+AntBW5yryDZhPWLZver3Auiyp6+4U4OEv5pxkdydAFTE5qDo
         rFxfxwoGX4qOdvIAqDKRytYGqm4QICAzIKWFXRYveHzeIfmc/RLDCjhZ6PJieLXSQpQ3
         CXIModKVdnaTj926Osl/A3pPbhrunB2+HKHu+EI8nXf8Z76G4W+2/ijmDLF8bh8S0Anb
         nOnw==
X-Gm-Message-State: AOJu0YydXh5mrWJxPcSXWBit5Pu/u/R111Y9mSzpt5zA8Aa7iHMZySir
        tXiB4teeTOUptBbpuwYRkFVcda01OP7wNoBQUFqJhuA3DuiSFNH/oWAdWD3V1mpDaU1e5jz7VcG
        KFKRsvvGccM5PyBlmpA==
X-Received: by 2002:a17:902:bd07:b0:1b1:9218:6bf9 with SMTP id p7-20020a170902bd0700b001b192186bf9mr5777905pls.43.1691296543194;
        Sat, 05 Aug 2023 21:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5YgxPdbts5ogpQi36yXBZksz0Dcj1vssHD7FnDcGbE4AAOnek+x+qEwmveEFv9B3bZnJUSA==
X-Received: by 2002:a17:902:bd07:b0:1b1:9218:6bf9 with SMTP id p7-20020a170902bd0700b001b192186bf9mr5777895pls.43.1691296542843;
        Sat, 05 Aug 2023 21:35:42 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jk16-20020a170903331000b001b9e0918b0asm4277812plb.169.2023.08.05.21.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 21:35:42 -0700 (PDT)
Date:   Sun, 6 Aug 2023 12:35:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: add missing -K in usage() and cleanup
Message-ID: <20230806043539.5kx6k3jnfro47rag@zlang-mailbox>
References: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
 <20230804211704.GM11340@frogsfrogsfrogs>
 <20230805095040.pizumjuwhdxvl63z@zlang-mailbox>
 <20230805162029.GN11377@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805162029.GN11377@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 05, 2023 at 09:20:29AM -0700, Darrick J. Wong wrote:
> On Sat, Aug 05, 2023 at 05:50:40PM +0800, Zorro Lang wrote:
> > On Fri, Aug 04, 2023 at 02:17:04PM -0700, Darrick J. Wong wrote:
> > > On Fri, Aug 04, 2023 at 01:40:03PM +0800, Shiyang Ruan wrote:
> > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > 
> > > Yes, thank you, this is much more readable.
> > > 
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > --D
> > > 
> > > > ---
> > > >  ltp/fsx.c | 27 +++++++++++++++++----------
> > > >  1 file changed, 17 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index ffa64cfa0..753c472f4 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > > @@ -2393,11 +2393,17 @@ void
> > > >  usage(void)
> > > >  {
> > > >  	fprintf(stdout, "usage: %s",
> > > > -		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
> > > > +		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > +	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > > > +	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > > > +	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > > +	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> > > > +	   [--replay-ops opsfile] [--record-ops[=opsfile]] [--duration seconds]\n\
> > 
> > "--duration seconds"
> > 
> > > > +	   ... fname\n\
> > > >  	-b opnum: beginning operation number (default 1)\n\
> > > >  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
> > > >  	-d: debug output for all operations\n\
> > > > -	-f flush and invalidate cache after I/O\n\
> > > > +	-f: flush and invalidate cache after I/O\n\
> > > >  	-g X: write character X instead of random generated data\n\
> > > >  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > >  	-j logid: prefix debug log messsages with this id\n\
> > > > @@ -2412,15 +2418,15 @@ usage(void)
> > > >  	-s style: 1 gives smaller truncates (default 0)\n\
> > > >  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
> > > >  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> > > > -	-x: preallocate file space before starting, XFS only (default 0)\n\
> > > > -	-y synchronize changes to a file\n"
> > > > +	-x: preallocate file space before starting, XFS only\n\
> > > > +	-y: synchronize changes to a file\n"
> > > >  
> > > >  #ifdef AIO
> > > >  "	-A: Use the AIO system calls, -A excludes -U\n"
> > > >  #endif
> > > >  #ifdef URING
> > > >  "	-U: Use the IO_URING system calls, -U excludes -A\n"
> > > > - #endif
> > > > +#endif
> > > >  "	-D startingop: debug output starting at specified operation\n"
> > > >  #ifdef HAVE_LINUX_FALLOC_H
> > > >  "	-F: Do not use fallocate (preallocation) calls\n"
> > > > @@ -2449,18 +2455,19 @@ usage(void)
> > > >  #ifdef FIEXCHANGE_RANGE
> > > >  "	-0: Do not use exchange range calls\n"
> > > >  #endif
> > > > -"	-L: fsxLite - no file creations & no file size changes\n\
> > > > +"	-K: Do not use keep size\n\
> > > > +	-L: fsxLite - no file creations & no file size changes\n\
> > > >  	-N numops: total # operations to do (default infinity)\n\
> > > >  	-O: use oplen (see -o flag) for every op (default random)\n\
> > > > -	-P: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> > > > +	-P dirpath: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> > > >  	-S seed: for random # generator (default 1) 0 gets timestamp\n\
> > > >  	-W: mapped write operations DISabled\n\
> > > >  	-X: Read file and compare to good buffer after every operation.\n\
> > > > -        -R: read() system calls only (mapped reads disabled)\n\
> > > > -        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> > > > +	-R: read() system calls only (mapped reads disabled)\n\
> > > > +	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> > > >  	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
> > > >  	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
> > > > -	--duration=seconds: ignore any -N setting and run for this many seconds\n\
> > > > +	--duration seconds: ignore any -N setting and run for this many seconds\n\
> > 
> > I'm wondering does "--duration" need the "=" or not, or either?
> 
> glibc getopt_long doesn't care either way, but I suppose we ought to be
> consistent about the equals.  Perhaps leave it the way it was?

Yeah, likes `grubby --set-default /boot/xxx` also can be "--set-default=/boot/xxx".
But looks like mostly one "hyphen" option uses space (between option name and
value), two "hyphens" option uses "=". (correct me if it's wrong)

So I think we'd better to keep consistent in fstests, especially for fsstress
and fsx. As this patch is trying to tidy to usage, we can change to
"--replay-ops=opsfile", "--duration=seconds".

Thanks,
Zorro

> 
> --D
> 
> > Looks like fsstress.c and fsx.c recommend using "--duration=xxx":
> > fsstress.c:
> >                 case 256:  /* --duration */
> >                         if (!optarg) {
> >                                 fprintf(stderr, "Specify time with --duration=\n");
> > 
> > fsx.c:
> >                 case 254:  /* --duration */
> >                         if (!optarg) {
> >                                 fprintf(stderr, "Specify time with --duration=\n");
> > 
> > 
> > And each case contains "--duration" tends to use the "=" too:
> > 
> >   $ grep -rsn -- "--duration" tests/
> >   tests/generic/642:52:test -n "$DURATION" && args+=(--duration="$DURATION")
> >   tests/generic/521:38:test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
> >   tests/generic/476:37:test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> >   tests/generic/522:32:test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
> > 
> > 
> > As this patch hopes to tidy the fsx options, maybe we can clear that, better to
> > have a  consistent usage?
> > 
> > Thanks,
> > Zorro
> > 
> > > >  	fname: this filename is REQUIRED (no default)\n");
> > > >  	exit(90);
> > > >  }
> > > > -- 
> > > > 2.41.0
> > > > 
> > > 
> > 
> 

