Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4234CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 15:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390309AbiDUP4S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbiDUP4R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 11:56:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A215722
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 08:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F21B82427
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 15:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAFCC385A5;
        Thu, 21 Apr 2022 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650556405;
        bh=0oP4phiR2vS7q4Qg6k217cx3kRDlhxyqgNC6EbZ/Tiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMYKO0GCn4MAbhTuf6oNl2L6aDgyTeF4CQ/9e9GhQwFkKvBFJFebfua3O1gRyYOi7
         ZDS5fQQaehEdGtb51vW8n5uIVoMkvkIiqodV2vpKHyehLpryRyxmZfC3oRyiAnjkJS
         y5ces/pHyUbof0Bvs6Ffd1KnrUnTucKPAzciXK2EaYLAcHuQAv8uzTmnr8EZxrcYA6
         HQukZFIsERWbTCXDJ6Bio6PbcY3oKpubrCPTKDpw9yQkgWxMzcFmNG7ruWg4H2PUCV
         dwfyqobmcBH6EnzeJh05ejr7dj9Cm/zc1L4AaUjTEqMLdESJvd11T7RNhKbHXi2UKd
         IU53FYHftF1IQ==
Date:   Thu, 21 Apr 2022 17:53:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421155320.agny6epqti2tcmit@wittgenstein>
References: <20220419131423.2367795-1-brauner@kernel.org>
 <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
 <20220421085942.GR1609613@dread.disaster.area>
 <20220421153513.frp7xdbejsoawews@zlang-mailbox>
 <20220421153717.GA27435@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421153717.GA27435@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 05:37:17PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 11:35:13PM +0800, Zorro Lang wrote:
> > Sure, I won't do that wilfully, just try to ask how we can improve this
> > huge and 'keep growing' idmapped-mounts.c, not tend to remove the whole
> > idmapped-mount testing coverage :)
> 
> It might just be time to split that file up into a few ones if there
> is a sensible split.  I'll let Christian think about that, though.

Yep, I agree. I think we need to at least rename it to reflect is vfs
generic nature and then split it into separate test binaries.
I'll think about a good approach.
