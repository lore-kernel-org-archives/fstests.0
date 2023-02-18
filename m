Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A889C61DA4
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 06:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBRG1j (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRG1i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 01:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B075B75E
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676701608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l+/JHvh3v2kM5JmoBxRETigZRw4N8ej8MOHILKPPUtg=;
        b=iI2TzLgV3FeufneOSCiUys4FyOaHf8y5V7ZLJ3NPFN/2key6BGc1EHPaYhsdwrfDIm+UVr
        FW4ynRKSvifXCm5bV1MpahLJJUPnuLdbh6xVpx6jx2wWCL7pbB/C8R3eh+5irfs4i0A9Id
        xLdxPhQeOSvexvBStTwUTTgyB0/jzfA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-BeQQQXCqNg-_5YnrYGkh_g-1; Sat, 18 Feb 2023 01:26:47 -0500
X-MC-Unique: BeQQQXCqNg-_5YnrYGkh_g-1
Received: by mail-pj1-f69.google.com with SMTP id o9-20020a17090a744900b002310ecae757so54546pjk.1
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+/JHvh3v2kM5JmoBxRETigZRw4N8ej8MOHILKPPUtg=;
        b=2UUkkkXMKly9hFzWh9M26w2+JbiXxQ4ZHxHndNKo0oITIncgCuNrEbHY3IK5NEIVLf
         rllnXg7JDCU0EngwqHL22OVdTP4pgehcoIweCrTOLqsXxsPgodvtLjHP8KctCD9Tedg2
         B/oWfdxz6z++0dyN4X/Rj3t9TbUnkXfKQsvtg8/hSn+NsjOFk4CWZ6ytt+VAjKZJzkFj
         mXNbPWXdK5HHQyVKnoH2my0w1WieoV6fQRSfPKywftONUXTyyFckMWTbs+8GVlD6Cbka
         WY4aKJLGBskn1lJQ9PoDCL7SOackqP6vluXmV+gaaehKJIsjtevjQO6+5BKPjCDvwSxZ
         x87g==
X-Gm-Message-State: AO0yUKUFbHyevEakZfoWuu/CNV5F7RBMWi0uAsq8KtkYKqNk6/hOxqsf
        SuUt8VnZknvb+4sf5/5BMtPNIt8KolGNJnCJY6ozjL3TJWqdESITLvIM3/0CC6rw7nxByCiap5p
        RZIOjXf8Vprc5QcBvcsJTVPFztA==
X-Received: by 2002:a17:90b:4c87:b0:233:c1b5:31f1 with SMTP id my7-20020a17090b4c8700b00233c1b531f1mr3757751pjb.23.1676701606153;
        Fri, 17 Feb 2023 22:26:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/Skvf5FjJnhEm6YgtMLoX7HWrd7tHWH/Rsd+gjfe+LfL/wv3GAILjnghGIu9TIujtaemf02A==
X-Received: by 2002:a17:90b:4c87:b0:233:c1b5:31f1 with SMTP id my7-20020a17090b4c8700b00233c1b531f1mr3757734pjb.23.1676701605765;
        Fri, 17 Feb 2023 22:26:45 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090a590e00b0022bb6d75a6fsm595924pji.15.2023.02.17.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:26:45 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:26:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] README: Add tiny note concerning required scratch
 devs for btrfs testing
Message-ID: <20230218062641.vbfvo6lqfgtwiyth@zlang-mailbox>
References: <20230131123839.16084-1-gniebler@suse.com>
 <20230131123839.16084-3-gniebler@suse.com>
 <20230206145207.kik5cczepdlgmexa@zlang-mailbox>
 <f8d78191-089f-4407-dd2d-17f7e3be2580@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d78191-089f-4407-dd2d-17f7e3be2580@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 06, 2023 at 05:29:14PM +0100, Gabriel Niebler wrote:
> Am 06.02.23 um 15:52 schrieb Zorro Lang:
> > On Tue, Jan 31, 2023 at 01:38:39PM +0100, Gabriel Niebler wrote:
> > > Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> > > ---
> > >   README | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/README b/README
> > > index 008d3875..574cdd34 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -127,7 +127,7 @@ Setup Environment
> > >       - device contents will be destroyed.
> > >   4. (optional) Create SCRATCH device pool.
> > > -    - needed for BTRFS testing
> > > +    - needed for BTRFS testing (some tests require up to 5 disks of 10GB each)
> > 
> > Not sure about this part, so btrfs recommend 5 disks of 10GB each in
> > SCRATCH_DEV_POOL, to run all btrfs related tests? Does anyone know that?
> > Or can you provide the subcase names which need "5 disks of 10GB each",
> > to help to check and review?
> 
> Of course (and thanks for asking, as it turns out my recollection was
> slightly wrong on that one):
> 
> To begin with, btrfs/011[1] states the "5 disks" requirement in the lengthy
> comment at the top of the file:
> """
> # The amount of tests done depends on the number of devices in the
> # SCRATCH_DEV_POOL. For full test coverage, at least 5 devices should
> # be available (e.g. 5 partitions).
> ""
> ... but it doesn't say anything about device size.
> 
> btrfs/027[2] however checks the presence of 5 devices in $SCRATCH_DEV_POOL
> directly in code and also runs a check to ensure that all of these devices
> are *of the same size*.
> 
> And then there are at least two tests that require $SCRATCH_DEV to be 10GB
> or more in size:
> - btrfs/079[3], which writes a 10G file to $SCRATCH_MNT and
> - btrfs/253[4], which directly creates a 10G FS on $SCRATCH_DEV.
> 
> *Taken together*, this means that for full btrfs test coverage, one needs a
> $SCRATCH_DEV_POOL with at least 5 devices of equal size in it and that size
> has to be at least 10GB.
> 
> But that makes the remark wrong, strictly speaking, as there's no single
> test that requires "at least 5 devices of 10GB each".
> 
> How about this: "(for full btrfs test coverage, use at least 5 devices of
> equal size and at least 10GB)"

Even for now 10GB is enough, but we can't always assue that. There's not a clear
restriction about that. I think we can skip this sub-patch. At least we don't
give others a recommendation which isn't assured by ourselves. So how about only
merge the 1st patch.

> 
> > P.S. I'm thinking about if this "(...)" should be moved to below item.
> >                                                          vvvvv
> > >       - specifies 3 or more independent SCRATCH devices via the SCRATCH_DEV_POOL
> > >         variable e.g SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc"
> 
> Fine by me! :-)
> 
> [1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/011#n10
> [2]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/027#n20
> [3]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/079#n44
> [4]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/253#n90
> 

