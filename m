Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550A9C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Apr 2022 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiDPOOK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiDPOOK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Apr 2022 10:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D7E22BFF
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650118297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsZQLh0eI45jXBeLXRJUH5MAK+BS+EuIvwdynhSRUdk=;
        b=DoOZPfv/ZdWJgCGetkBkLrsxs6gLMsuPuinFbabj/P0IOfBsL8HT6MZW1LZQGNLuJxpi6X
        k2F0hf4Ob0PqV0za1xUG9A7WzB/ccHfTC9WG303+A7HDpoPeWWhAUhBMF/oc8pxU5YPJYc
        BKDBSabOJ12ta/JPOYqxHA8Ol5b/RMw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-_mIBpBO1Mu2uRmbZ827Mng-1; Sat, 16 Apr 2022 10:11:33 -0400
X-MC-Unique: _mIBpBO1Mu2uRmbZ827Mng-1
Received: by mail-qt1-f197.google.com with SMTP id e6-20020ac86706000000b002f1f8ec1f63so226008qtp.5
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 07:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rsZQLh0eI45jXBeLXRJUH5MAK+BS+EuIvwdynhSRUdk=;
        b=mX//Dd2BzI83ClZalSVkGxlTzUY9R9PTnDhXe5/93bxVBODCa2D/NJYPNGGOKRiP0S
         RjaMoeFmabT2f0LsqeMCeG/jHc2tR0bgk3PVlNUVgXD1/jhiHGK9mB2/Axw7qJurwV64
         JupdSmYq3Tmzea/Y/dDgupsbIHTblBgyGMyBeOuFVKhh1zkszrlq9ioHXteJGO5ee2uY
         tF32a2+LWaoYnAKik/7wfKnHTE0xRn4Zvek2nMprFOGNHtWLYTTNvI7KqfNbm0T4yjmJ
         wfPTzmLnpMZ20EVdAI9RYq0YiyqKCVhfamWGpZiUCMQUyn9P0QqAllHuPVb722oMhXMb
         5m2g==
X-Gm-Message-State: AOAM530fFuRVvPtpPC//4d0rU2D6/SAvJ2DkZ8CSGqa2J5eDGvNd2eXj
        doVQfg0fHCjmuAj2ZaKYa5SBhJIoAHRBQHSKIXiaKFRDmmbl2FURoO0RR03H7aun1mjLmVpa+H0
        KqjkZil0yON9cFDfFxg==
X-Received: by 2002:a05:622a:50b:b0:2e1:deae:22dc with SMTP id l11-20020a05622a050b00b002e1deae22dcmr2324324qtx.359.1650118292690;
        Sat, 16 Apr 2022 07:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWuWUp/7+AVAFa1H1gS7lgWb7ZNonUhnJDjnSTd1S4XOtVyxcrCoewKNwIrAcp/jj0/s5vlw==
X-Received: by 2002:a05:622a:50b:b0:2e1:deae:22dc with SMTP id l11-20020a05622a050b00b002e1deae22dcmr2324307qtx.359.1650118292404;
        Sat, 16 Apr 2022 07:11:32 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a099700b0069e5cd89332sm2010030qkx.77.2022.04.16.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 07:11:31 -0700 (PDT)
Date:   Sat, 16 Apr 2022 22:11:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220416141126.wwzvkzyzbvjczfae@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        fstests <fstests@vger.kernel.org>
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
 <20220413002656.GL1609613@dread.disaster.area>
 <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox>
 <20220414191643.5udsx6kdarlumyfn@zlang-mailbox>
 <CAOQ4uxhA7pnfRE6sSQkKOAJRDP1WmNWZBj7T_THQEjYrD7SaxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhA7pnfRE6sSQkKOAJRDP1WmNWZBj7T_THQEjYrD7SaxQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 16, 2022 at 12:20:22PM +0300, Amir Goldstein wrote:
> On Fri, Apr 15, 2022 at 12:56 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Apr 15, 2022 at 12:25:44AM +0800, Zorro Lang wrote:
> > > On Wed, Apr 13, 2022 at 10:26:56AM +1000, Dave Chinner wrote:
> > > > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > > > >
> > > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > > >
> > > > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > > > Kill them in the cleanup function so that they don't have to be
> > > > > > > manually killed after interrupting the test.
> > > > > > >
> > > > > > > While touching the _cleanup() function, make it do everything that
> > > > > > > the generic _cleanup function it overrides does and fix the
> > > > > > > indenting.
> > > > > > >
> > > > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > > > ---
> > > > > > >  tests/generic/019 | 6 ++++--
> > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > > > index db56dac1..cda107f4 100755
> > > > > > > --- a/tests/generic/019
> > > > > > > +++ b/tests/generic/019
> > > > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > > > >  # Override the default cleanup function.
> > > > > > >  _cleanup()
> > > > > > >  {
> > > > > > > -    disallow_fail_make_request
> > > > > > > -    rm -f $tmp.*
> > > > > > > +     kill $fs_pid $fio_pid &> /dev/null
> > > > > > > +     disallow_fail_make_request
> > > > > > > +     cd /
> > > > > > > +     rm -r -f $tmp.*
> > > > > > >  }
> > > > > > >
> > > > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > > > >
> > > > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > > > wait, but should be fine as-is:
> > > > >
> > > > > I agree. Better to avoid killing other system processes. Or how about this place
> > > > > does (avoid killing system useful processes):
> > > > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > > > $KILLALL_PROG -q $FIO_PROG
> > > > >
> > > > > Another picky question is, do we need to use a while loop checking, until the
> > > > > processes really get killed? :)
> > > >
> > > > Do we really need to paint the bikeshed over how best to kill a
> > > > process? I don't have time to do that, this is just a drive-by fix
> > > > that works for me....
> > >
> > > Sure Dave:) The while loop checking is a little picky, I just ask what do you think, no
> > > objection if you don't like that. Due to quick cleanup and exit is a good reason too.
> > >
> > > I think it might be worth doing "$KILLALL_PROG -q $FSSTRESS_PROG $FIO_PROG" at least, to
> > > avoid killing other processes might be useful.
> 
> That has much more likelihood to kill processes not spawn by the test
> then pid wraparound.

Yes, you're right. But generally we don't run xfstests with other testing, to avoid other
testing break dmesg checking of xfstests. (Is there a way to help different process get
independent dmesg out? If there's, I'm very glad to know how to do that, then I can run
xfstests concurrently in one system:)

Anyway, we can choose another way -- "unset'ing the "fs_pid" and "fio_pid" variables
after the wait", both are fine to me.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 
> > > Or as David Disseldorp suggested "unset'ing
> > > the "fs_pid" and "fio_pid" variables after the wait. If you're busy, I can help to make
> > > this simple change, no push :-D
> >
> > Anyway, we'll change this a little bit when merge it.
> >
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >
> > > > -Dave.
> > > > --
> > > > Dave Chinner
> > > > david@fromorbit.com
> > > >
> >
> 

