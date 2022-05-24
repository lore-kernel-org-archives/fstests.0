Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E84C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 17:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiEXROW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEXROW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 13:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C01941BF
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653412460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUhW5CvNY8a64qUqwXy0rKtPC7EKS1LgfIisttbIjq0=;
        b=IhbCJYnB9jdYmZVRXxs/2h9vWS6+e9VvaugKWemlXA0vpstRYTZpUNTjSMIjifZKYOA7Hl
        z1zcdYWvtHHEybsb8LsXqeMXeCzxCL3Tjq3H6hwD8edn5HDqcskfDDkQiOw4FYhHYs07zs
        DbT6sh00n2AAsqfgatVeCk4HMm8VzDo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-uVj2DdhxMJuidUzB_IEZyw-1; Tue, 24 May 2022 13:13:43 -0400
X-MC-Unique: uVj2DdhxMJuidUzB_IEZyw-1
Received: by mail-oi1-f199.google.com with SMTP id w3-20020acadf03000000b0032b02f1a1a0so4798215oig.1
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 10:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nUhW5CvNY8a64qUqwXy0rKtPC7EKS1LgfIisttbIjq0=;
        b=exjFwb3mZDp+IjHV5d52LDyGoJHFVrDeEhLah0st2pck/f1Tfy6q6YpYEOD5uvWiFH
         Gq1J8mSIGq9hD5NQnI8kgJ4sEaacBfPdyM/9iLivKJESA2TtRsRF1+wC2GonXl/hxb3j
         nAAFOZArfSNC5Vn6UBsSa7W+PrmTqiG2zDeUUFDDKa+puN+kVkF/ZobBgjuWwLyzzGGb
         Vv4oXn4BIFrVqOd/Sn9zRwHWD8viZNlfoIpHlqDEIrtBPXjqJTIebI71JuJ+KX2OQz4X
         l4v/C3d2eSoHm4TGdFPt8UKujwmKkiIvVhiB5SRFqzXqJBOAINdRZmptLLAFq3GXmL2E
         oqPQ==
X-Gm-Message-State: AOAM533h9sYMZ7NTpBEIlLuV4O5hGXPPzXqfRKrZ4I+iRuBQBSlxHn4E
        NzdeKKMcg+6l4TZpDza+3IgRSDssBOqv0VHgCgYKzHOIr26A898r851JIOcnJkZHz4FOuJ1IJGn
        9n1ODmh7RMXd5OD+log==
X-Received: by 2002:a05:6808:219c:b0:326:4456:d0be with SMTP id be28-20020a056808219c00b003264456d0bemr2771273oib.79.1653412422301;
        Tue, 24 May 2022 10:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHzD/NXwizF9tJH7QkSr+f8kKDKzm1v4BC77f6yVou7cI809aAbwIuxB2hhCFqcEpIJYO9aw==
X-Received: by 2002:a05:6808:219c:b0:326:4456:d0be with SMTP id be28-20020a056808219c00b003264456d0bemr2771259oib.79.1653412421963;
        Tue, 24 May 2022 10:13:41 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t5-20020a056871054500b000e686d1386asm5095062oal.4.2022.05.24.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 10:13:41 -0700 (PDT)
Date:   Wed, 25 May 2022 01:13:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220524171336.pyoomozstpygnkjt@zlang-mailbox>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 01:42:15PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 12:41 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Use a local cleanup function and _register_cleanup properly.
> >
> > Remove local cleanups that just do what the standard _cleanup and
> > test exist does.
> >
> > Remove local cleanups that just remove test files and then do
> > standard _cleanup functionality.
> 
> As I mentioned in response to the cover letter, the call to _cleanup()
> can and I think should be chained implicitly, but I am still waiting
> for your response regarding the tests where generic _cleanup is not
> desired.
> 
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/xfs/004     |  7 -------
> >  tests/xfs/006     |  7 ++++---

[snap]

