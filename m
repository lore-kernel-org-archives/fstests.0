Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC14AC43217
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Mar 2022 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiC2UQG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiC2UQG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Mar 2022 16:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4FEE9CA4
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 13:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33194616C3
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 20:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A41AC340ED;
        Tue, 29 Mar 2022 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648584861;
        bh=b5hxQeticGSu45Y/65THpPNE0Ti08d3NRo0ngALPrC0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=UeynM7STPBfsU4OgGLuvWlfZhkRTJtci8iB7C/vEKa1U8QLy7PhyaLZu3sCqO9FNW
         dTy8LA2TzisnFLtuI80TsXFNphjFpXQDJ6ztnKBkd5FhK9g8P7hhmhU6eta+WxXhsF
         7CbIbazm7UjnXcnmn0/EXqp2zy0/5ochcuwHNDST4tOgCjs5WhjSyGesCv8cdlCZIt
         19UOYAmhLP4/6n0waSi8XWvqDuLLN4wNo7+maKAWFWGFvejqEDqFunxY9KrvrRtG9t
         zU87nTwCe+nXOeL8TajspZOeVCQ73yPm5mwTKt7WWOyzHNGj7Vjexw12BDyxec2R6z
         9GSywNWeWRtsQ==
Date:   Tue, 29 Mar 2022 13:14:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
Subject: Re: [Question] About allocsp_calls not implemented
Message-ID: <20220329201421.GF27713@magnolia>
References: <1b0b8627-0d30-018b-4a98-b69f5a8033f1@fujitsu.com>
 <20220329113521.56ks64wanu5kreur@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220329113521.56ks64wanu5kreur@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 29, 2022 at 07:35:21PM +0800, Zorro Lang wrote:
> On Tue, Mar 29, 2022 at 09:59:02AM +0000, liuyd.fnst@fujitsu.com wrote:
> > Hi, all.
> > 
> > We noticed below tests failed due to fsx issue introduced by a32fb1bb 
> > fsx: add support for XFS_IOC_ALLOCSP.
> > 
> > generic/075  generic/091  generic/112  generic/127  generic/263
> > 
> > The log shows "do_allocsp: allocsp: Function not implemented".
> 
> Hmm... Darrick, I think we'd better to disable IOC_ALLOCSP operation
> in fsx.c by default, and use another option to allow user to enable it
> if they need. Or use another option to disable it, leave -F for fallocate
> only.
> 
> What do you think?

I'd remove ALLOCSP support from fsx entirely.

--D

> Thanks,
> Zorro
> 
> > 
> > 
> > The error has been around for a while so I want to know whether upstream 
> > has got this info. As of now, we revert cd99a499 and a32fb1bb to test.
> > 
> > -- 
> > Best Regards.
> > Yiding Liu
> 
