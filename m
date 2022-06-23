Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65907C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 00:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbiFWAXb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 20:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354197AbiFWAX2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 20:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A40C657C
        for <fstests@vger.kernel.org>; Wed, 22 Jun 2022 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655943807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOFtXivaXlX0O43wOUM0WxyuY4D/ujO3ivksNNIhBww=;
        b=ht6LrjJcQ/ju3qh9+5+hWEtA9LT6O3XnNjepCm7eu2I8qiLIFD3tIwVPtTwtJyyqAB6F3L
        //J2p/w1+bcj0/5DF88iUaii3mA+sogTb5C+F9ERlhkL7A7BadkxdlOZzsBFJ5gRQVjAPa
        0Ik73UxYS8nIKhLtGe6EsBUlskgP7Qo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-u5BwAmRHPzK4uKG8PuqQhg-1; Wed, 22 Jun 2022 20:23:25 -0400
X-MC-Unique: u5BwAmRHPzK4uKG8PuqQhg-1
Received: by mail-qv1-f71.google.com with SMTP id x18-20020a0ce252000000b004703cbb92ebso11628488qvl.21
        for <fstests@vger.kernel.org>; Wed, 22 Jun 2022 17:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOFtXivaXlX0O43wOUM0WxyuY4D/ujO3ivksNNIhBww=;
        b=GT9400egoa3z5HsrKulZJoU1jvHi28EjJHO1MyXyNoIz7w6qcQHofzSB4mZRw3BNGL
         9s1cTJmPtiNnvpXQ0dG1n0ohoZShVWJbghVAzoNAJY/20MSIO+CwLmsDOude6peZQSCE
         7oJNp2vk5DSJqR0j/E8jH4Zs8yHmhf4SuBIIkBPaFUqdDiLYzvv7nheEobRpLAJ5j0FW
         l+QHtCCIH6bTNIn1d6N6teCpAhbS7u//jDRTo6cmbB74nUlfwzw3HtK6+eGKxfc8Uhij
         O86lQk9iL4fXKVnsUL18yIrvAK3gXYuPpW+ieaMIV5hr0gVEBUy/LE9UMoSij03bXbu7
         Bvjw==
X-Gm-Message-State: AJIora8OeReSkPKAK6qLfIo0JQtjR0jbzkuLoemFKCQ8rT+fepMI0Xbf
        q4zW+m95fCfKt2iV0StqENGgstO5jKG25Au00uOy17QFfjHJeO2V5duQWpgxENeurpqWBAKsIge
        ueSMRdbjyKCyM9Oat+A==
X-Received: by 2002:ac8:58c2:0:b0:305:2ef6:3d68 with SMTP id u2-20020ac858c2000000b003052ef63d68mr5815773qta.381.1655943805407;
        Wed, 22 Jun 2022 17:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAotLR/tBu2mTrrD+T+EAkbtAkvbFQ6noNYtcoXhAn9kShyisXljWLkUDB6TM0wrsJUDoEbQ==
X-Received: by 2002:ac8:58c2:0:b0:305:2ef6:3d68 with SMTP id u2-20020ac858c2000000b003052ef63d68mr5815754qta.381.1655943805144;
        Wed, 22 Jun 2022 17:23:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a408b00b006a37c908d33sm17899713qko.28.2022.06.22.17.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 17:23:24 -0700 (PDT)
Date:   Thu, 23 Jun 2022 08:23:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Chandan Babu R <chandan.babu@oracle.com>, fstests@vger.kernel.org
Subject: Re: [PATCH V3 0/4] Large extent counters tests
Message-ID: <20220623002319.64pqbbpf6ejumcoe@zlang-mailbox>
References: <20220611111037.433134-1-chandan.babu@oracle.com>
 <YrNLGKchdYqshW4o@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrNLGKchdYqshW4o@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 22, 2022 at 10:02:16AM -0700, Darrick J. Wong wrote:
> On Sat, Jun 11, 2022 at 04:40:33PM +0530, Chandan Babu R wrote:
> > Hi all,
> > 
> > This patchset adds two tests for verifying the behaviour of Large
> > extent counters feature. It also fixes xfs/270 test failure when
> > executed on a filesystem with Large extent counters enabled.
> > 
> > Changelog:
> > V2 -> V3:
> >    1. xfs/270: Fix regular expresssion used in inline awk script to
> >       match hex number.
> 
> Why did all the patches lose their RVB tags?

Hi Darrick,

Yes, the V3 lost RVB tags, but I saw your RVB on last version, and this V3
only improved a string, so I reviewed it and added your RVB back. I've merged
this patchset. Thanks for your review again :)

Thanks,
Zorro

> 
> --D
> 
> > V1 -> V2:
> >    1. xfs/270: Replace bashisms with inline awk scripts.
> >    2. Use _scratch_mkfs_xfs_supported helper in _require_xfs_nrext64().
> >    3. Remove invocation of $XFS_INFO_PROG from _require_xfs_nrext64().
> >    4. Use xfs_db's 'path' command instead of saving test file's inode
> >       number in the two new tests introduced by the patchset.
> > 
> > Chandan Babu R (4):
> >   xfs/270: Fix ro mount failure when nrext64 option is enabled
> >   common/xfs: Add helper to check if nrext64 option is supported
> >   xfs: Verify that the correct inode extent counters are updated
> >     with/without nrext64
> >   xfs: Verify correctness of upgrading an fs to support large extent
> >     counters
> > 
> >  common/xfs        |  12 +++++
> >  tests/xfs/270     |  26 ++++++++++-
> >  tests/xfs/270.out |   1 -
> >  tests/xfs/547     |  92 +++++++++++++++++++++++++++++++++++++
> >  tests/xfs/547.out |  13 ++++++
> >  tests/xfs/548     | 112 ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/548.out |  12 +++++
> >  7 files changed, 265 insertions(+), 3 deletions(-)
> >  create mode 100755 tests/xfs/547
> >  create mode 100644 tests/xfs/547.out
> >  create mode 100755 tests/xfs/548
> >  create mode 100644 tests/xfs/548.out
> > 
> > -- 
> > 2.35.1
> > 
> 

