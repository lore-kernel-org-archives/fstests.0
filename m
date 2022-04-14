Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C6C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 16:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiDNQ42 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiDNQ4Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 12:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC67E141FE2
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649953553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LoabqgGvNBngbB7VQtnEIXqw5yMwZ+3QMOHT+ZvAr08=;
        b=GPRcwIM7+a6VhBwG+ykrBocDqLXKoCE/UdGpBLtjs6MoLhvO3o3FceUlhwwNo306xyH6gR
        gDlzGMNH0uRRfIIg7GDDJeGZJ3yOSX1CCJ3y70dBCoSWJTnUMYp4w6EtEKVpqGCw8cgO/U
        F7QJVsPX0VdBUNDQvF33MQCaM325R9g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-7bs6zB8gPqyiRJwf7LHiWw-1; Thu, 14 Apr 2022 12:25:51 -0400
X-MC-Unique: 7bs6zB8gPqyiRJwf7LHiWw-1
Received: by mail-qk1-f200.google.com with SMTP id de26-20020a05620a371a00b00699f7065b5cso3608355qkb.5
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 09:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LoabqgGvNBngbB7VQtnEIXqw5yMwZ+3QMOHT+ZvAr08=;
        b=JAHjA6dM33k7brvA5sQ8n6uqEYziDMTqYiszaLdcMX5h+NZIfCeEuPkUow3iQ3W6BU
         afzkBXWxraZSBcGbwnAA+wLRuATQjbscllFPC38FSX+1TJFjfuFPNl+ZIO7T2qYUY8mN
         yYg+HSDRyTFaX52BViqop8jLYdNjoJKRiJmZc6BeYxE4r5Me20vozGBnn4lRReRZL9FS
         hyJL2M29msh5jmNi5vVbgcgSDqrvCJYuU1CYTDQ4M6co9CDGKP7xb40aQpUke7lKWnqx
         tT2zn3ZAKSWQYV1SjyS6FgHi99hPL8o/159/lQ3g8d8LvlhO6qbBWSXaW5D0dE6WqE1o
         yx8w==
X-Gm-Message-State: AOAM531kx8Ayz+yxxEoVwgFh/nP5HpCqyUsxTiFSixuINwEAP+nRQr8w
        2iGBEQLyjSY57ZNEEmRC71DQvgY/9CHokIFvujzf8WRRSuyN/1TlIYV8VDUV0cdAzFGsWSlBj6G
        j7Xy5XQPt80+I/WUXnw==
X-Received: by 2002:a05:620a:40c8:b0:67d:a9d3:f412 with SMTP id g8-20020a05620a40c800b0067da9d3f412mr2507226qko.183.1649953551074;
        Thu, 14 Apr 2022 09:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz76xVVqqR9Wps/0y+HidYAz2xFBMOBAsY77hY1qCMtZQTbn60NfFop0TkxuDr84KqlYcpnqQ==
X-Received: by 2002:a05:620a:40c8:b0:67d:a9d3:f412 with SMTP id g8-20020a05620a40c800b0067da9d3f412mr2507209qko.183.1649953550828;
        Thu, 14 Apr 2022 09:25:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d17-20020a05622a101100b002ed11f71ed9sm1386412qte.17.2022.04.14.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:25:50 -0700 (PDT)
Date:   Fri, 15 Apr 2022 00:25:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
 <20220413002656.GL1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413002656.GL1609613@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 13, 2022 at 10:26:56AM +1000, Dave Chinner wrote:
> On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > 
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > Kill them in the cleanup function so that they don't have to be
> > > > manually killed after interrupting the test.
> > > > 
> > > > While touching the _cleanup() function, make it do everything that
> > > > the generic _cleanup function it overrides does and fix the
> > > > indenting.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > >  tests/generic/019 | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > index db56dac1..cda107f4 100755
> > > > --- a/tests/generic/019
> > > > +++ b/tests/generic/019
> > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > >  # Override the default cleanup function.
> > > >  _cleanup()
> > > >  {
> > > > -    disallow_fail_make_request
> > > > -    rm -f $tmp.*
> > > > +	kill $fs_pid $fio_pid &> /dev/null
> > > > +	disallow_fail_make_request
> > > > +	cd /
> > > > +	rm -r -f $tmp.*
> > > >  }
> > > >  
> > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > 
> > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > wait, but should be fine as-is:
> > 
> > I agree. Better to avoid killing other system processes. Or how about this place
> > does (avoid killing system useful processes):
> > $KILLALL_PROG -q $FSSTRESS_PROG
> > $KILLALL_PROG -q $FIO_PROG
> > 
> > Another picky question is, do we need to use a while loop checking, until the
> > processes really get killed? :)
> 
> Do we really need to paint the bikeshed over how best to kill a
> process? I don't have time to do that, this is just a drive-by fix
> that works for me....

Sure Dave:) The while loop checking is a little picky, I just ask what do you think, no
objection if you don't like that. Due to quick cleanup and exit is a good reason too.

I think it might be worth doing "$KILLALL_PROG -q $FSSTRESS_PROG $FIO_PROG" at least, to
avoid killing other processes might be useful. Or as David Disseldorp suggested "unset'ing
the "fs_pid" and "fio_pid" variables after the wait. If you're busy, I can help to make
this simple change, no push :-D

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

