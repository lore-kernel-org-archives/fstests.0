Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B738C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 15:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbiEJPsR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 11:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiEJPsN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 11:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF3D281347
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652197448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAS1avXWgT/iTNldK5a2r3A+R8xrqOB9hbTmJ0/08G4=;
        b=EOJwTDzH/omzhCv9sLOSnkHZ/hPp8pJwUhmrXTJSjET1bFGyLN2yPwmlClEp7zD3AL7Kbu
        RRwIgfqzJV5oaQu6DokWuGREdJdJmT5Byz+lhc1UARBAd3FZ6BXDinT1b3vuqS5zHDKRf7
        r5c9qfQGhQZ/aXnPgpgsbsB9x6evcZo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-sRbyeKfNMbuFAhRHLH6fRQ-1; Tue, 10 May 2022 11:44:06 -0400
X-MC-Unique: sRbyeKfNMbuFAhRHLH6fRQ-1
Received: by mail-qt1-f197.google.com with SMTP id d8-20020a05622a05c800b002f3bb450e94so13219978qtb.2
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 08:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QAS1avXWgT/iTNldK5a2r3A+R8xrqOB9hbTmJ0/08G4=;
        b=feTIMCK/v8eNENqpihmLp4qbtvq+MgE3NVnUax3KBYrB7hqiacWYLLmPX1c+hsPwcr
         xT9g8suHep6UoLEFHjSqPdbK2CWECbxt9j+jdbqaL6Lq+NfAkPEeMLRksf2+tZFctC5N
         HqJ0wTF1GuwTQY62YUtLLsKZF6zQ8MOdoYWLnJBDxU6H7fpnI6G5p1Aew8L6/B68fbxM
         PsSvvYR2YOboxx1JfdZ7mcSf/6k8czfEPz+Qz0orrk2zwkmg3YH+Upj359mcbVMneE6F
         hyEoCCTMXxrjMGNvK5ByB9HpzxNWZzhPVSPq9qLFSnm7A8fdRQJPCJfi+ymwPBvyDLDk
         qs6A==
X-Gm-Message-State: AOAM533L1FgOkaYdFX6fBd2X0Wrz7/y3FTid5J3AUdxw68qb44kI9y/i
        EsEZNg6zMgywb3hh/+NrHVpIXKNtGzzzhFXEfdIGIy9IP12/YifiopEatlsmDyG5dHSQvWSWNwI
        s7fTBxjjMB/VFcNfSsQ==
X-Received: by 2002:a05:622a:549:b0:2f3:e1cb:408f with SMTP id m9-20020a05622a054900b002f3e1cb408fmr5116964qtx.445.1652197445907;
        Tue, 10 May 2022 08:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQuGtFstNmojqM8gViCc1xi6AXUEr+Z6/xDpP+R/Hx6VUnSdhyPlb7wtker7kZeRlLrGnnbA==
X-Received: by 2002:a05:622a:549:b0:2f3:e1cb:408f with SMTP id m9-20020a05622a054900b002f3e1cb408fmr5116951qtx.445.1652197445632;
        Tue, 10 May 2022 08:44:05 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8364562qkk.103.2022.05.10.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:44:05 -0700 (PDT)
Date:   Tue, 10 May 2022 23:43:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Message-ID: <20220510154359.xfhmumcmb4o37qdy@zlang-mailbox>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20220430192130.131842-1-ebiggers@kernel.org>
 <Ynmmy+bWp0Q1/747@sol.localdomain>
 <20220510094308.mhzvcgq5wrat5qao@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510094308.mhzvcgq5wrat5qao@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 10, 2022 at 11:43:08AM +0200, Lukas Czerner wrote:
> On Mon, May 09, 2022 at 04:42:03PM -0700, Eric Biggers wrote:
> > On Sat, Apr 30, 2022 at 12:21:30PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > 'not_mnt OPTIONS' seems to have been intended to test that the
> > > filesystem cannot be mounted at all with the given OPTIONS, meaning that
> > > the mount fails as opposed to the options being ignored.  However, this
> > > doesn't actually work, as shown by the fact that the test case 'not_mnt
> > > test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
> > > Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
> > > (The ext4 behavior might be changed, but that is besides the point.)
> > > 
> > > The problem is that the do_mnt() helper function is being misused in a
> > > context where a mount failure is expected, and it does some additional
> > > remount tests that don't make sense in that context.  So if the mount
> > > unexpectedly succeeds, then one of these later tests can still "fail",
> > > causing the unexpected success to be shadowed by a later failure, which
> > > causes the overall test case to pass since it expects a failure.
> > > 
> > > Fix this by reworking not_mnt() and not_remount_noumount() to use
> > > simple_mount() in cases where they are expecting a failure.  Also fix
> > > up some of the naming and calling conventions to be less confusing.
> > > Finally, make sure to test that remounting fails too, not just mounting.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
> > >  1 file changed, 78 insertions(+), 70 deletions(-)
> > 
> > Lukas, any thoughts on this patch?  You're the author of this test.
> > 
> > - Eric
> 
> Haven't tested it myself but the change looks fine, thanks.

Thanks for you help to review this patch. There's an new failure[1] after we
merged this patch:
  "SHOULD FAIL remounting ext2 "commit=7" (remount unexpectedly succeeded) FAILED"

As this test generally passed, so before I give "Oops" to others, I hope to
check with you that if this's an expected failure we need to fix in kernel
or in this case itself?

Thanks,
Zorro

> 
> You can add
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> 

