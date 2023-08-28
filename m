Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0325C71153
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Aug 2023 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjH1OZy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjH1OZg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 10:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8FDA
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693232686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oG9oNvWY8HbPPjSVQ5F379whN33FwG9oaIZiEO9AxAs=;
        b=gVVk+ymi9HLl82xGyiYgJ/73Afi9+c3HhTzIRsdp8R9Ne8xZ0rUnVi9uRwKcOVATcuXQH/
        RtrG5/xVsO99S4y3OGrXPyn9/2kY3BYRij5kR3ndibsX+ijkKtJFmpV442VGQWj27xfwL+
        kBNQcf113IMpvtqGLMynXmc55Ml10GU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-nuBWwDfGN8C1t_-QdGM5nQ-1; Mon, 28 Aug 2023 10:24:45 -0400
X-MC-Unique: nuBWwDfGN8C1t_-QdGM5nQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d5970cbdbso3619500a91.0
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 07:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232684; x=1693837484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG9oNvWY8HbPPjSVQ5F379whN33FwG9oaIZiEO9AxAs=;
        b=TiwX17//Fmh3R6FBd2DM8VPU+Tib62RY9nbAWba7HkdCIisQnR3SCTleC8iteditKo
         W97c0jXWX0fblb9KCaQudo4Mh5pk+WJpNr69UHCEvXZ9uSMKw0dsBo3yOGrJGYQTCjzA
         mXg2CtjwBZJxn2Z7M5Y23nfPMt9lMSaH/Qt+7WjuERqdt5owgyT0iEBa9OpyvF24Z1IJ
         ecl5FjDbsuq7aYCB8DN3hnQUx3ciLYTTquc1GVQQIZEdcwTvXR1ct218TNT2fPsxAr7q
         ysm2sp5T1yYbN/WPMd6RtAcQjABZquOPkqrSE2xbws19cSYE1GxLCvIc1eTJly/PItx4
         vo0A==
X-Gm-Message-State: AOJu0YwkfN+JHK1LMEF4PVIHWn4EErQFeKuIsQe4P3Qwgpg3/x+tcZjw
        KpTFuuei1rmtou8URSUbV8KZr1XNrV3ZQwwQdguNnw47ox7Njd7Pz5XIrfuBhgPq6Dky15ZsRjx
        8lTFzeU79jfTEBOnzSQ==
X-Received: by 2002:a17:90a:c783:b0:26b:66f7:c9be with SMTP id gn3-20020a17090ac78300b0026b66f7c9bemr23094462pjb.10.1693232684252;
        Mon, 28 Aug 2023 07:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHw8WJwCvI5EfN/K6jpKiuJZTgN8gBUA24FVVc6qQdhuqFjXon24rig77aFBY/JPBmOE8zTw==
X-Received: by 2002:a17:90a:c783:b0:26b:66f7:c9be with SMTP id gn3-20020a17090ac78300b0026b66f7c9bemr23094446pjb.10.1693232683937;
        Mon, 28 Aug 2023 07:24:43 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a394400b002684b837d88sm7735272pjf.14.2023.08.28.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:24:43 -0700 (PDT)
Date:   Mon, 28 Aug 2023 22:24:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
Subject: Re: [RFC PATCH] fstests: test fix for an agbno overflow in
 __xfs_getfsmap_datadev
Message-ID: <20230828142440.q5p4r2gphukyfnbu@zlang-mailbox>
References: <20230823010046.GD11286@frogsfrogsfrogs>
 <20230823010239.GE11263@frogsfrogsfrogs>
 <20230827130644.nhdi6ihobn5qne3a@zlang-mailbox>
 <20230827155646.GA28202@frogsfrogsfrogs>
 <ZOv/25JEPQblNx1n@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOv/25JEPQblNx1n@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 28, 2023 at 12:00:59PM +1000, Dave Chinner wrote:
> On Sun, Aug 27, 2023 at 08:56:46AM -0700, Darrick J. Wong wrote:
> > On Sun, Aug 27, 2023 at 09:06:44PM +0800, Zorro Lang wrote:
> > > On Tue, Aug 22, 2023 at 06:02:39PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > Dave Chinner reported that xfs/273 fails if the AG size happens to be an
> > > > exact power of two.  I traced this to an agbno integer overflow when the
> > > > current GETFSMAP call is a continuation of a previous GETFSMAP call, and
> > > > the last record returned was non-shareable space at the end of an AG.
> > > > 
> > > > This is the regression test for that bug.
> > > > 
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> .....
> > > > +echo "desired asize=$desired_agsize" >> $seqres.full
> > > > +_scratch_mkfs -d "agsize=${desired_agsize}b" | _filter_mkfs 2> $tmp.mkfs >> $seqres.full
> > > > +source $tmp.mkfs
> > > > +
> > > > +test "$desired_agsize" -eq "$agsize" || _notrun "wanted agsize=$desired_agsize, got $agsize"
> > > > +
> > > > +_scratch_mount
> > > > +$XFS_IO_PROG -c 'fsmap -n 1024 -v' $SCRATCH_MNT >> $tmp.big
> > > > +$XFS_IO_PROG -c 'fsmap -n 1 -v' $SCRATCH_MNT >> $tmp.small
> > > 
> > > This line reports:
> > > 
> > >   xfs_io: xfsctl(XFS_IOC_GETFSMAP) iflags=0x0 ["/mnt/xfstests/scratch"]: Invalid argument
> > > 
> > > when the test case fails. Is that normal?
> > 
> > Yes.  The attached bugfix should make that go away.
> 
> The kernel bug fix fixes the same problem with xfs/273; I haven't
> tested this specific new regression test.

Thanks for the details from both of you, I'll merge this patch in next fstests
release if there's not more updates.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