> > diff --git a/tests/xfs/006 b/tests/xfs/006
> > index cecceaa3..fd8d8071 100755
> > --- a/tests/xfs/006
> > +++ b/tests/xfs/006
> > @@ -11,11 +11,10 @@
> >  _begin_fstest auto quick mount eio
> >
> >  # Override the default cleanup function.
> > -_cleanup()
> > +_dmerror_cleanup()
> >  {
> > -       cd /
> > -       rm -f $tmp.*
> >         _dmerror_cleanup
> 
> That looks recursive.

Yes, but this _dmerror_cleanup() won't be run. This function will be covered by
the _dmerror_cleanup() in common/dmerror, when this case ". ./common/dmerror"
several lines later. So the later _cleanup won't be run. So this place and other
places similar with this need to change.

Thanks,
Zorro

> Again, if the call to _cleanup is implicitly chained then
> the local function is not needed and trap can call
> the global _dmerror_cleanup().
> 
> > +       _cleanup
> >  }
> >
> >  # Import common functions.
> > @@ -28,6 +27,8 @@ _require_scratch
> >  _require_dm_target error
> >  _require_fs_sysfs error/fail_at_unmount
> >
> > +_register_cleanup _dmerror_cleanup
> > +
> >  _scratch_mkfs > $seqres.full 2>&1
> >  _dmerror_init
> >  _dmerror_mount
> > diff --git a/tests/xfs/008 b/tests/xfs/008
> > index a53f6c92..5bef44bb 100755
> > --- a/tests/xfs/008
> > +++ b/tests/xfs/008
> > @@ -12,13 +12,6 @@ _begin_fstest rw ioctl auto quick
> >  status=0       # success is the default!
> >  pgsize=`$here/src/feature -s`
> >
> > -# Override the default cleanup function.
> > -_cleanup()
> > -{
> > -    rm -f $tmp.*
> > -    rm -rf $TEST_DIR/randholes.$$.*
> 
> It's fine to keep the test files behind, but maybe
> make that change more clear in commit message
> because it was not clear to me that there was a change of
> behavior when I read the commit message.
> 
> Sorry to drop this extra burden on you, but this seems
> important to me and I cannot add this information after the fact.
> 
> Also, it was very hard to see in this review if the test files
> that are not cleaned in cleanup() are cleaned in the beginning
> of the test or if it is not important to clean them because they
> are overwritten.
> 
> I did my best to try and I think there is a missing cleanup of
> ${OUTPUT_DIR} in the beginning of xfs/253.
> Although that may already be considered a test bug, removing
> the cleanup of ${OUTPUT_DIR} from cleanup() will expose this bug.
> 
> [...]
> 
> > diff --git a/tests/xfs/051 b/tests/xfs/051
> > index ea70cb50..4718099d 100755
> > --- a/tests/xfs/051
> > +++ b/tests/xfs/051
> > @@ -11,14 +11,13 @@
> >  . ./common/preamble
> >  _begin_fstest shutdown auto log metadata
> >
> > -# Override the default cleanup function.
> > -_cleanup()
> > +_fsstress_cleanup()
> >  {
> > -       cd /
> > -       rm -f $tmp.*
> >         $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
> > -       _scratch_unmount > /dev/null 2>&1
> > +       wait
> 
> All right. I see that cleanup helpers are not consistent
> in calling wait after kill and in using SIGKILL.
> I guess we could go either way. So be it.
> 
> [...]
> 
> > diff --git a/tests/xfs/310 b/tests/xfs/310
> > index 3214e04b..c635b39a 100755
> > --- a/tests/xfs/310
> > +++ b/tests/xfs/310
> > @@ -9,14 +9,12 @@
> >  . ./common/preamble
> >  _begin_fstest auto clone rmap
> >
> > -# Override the default cleanup function.
> > -_cleanup()
> > +_dmhuge_cleanup()
> >  {
> > -       cd /
> > -       umount $SCRATCH_MNT > /dev/null 2>&1
> >         _dmhugedisk_cleanup
> > -       rm -rf $tmp.*
> > +       _cleanup
> >  }
> > +_register_cleanup _dmhuge_cleanup
> >
> 
> 
> Maybe it's just me, but if the intention is to maybe make this
> function global someday then the difference with the name
> _dmhugedisk_cleanup() is confusing.
> 
> I'd rather keep the local function name local_cleanup
> in unclear cases like this one.
> 
> Thanks,
> Amir.
> 
> >  }
> > +_register_cleanup local_cleanup
> >
> >  # Import common functions.
> >  . ./common/filter
> > --
> > 2.35.1
> >
> 

