Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C619CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 15:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiEZPEe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiEZPEd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 11:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F3F6A42C
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653577471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcB4+xqC/y0UwuGOV7CYVS7xB1ZBCjBaU8g4+EHZmnU=;
        b=TbRF5Uq1J9c8nU1hwhN5YH74GT55VNdQdlLKrTCrRrx2INwhXpAmDQcYB52nLhAFGU2IQg
        6cK4D1cVEu7xAGBLqqyjxy0peljhcqL8BBfUaQQLtMSCKnB26+G5oP00DQjQiDjYXnDsbj
        1pHkbGjWdDlTrU/EEjV5HGNYou3NBgI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-N_GBlzkwOsCvvui43JjDhw-1; Thu, 26 May 2022 11:04:25 -0400
X-MC-Unique: N_GBlzkwOsCvvui43JjDhw-1
Received: by mail-qt1-f198.google.com with SMTP id cn8-20020a05622a248800b002f3c7be2744so1806408qtb.17
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcB4+xqC/y0UwuGOV7CYVS7xB1ZBCjBaU8g4+EHZmnU=;
        b=b4PZhJG6vWnZ+mewrGd2alW6PFOt3luPixxyw7cuIK8zF9LT22QDVBaQVAUGBfR3he
         XhepSmW3IpSjZYQkPDcOXFQmUeQZq6q14u79vDiEHWd9Mb1F9gu5/DHP1CnhvPaumlnz
         iMtFUKW/Fe0MJGv1W75BbctmCNgN+WAwANsoEJW2vD76JV63efbk8xAxJcn8ADEWbxQ7
         sOoZ4iYf8/eVZ9ujeXE4f2a2u45nvIznWDHVlrVLzu/68Skbq2/HabZNcsal2hmiiFvp
         O8ewWqySnPK9Wp7jrFPZmeRCnMEDueknxus6yiIlreK/r6gbuSnuuqoP52q7VEkXc8WH
         /qZA==
X-Gm-Message-State: AOAM531tqlvKZzknlprPLZN9Aaad+3OaL2noThJCQywwhoRLXB74cXzT
        lJr6SEY2/jVoRvfGSq2oGTDrkB+pFKDHFHWbf/9uEKBFWJBW7AvaPjOCuhFhj/R4zleUQobyWEE
        Iu6G0lPa/K+I5m+a3qQ==
X-Received: by 2002:a37:f90d:0:b0:6a5:b72e:d2c9 with SMTP id l13-20020a37f90d000000b006a5b72ed2c9mr1770859qkj.490.1653577463896;
        Thu, 26 May 2022 08:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkPj9vt1yaIDEmArpuVLR/LyYP8bM5T3+AmIPptOmEF/whsc9HTr+mbc99YPpVZMLKKNihfg==
X-Received: by 2002:a37:f90d:0:b0:6a5:b72e:d2c9 with SMTP id l13-20020a37f90d000000b006a5b72ed2c9mr1770826qkj.490.1653577463585;
        Thu, 26 May 2022 08:04:23 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e25-20020ac84b59000000b002f39b99f693sm1070962qts.45.2022.05.26.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:04:22 -0700 (PDT)
