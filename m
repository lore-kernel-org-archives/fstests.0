Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC3C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65C56142C
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhEYQ1j (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEYQ1j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C1EF61429;
        Tue, 25 May 2021 16:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959969;
        bh=+4ClqRAM59iJoy8JBb7JsGlEURJ+bA95/mxMDn99wpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbpT3vvBh6KbLtN60yVE/WDTFw7kiq1b+T33sZSG3cRfJuaNue0W3Iv8wxbk/CAYZ
         skPb71q2WqyQhOXxbbG/sgxjUmbwOkxlbL4P/tzH/KtzHx6f/fkW5L1wuMD1sG3bxe
         D+Ue68bnURkJLg19LNlZwtZlfi3FDMoU39F6eK57sYM2bI077A+AR/qDwSnd5UkuTF
         DpsnF8mKe7YRfb9qxXY0OZSZOrQcdWN2vv3/q4eiGPRJZLnE4TBeR7zAJp41UhovuN
         OPUK6cd2uz9NvHhkVCScjSh4QQU24PWQ8w9YDTC1Ch0LnTDtVCPED0XwjsdGYtD36j
         TEc21u0Gw/U8Q==
Date:   Tue, 25 May 2021 09:26:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/9] generic/294, afs: Allow for mknod subtest failing if
 mknod not supported
Message-ID: <20210525162609.GI202095@locust>
References: <20210525160959.GC202095@locust>
 <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
 <4141825.1621959581@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4141825.1621959581@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 05:19:41PM +0100, David Howells wrote:
> Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > > +	_require_mknod
> > 
> > I don't see a _require_mknod being added to common/rc?
> 
> It preexists:
> 
> 	warthog>git grep _require_mknod
> 	common/rc:_require_mknod()
> 
> but it seems that _has_mknod should be documented in conjunction with it so
> that the difference is more obvious.

Ah, ok then.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> David
> 
