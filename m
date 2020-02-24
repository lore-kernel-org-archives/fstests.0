Return-Path: <SRS0=n5xI=4M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA89C38BFA
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 21:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2C218AC
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582580719;
	bh=5MVKQPXKOe2jinhFJ6oRAvx9bIIM25+EMdBMxJ/9KpM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=v5+7/EFLbLvA8ljyVZX0+XkziEYCgoAHU8PBbB6L72JMhK9PNYP5vyWs8xwHF+CpC
	 bhlf8I2FCWHc772qUGH4NdvSWiE7dvY9+t1u77wmdFFpvVOgsKnMlJ7JQAc2EckhHd
	 7rXgTCatMcgAt9ATDH2Bik7Q/sNQDPBpwk2Rwps0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBXVpT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgBXVpT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Feb 2020 16:45:19 -0500
Received: from vulkan (unknown [4.28.11.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02E821556;
        Mon, 24 Feb 2020 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582580718;
        bh=5MVKQPXKOe2jinhFJ6oRAvx9bIIM25+EMdBMxJ/9KpM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=v1gmbySCx8hC3Qny3XuuLF2d8L4yQTRJwYxobBBG31YoIxH+9rlSSelgifgaWBde3
         tuV7K/ViV1pOIfUVJcfElRtvjZXRHtTBaRTTrH22lXZWPqwuHqtSvtMlHY44cYcWQm
         sXZ7BjFY4rjFzwVXE3A+I0pMh4KnRjyCdOqf5MkU=
Message-ID: <cbb0cc687b1c4509ad891f146b92472fcc1dbb69.camel@kernel.org>
Subject: Re: xfstests generic/484
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     fstests@vger.kernel.org
Date:   Mon, 24 Feb 2020 13:45:18 -0800
In-Reply-To: <20200131164619.GA13005@infradead.org>
References: <20200115150059.GA21201@infradead.org>
         <20200131164619.GA13005@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, 2020-01-31 at 08:46 -0800, Christoph Hellwig wrote:
> Jeff can you help out with generic/484?
> 
> On Wed, Jan 15, 2020 at 07:00:59AM -0800, Christoph Hellwig wrote:
> > Hi Jeff,
> > 
> > do you remember the story behind xfstests generic/484?  That test has
> > been failing for me ever since it was added and on every file system
> > (which is not surprising given that the functionality isn't file system
> > specific).  Are we expected to fix the issue in the lock ode?  Or did we
> > give up on it?
> ---end quoted text---

Sorry for not seeing this before. I blame gmail.

I didn't actually add this test. I believe Eryu may have added it in
response to a bug report and an initial patch that I proposed that
turned out not to be the right approach.

I'm fine with removing this test. We may eventually want to fix this,
but it probably will mean reworking how the file table gets inherited
across execve (which is outside my usual wheelhouse).

-- 
Jeff Layton <jlayton@kernel.org>