Date:   Thu, 26 May 2022 23:04:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220526150417.bw3zpwiqcm5fkysn@zlang-mailbox>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524171336.pyoomozstpygnkjt@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524171336.pyoomozstpygnkjt@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 25, 2022 at 01:13:36AM +0800, Zorro Lang wrote:
> On Tue, May 24, 2022 at 01:42:15PM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 12:41 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > Use a local cleanup function and _register_cleanup properly.
> > >
> > > Remove local cleanups that just do what the standard _cleanup and
> > > test exist does.
> > >
> > > Remove local cleanups that just remove test files and then do
> > > standard _cleanup functionality.
> > 
> > As I mentioned in response to the cover letter, the call to _cleanup()
> > can and I think should be chained implicitly, but I am still waiting
> > for your response regarding the tests where generic _cleanup is not
> > desired.
> > 
> > >
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  tests/xfs/004     |  7 -------
> > >  tests/xfs/006     |  7 ++++---
> 
> [snap]
> 
> > > diff --git a/tests/xfs/006 b/tests/xfs/006
> > > index cecceaa3..fd8d8071 100755
> > > --- a/tests/xfs/006
> > > +++ b/tests/xfs/006
> > > @@ -11,11 +11,10 @@
> > >  _begin_fstest auto quick mount eio
> > >
> > >  # Override the default cleanup function.
> > > -_cleanup()
> > > +_dmerror_cleanup()
> > >  {
> > > -       cd /
> > > -       rm -f $tmp.*
> > >         _dmerror_cleanup
> > 
> > That looks recursive.
> 
> Yes, but this _dmerror_cleanup() won't be run. This function will be covered by
> the _dmerror_cleanup() in common/dmerror, when this case ". ./common/dmerror"
> several lines later. So the later _cleanup won't be run. So this place and other
> places similar with this need to change.

Hi Dave,

Are you going to fix this issue or making more changes on this patchset?
If not, I'll merge this patchset tomorrow (Friday) by changing above
_dmerror_cleanup to _dm_error_cleanup. Then give merged patches a regression
on Saturday. What do you think?

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > Again, if the call to _cleanup is implicitly chained then
> > the local function is not needed and trap can call
> > the global _dmerror_cleanup().
> > 
> > > +       _cleanup
> > >  }
> > >
> > >  # Import common functions.
> > > @@ -28,6 +27,8 @@ _require_scratch
> > >  _require_dm_target error
> > >  _require_fs_sysfs error/fail_at_unmount
> > >
> > > +_register_cleanup _dmerror_cleanup
> > > +
> > >  _scratch_mkfs > $seqres.full 2>&1
> > >  _dmerror_init
> > >  _dmerror_mount
> > > diff --git a/tests/xfs/008 b/tests/xfs/008
> > > index a53f6c92..5bef44bb 100755
> > > --- a/tests/xfs/008
> > > +++ b/tests/xfs/008
> > > @@ -12,13 +12,6 @@ _begin_fstest rw ioctl auto quick
> > >  status=0       # success is the default!
> > >  pgsize=`$here/src/feature -s`
> > >
> > > -# Override the default cleanup function.
> > > -_cleanup()
> > > -{
> > > -    rm -f $tmp.*
> > > -    rm -rf $TEST_DIR/randholes.$$.*
> > 
> > It's fine to keep the test files behind, but maybe
> > make that change more clear in commit message
> > because it was not clear to me that there was a change of
> > behavior when I read the commit message.
> > 
> > Sorry to drop this extra burden on you, but this seems
> > important to me and I cannot add this information after the fact.
> > 
> > Also, it was very hard to see in this review if the test files
> > that are not cleaned in cleanup() are cleaned in the beginning
> > of the test or if it is not important to clean them because they
> > are overwritten.
> > 
> > I did my best to try and I think there is a missing cleanup of
> > ${OUTPUT_DIR} in the beginning of xfs/253.
> > Although that may already be considered a test bug, removing
> > the cleanup of ${OUTPUT_DIR} from cleanup() will expose this bug.
> > 
> > [...]
> > 
> > > diff --git a/tests/xfs/051 b/tests/xfs/051
> > > index ea70cb50..4718099d 100755
> > > --- a/tests/xfs/051
> > > +++ b/tests/xfs/051
> > > @@ -11,14 +11,13 @@
> > >  . ./common/preamble
> > >  _begin_fstest shutdown auto log metadata
> > >
> > > -# Override the default cleanup function.
> > > -_cleanup()
> > > +_fsstress_cleanup()
> > >  {
> > > -       cd /
> > > -       rm -f $tmp.*
> > >         $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
> > > -       _scratch_unmount > /dev/null 2>&1
> > > +       wait
> > 
> > All right. I see that cleanup helpers are not consistent
> > in calling wait after kill and in using SIGKILL.
> > I guess we could go either way. So be it.
> > 
> > [...]
> > 
> > > diff --git a/tests/xfs/310 b/tests/xfs/310
> > > index 3214e04b..c635b39a 100755
> > > --- a/tests/xfs/310
> > > +++ b/tests/xfs/310
> > > @@ -9,14 +9,12 @@
> > >  . ./common/preamble
> > >  _begin_fstest auto clone rmap
> > >
> > > -# Override the default cleanup function.
> > > -_cleanup()
> > > +_dmhuge_cleanup()
> > >  {
> > > -       cd /
> > > -       umount $SCRATCH_MNT > /dev/null 2>&1
> > >         _dmhugedisk_cleanup
> > > -       rm -rf $tmp.*
> > > +       _cleanup
> > >  }
> > > +_register_cleanup _dmhuge_cleanup
> > >
> > 
> > 
> > Maybe it's just me, but if the intention is to maybe make this
> > function global someday then the difference with the name
> > _dmhugedisk_cleanup() is confusing.
> > 
> > I'd rather keep the local function name local_cleanup
> > in unclear cases like this one.
> > 
> > Thanks,
> > Amir.
> > 
> > >  }
> > > +_register_cleanup local_cleanup
> > >
> > >  # Import common functions.
> > >  . ./common/filter
> > > --
> > > 2.35.1
> > >
> > 

