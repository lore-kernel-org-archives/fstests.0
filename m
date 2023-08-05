Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94437EB64DD
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Aug 2023 09:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHEJvh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Aug 2023 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEJvg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Aug 2023 05:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B870A3A9B
        for <fstests@vger.kernel.org>; Sat,  5 Aug 2023 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691229047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYeNnJCqwiP8qBCMohcUxQ4/ihbNnklDAc9Uz3giuYc=;
        b=CBkUe1CE+bTir3X5AU+MjVCmVYC2IvdcSCciv6dgKIxozwzM2gA1jthuvtK/qAUcZ96V8Q
        9/gqtA/N8Yah1SmdGWg6Z/14uCwTLJvKlCI4LBjSZgaMh2LMr7COp3O2IQuc0QLhI2iC4a
        ZG8AAwSTTxlpOXfW/WLGzMB4dwxb6HM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-1AzGRm4NPtClbpdYl-BXoA-1; Sat, 05 Aug 2023 05:50:45 -0400
X-MC-Unique: 1AzGRm4NPtClbpdYl-BXoA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-686bc3f11feso2084445b3a.0
        for <fstests@vger.kernel.org>; Sat, 05 Aug 2023 02:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691229044; x=1691833844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYeNnJCqwiP8qBCMohcUxQ4/ihbNnklDAc9Uz3giuYc=;
        b=QAvRnmfrgoR253X1aDF3S8c68oizN+3saEwxDmQwQg3NS9aHW8VVz2xhqT8/2JCaw9
         CmB10H3/kXvu89BYQnBBAzAnt82COCoOMQDnNVbW9j82zhDRcbrSzXxmrASB6+liR+65
         vldREq/0OeZqn1QgiaNULYkn9UnNkdeVl/aFPzpnpm+J5Kq9Yg1okbspEQQaCza2vDFO
         ANRNnfoTekLRYPVGz9aO2GlkMEwHLK5cC1y2r07KyS6xmrjFMj1YBaYemNnfnyGsDR86
         +DQMFoMnXb/fZbeA+ORomK8qVtAeuEMwMcDxMSEOw9/4cb25XL3o6tFB5cM8lEUu67E9
         ffGA==
X-Gm-Message-State: AOJu0YwaNoHEqb/SswttEa9AedG1O+7xB4Y3h1kH0EynM+jwyHqJEGpO
        WaNiffWrH+mER3IfanhsQkd5bXluN1uYPuWy+bl5lA9UqY/gPd9DTwv5/F6iuRbZFnVNfVh/C5R
        AWSkJDGIJgwjsV8UgVw==
X-Received: by 2002:a05:6a00:a27:b0:687:1706:e8bf with SMTP id p39-20020a056a000a2700b006871706e8bfmr2544064pfh.10.1691229044488;
        Sat, 05 Aug 2023 02:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrAYfoWy1GxtkJA6XESFmsXU+mzSFzfA0qHiWiEz4nias659bUx6BuK3JRRf1jvNHHHU1EfQ==
X-Received: by 2002:a05:6a00:a27:b0:687:1706:e8bf with SMTP id p39-20020a056a000a2700b006871706e8bfmr2544053pfh.10.1691229044075;
        Sat, 05 Aug 2023 02:50:44 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b00686edf28c22sm2837916pfb.87.2023.08.05.02.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:50:43 -0700 (PDT)
Date:   Sat, 5 Aug 2023 17:50:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: add missing -K in usage() and cleanup
Message-ID: <20230805095040.pizumjuwhdxvl63z@zlang-mailbox>
References: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
 <20230804211704.GM11340@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804211704.GM11340@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 04, 2023 at 02:17:04PM -0700, Darrick J. Wong wrote:
> On Fri, Aug 04, 2023 at 01:40:03PM +0800, Shiyang Ruan wrote:
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Yes, thank you, this is much more readable.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  ltp/fsx.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index ffa64cfa0..753c472f4 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -2393,11 +2393,17 @@ void
> >  usage(void)
> >  {
> >  	fprintf(stdout, "usage: %s",
> > -		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
> > +		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > +	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > +	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > +	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > +	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> > +	   [--replay-ops opsfile] [--record-ops[=opsfile]] [--duration seconds]\n\

"--duration seconds"

> > +	   ... fname\n\
> >  	-b opnum: beginning operation number (default 1)\n\
> >  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
> >  	-d: debug output for all operations\n\
> > -	-f flush and invalidate cache after I/O\n\
> > +	-f: flush and invalidate cache after I/O\n\
> >  	-g X: write character X instead of random generated data\n\
> >  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
> >  	-j logid: prefix debug log messsages with this id\n\
> > @@ -2412,15 +2418,15 @@ usage(void)
> >  	-s style: 1 gives smaller truncates (default 0)\n\
> >  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
> >  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> > -	-x: preallocate file space before starting, XFS only (default 0)\n\
> > -	-y synchronize changes to a file\n"
> > +	-x: preallocate file space before starting, XFS only\n\
> > +	-y: synchronize changes to a file\n"
> >  
> >  #ifdef AIO
> >  "	-A: Use the AIO system calls, -A excludes -U\n"
> >  #endif
> >  #ifdef URING
> >  "	-U: Use the IO_URING system calls, -U excludes -A\n"
> > - #endif
> > +#endif
> >  "	-D startingop: debug output starting at specified operation\n"
> >  #ifdef HAVE_LINUX_FALLOC_H
> >  "	-F: Do not use fallocate (preallocation) calls\n"
> > @@ -2449,18 +2455,19 @@ usage(void)
> >  #ifdef FIEXCHANGE_RANGE
> >  "	-0: Do not use exchange range calls\n"
> >  #endif
> > -"	-L: fsxLite - no file creations & no file size changes\n\
> > +"	-K: Do not use keep size\n\
> > +	-L: fsxLite - no file creations & no file size changes\n\
> >  	-N numops: total # operations to do (default infinity)\n\
> >  	-O: use oplen (see -o flag) for every op (default random)\n\
> > -	-P: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> > +	-P dirpath: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> >  	-S seed: for random # generator (default 1) 0 gets timestamp\n\
> >  	-W: mapped write operations DISabled\n\
> >  	-X: Read file and compare to good buffer after every operation.\n\
> > -        -R: read() system calls only (mapped reads disabled)\n\
> > -        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> > +	-R: read() system calls only (mapped reads disabled)\n\
> > +	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> >  	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
> >  	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
> > -	--duration=seconds: ignore any -N setting and run for this many seconds\n\
> > +	--duration seconds: ignore any -N setting and run for this many seconds\n\

I'm wondering does "--duration" need the "=" or not, or either?

Looks like fsstress.c and fsx.c recommend using "--duration=xxx":
fsstress.c:
                case 256:  /* --duration */
                        if (!optarg) {
                                fprintf(stderr, "Specify time with --duration=\n");

fsx.c:
                case 254:  /* --duration */
                        if (!optarg) {
                                fprintf(stderr, "Specify time with --duration=\n");


And each case contains "--duration" tends to use the "=" too:

  $ grep -rsn -- "--duration" tests/
  tests/generic/642:52:test -n "$DURATION" && args+=(--duration="$DURATION")
  tests/generic/521:38:test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
  tests/generic/476:37:test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
  tests/generic/522:32:test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")


As this patch hopes to tidy the fsx options, maybe we can clear that, better to
have a  consistent usage?

Thanks,
Zorro

> >  	fname: this filename is REQUIRED (no default)\n");
> >  	exit(90);
> >  }
> > -- 
> > 2.41.0
> > 
> 

