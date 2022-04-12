Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B0C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 14:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiDLO2A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356516AbiDLO13 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 10:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 671691BE84
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649773509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCKFUT90PJvjFMINqByybZN74Ru2OP40DweHGCMCYrg=;
        b=cLbBgLe1pitZyiKlqTta6sSeN6qn1sEiOfAgWPqBJfl2rIkgBtsOchdqtELXGrGgj2fxw+
        KYP7dPzggw41GSM8DVsrcLBTaMeUJtgjhhBDyEorgTXLukkGaN0UlYZeH9tQ9ohAjy4QiN
        KdaXImRy7WmzAsBzD77nzrJH5genA2U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-wQo1u5GvNYGMG8cCx9decA-1; Tue, 12 Apr 2022 10:25:08 -0400
X-MC-Unique: wQo1u5GvNYGMG8cCx9decA-1
Received: by mail-qv1-f72.google.com with SMTP id kl19-20020a056214519300b0044454fc4c9bso2380182qvb.7
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 07:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ZCKFUT90PJvjFMINqByybZN74Ru2OP40DweHGCMCYrg=;
        b=WsBjmO2gmKvJw06Q1G1VeQrUEN1LGAxtwu5fQIRU0PGnDphQA8Bs9jCrYEDqZdXU54
         Sjkrww7Npqs7ZJ7uft+PNdS0YxPiWdT4w79C5AoA2OyY0w0TSYNSqaK89TrdbTDqIO9V
         ZSj9aTkYUaN+NDmH+G0fcVe0W5tLj8zXZjQjwHtafCu5lk/94GwbELIFFmvSxXEEN5OO
         MJ1GpCv8uWysgbA7V0Gxo/gr2616kagkV+DSx8bR2jc+SgSQWFnVASF47fNkLqeeoU2l
         OiX+7bKXQIhR36nQwlZjBl/i8GNMaI6oO0M5GrYCsUJUp3anmbcFGKCxe0wuPuE9a1Qu
         jdVQ==
X-Gm-Message-State: AOAM5329tCy4xrpwuhe8Uy65jtg/t+2phOr82IS2w28FKZhHZEs95cTC
        IMj352v8COu6hpI0vhxFa73yxtVNiLJJLREmuAwyt292FLtpZ49JRz91oRhY/2k0JrhbNUeAeDn
        wUiyUjVlQ8JGWg2DN4w==
X-Received: by 2002:ac8:5889:0:b0:2e1:afa2:65a9 with SMTP id t9-20020ac85889000000b002e1afa265a9mr3468457qta.268.1649773507982;
        Tue, 12 Apr 2022 07:25:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJfzuIZVGK+sTIzZd5xP7AQ/LelXggXiuaB9xjVwOW6GBCsrtApJUIrmysXIXYj8XtwjEF+Q==
X-Received: by 2002:ac8:5889:0:b0:2e1:afa2:65a9 with SMTP id t9-20020ac85889000000b002e1afa265a9mr3468432qta.268.1649773507704;
        Tue, 12 Apr 2022 07:25:07 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h186-20020a376cc3000000b00699c789a757sm16169700qkc.132.2022.04.12.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:25:06 -0700 (PDT)
Date:   Tue, 12 Apr 2022 22:25:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412145942.0a268875@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> 
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > If you ctrl-c generic/019, it leaves fsstress processes running.
> > Kill them in the cleanup function so that they don't have to be
> > manually killed after interrupting the test.
> > 
> > While touching the _cleanup() function, make it do everything that
> > the generic _cleanup function it overrides does and fix the
> > indenting.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/generic/019 | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/generic/019 b/tests/generic/019
> > index db56dac1..cda107f4 100755
> > --- a/tests/generic/019
> > +++ b/tests/generic/019
> > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> >  # Override the default cleanup function.
> >  _cleanup()
> >  {
> > -    disallow_fail_make_request
> > -    rm -f $tmp.*
> > +	kill $fs_pid $fio_pid &> /dev/null
> > +	disallow_fail_make_request
> > +	cd /
> > +	rm -r -f $tmp.*
> >  }
> >  
> >  RUN_TIME=$((20+10*$TIME_FACTOR))
> 
> Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> wait, but should be fine as-is:

I agree. Better to avoid killing other system processes. Or how about this place
does (avoid killing system useful processes):
$KILLALL_PROG -q $FSSTRESS_PROG
$KILLALL_PROG -q $FIO_PROG

Another picky question is, do we need to use a while loop checking, until the
processes really get killed? :)

Thanks,
Zorro

> Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> Cheers, David
> 

