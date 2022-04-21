Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E1C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbiDUPiR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390166AbiDUPiQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 11:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5397845061
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650555325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfsyDGpfuWG2+tCkMqfo7UCg0ZtLjkT4NCmc9yJNeVM=;
        b=ArWABV9AoSy8F/pdc55lyiJPJGb/f8E0/R2EdLV72COv0KKY8IkrbTHwZFipb6WL3R3L9h
        O3QhVAcQBm8E0uK21B2MscA53mWniZubH6BTaiyFM3kNZBpaox/oObUM5895hf3nxWyEkg
        DAWl9M5R2XHT8bxS3CbULEqYDeq/ymw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-1c__Z1MTNiSs7YcdC1Uc8g-1; Thu, 21 Apr 2022 11:35:22 -0400
X-MC-Unique: 1c__Z1MTNiSs7YcdC1Uc8g-1
Received: by mail-qv1-f69.google.com with SMTP id cs5-20020ad44c45000000b004463a27fb3fso4219857qvb.9
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 08:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QfsyDGpfuWG2+tCkMqfo7UCg0ZtLjkT4NCmc9yJNeVM=;
        b=JXAiscOUECxrhgXN3FUVnKpZqsgMNTYKbyA2RrcqcwR7Qq3Umi/5qUZmFkA7YHcS2k
         3tDxfSGAO4Yx67XV62PxGulNYrZQmkX1XCQwZ9wZL8+sqzubeoHzLV/OjkJFyyjidpB0
         oEQl1bmKk+iTxOJRPUHPrUXqi8fEyvgw34jfdBxYjEe3HnybrdXwbLE/cKt6Yjt99kmr
         PAYI+ABKwgiHddZ2nqIRw4m+bHhZadSbqu88+EWoxJjWyWHf3GZ20D4RDkTD9eSmosTR
         k/MVUAv+Tyk4RWqld4JbbOgL/5Q6WI4bE1YFrYex0IFbVBPLfCS+dHmI73igE6qQ9qHB
         oSMw==
X-Gm-Message-State: AOAM531+DPvBVcZZlXt2Zi1GuQ4l4XumB26Ofaqo4OAXYgNLyXMoVFap
        jNRaLG3+iCTVxWgo3OfmILfl3iZoJrguXPNz5dBOWUG06jr6lqCNOJftxtBjvJg3WedQ4T1328N
        yNR9i/UxiHO2igD9ugQ==
X-Received: by 2002:a05:6214:c2c:b0:443:5663:12a6 with SMTP id a12-20020a0562140c2c00b00443566312a6mr261904qvd.113.1650555321340;
        Thu, 21 Apr 2022 08:35:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo/8RRdOIatoXK0eLRNBkdUtrVkZgBd8S6pk5esi2ZIt+PcznngXilhX4UU1xOWj5yA1fXxA==
X-Received: by 2002:a05:6214:c2c:b0:443:5663:12a6 with SMTP id a12-20020a0562140c2c00b00443566312a6mr261875qvd.113.1650555321080;
        Thu, 21 Apr 2022 08:35:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a00cc00b002ebdd6ef303sm3691871qtw.43.2022.04.21.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:35:20 -0700 (PDT)
Date:   Thu, 21 Apr 2022 23:35:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421153513.frp7xdbejsoawews@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
References: <20220419131423.2367795-1-brauner@kernel.org>
 <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
 <20220421085942.GR1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421085942.GR1609613@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 06:59:42PM +1000, Dave Chinner wrote:
> On Thu, Apr 21, 2022 at 01:41:20PM +0800, Zorro Lang wrote:
> > On Wed, Apr 20, 2022 at 07:52:22PM +0200, Christian Brauner wrote:
> > > Add a regression test for commit 705191b03d50 ("fs: fix acl translation").
> > > This tests whether setting POSIX ACLs on a tmpfs mounted in a
> > > non-initial user and mount namespace works as expected.
> > > 
> > > Note, once again the idmapped mount testsuite is grossly misnamed at
> > > this point. It has morphed into a full-blown generic vfs feature
> > > testsuite.
> 
> Yup, and that's really important because this is the exact purpose
> for which fstests exists: to cover every aspect of filesystem and
> VFS functionality that needs test coverage.
> 
> > Hi,
> > 
> > Good to know that, the idmapped-mounts things already been extended to 15k+
> > lines[1] code, it's even much more than the unionmount-testsuite[2]. So I
> > think it's time to think about shifting it from fstests/src to be an independent
> > testsuit,
> 
> Please don't do that. That will mean the testing most fs developers
> will get -zero- idmapped-mount test coverage and that's a major
> issue. The kernel code that it covers is non trivial, has deep hooks
> into every filesystem and these tests ensure that we filesystem
> developers don't accidentally break it. It *needs* to be a part of
> every filesystem developer's test environment, and we already have
> that by having it integrated into fstests.

Sure, I won't do that wilfully, just try to ask how we can improve this
huge and 'keep growing' idmapped-mounts.c, not tend to remove the whole
idmapped-mount testing coverage :)

I agree with you, fstests won't reduce existed fs testing coverage, or
much more carefully to do that if have to do. fstests will be more compatible,
And welcome more contributors choose fstests to be their regression
testsuite.

Thanks,
Zirong

> 
> This is what we want - we want fstests to be the place that fs
> developers add new tests to cover new functionality, and so all
> filesystems get coverage of that functionality as part of the
> development process.
> 
> This is exactly what we've spent the last 20 years building xfstests
> into - it's gone from a filesystem specific tests suite to
> supporting a dozen different filesystems and covers heaps of VFS
> functionality as well.
> 
> As such, I think the last thing we want to be doing is telling
> people to "take their code elsewhere". It sends the wrong message -
> we want people to incorporate their complex test code into fstests
> because that benefits every developer who uses fstests in their
> daily workflow. The more test coverage we get, the better, and the
> more test code we get integrated into fstests the better off we will
> be.
> 
> > we can learn what 35c7a37928fd ("overlay: run unionmount testsuite test
> > cases") did, maintain idmapped-mounts testsuite outside, then let fstests to be a
> > wrapper to run it.
> 
> The unionmount tests suite was never a part of fstests like the
> idmapped tests suite is. Very few developers know it exists, let
> alone install it. Even fewer run it because it's part of the overlay
> tests and almost nobody except overlay developers run overlay
> testing...
> 
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

