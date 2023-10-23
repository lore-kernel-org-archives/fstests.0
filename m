Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5955C25B45
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Oct 2023 19:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJWTse (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Oct 2023 15:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWTsd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Oct 2023 15:48:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32919B4
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 12:48:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39NJmMuC015926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 15:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698090504; bh=2ljxwZHwILCxviJE4Y4410bEr8Br8pWa13G400TNXXc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=p3tupYAO1dCKfylGSPp7aKWbvc9YurgebrVQ12rLbTaH7pQ/uiI5jdo0nWUXMwfbT
         3Tr5ECnWwZb44XXfaUzVPzudKFqfC1wgMgj9nF6HviSQMBshuSGHWgMFho9C1pBNEn
         i1+r96WOrr4aD8dXde7k4HLSkojnjAFvRGAgkd5h5KaDZ7WtFd7bE6QCalvPNKUcxT
         n1oOzbiLNHcKVnN+Li+BH+2VEz4vQ3cYVvEkqtSfpGWJr7bmj0qtQNpPMRHmO0NKTB
         ydSPh+1cyZ2a1c4cmbmTKN2UivFac5re5/PCc7E4/CoZ/LVeQKot7Nttz7IsniygQ/
         qwZ72L7mEz/Tg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 267A815C0247; Mon, 23 Oct 2023 15:48:22 -0400 (EDT)
Date:   Mon, 23 Oct 2023 15:48:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common: check if the scratch device can support 1024
 block sizes
Message-ID: <20231023194822.GA2840460@mit.edu>
References: <20231022215529.2202150-1-tytso@mit.edu>
 <20231022215529.2202150-2-tytso@mit.edu>
 <20231023154513.GF11391@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154513.GF11391@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 23, 2023 at 08:45:13AM -0700, Darrick J. Wong wrote:
> > +	if [ $blocksize -lt $(blockdev --getss $SCRATCH_DEV) ]; then
> > +		_require_scratch_support_blocksize "$blocksize"
> > +	fi
> 
> This duplicates the logic in _require_scratch_support_blocksize, so I
> think you can drop it.

Yes, oops.  I'll drop the if statement.

> > +_require_scratch_support_blocksize()
> > +{
> > +	local blocksize=$1
> > +
> > +	if [ $blocksize -lt $(blockdev --getss $SCRATCH_DEV) ]; then
> > +		_notrun "$SCRATCH_DEV does not support a block size of $blocksize."
> 
> "block" is a bit vague in this context -- you mean the LBA size, not the
> internal physical block size, right?
> 
> May I suggest "...does not support an LBA size of $blocksize." ?

How about "does not support a file system block size of $blocksize"?
LBA size refers to the granularity of "logical block address" for a
particular block device, which would be confusing and not quite right
here.

						- Ted
