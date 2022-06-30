Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiF3OpY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiF3OpX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:45:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1BE1B781
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:45:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEjGlr004837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600318; bh=8EvrNXMHJIEuRZwGEvLTBoO7S7Ya2f3pVb/f5LOCxHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LlGEjNVdb28mXr3CDKNYCNKZwygzQ95X2vQE+PLplbmsNgh3RlQRq63WR/3FmQ4JR
         +VkY511loLFMmfHL8v0Xr+Y+UqiixdVKwNudZQO6Hii/o0XJTnBnR//Z+UWZhOUlTy
         osy7ul90Gp5h6Di8aNPK0GNb/8sJfYi3XQwlBx+mpceleC0RF7IHWnOgzPkBXDeEL0
         UJJblqR/djVBNzEte0d/vtX+kYHeiCPgvnA1uK5yd9W8KHg8Z+y7LfQlqwfPsy1+mp
         b3rVHf7D9SP335FNbnfExaNBzwKZQByxh09QH1JwYKkjIBaZznAw/a0xhENBYVtyWb
         00p2bUX9oMPgw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CC37F15C3E94; Thu, 30 Jun 2022 10:45:16 -0400 (EDT)
Date:   Thu, 30 Jun 2022 10:45:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v3 7/7] ext4: create file systems with the encrypt
 feature as necessary
Message-ID: <Yr22/AHaQsCbjoGf@mit.edu>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-8-tytso@mit.edu>
 <20220629133052.3knyrselanytvrws@zlang-mailbox>
 <YryoPGksgK3UfKvO@mit.edu>
 <20220630013945.vzndbloouk5rknwc@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630013945.vzndbloouk5rknwc@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 30, 2022 at 09:39:45AM +0800, Zorro Lang wrote:
> On Wed, Jun 29, 2022 at 03:30:04PM -0400, Theodore Ts'o wrote:
> > On Wed, Jun 29, 2022 at 09:30:52PM +0800, Zorro Lang wrote:
> > > 
> > > As Eric gave some review points to V2, so double check with Eric, if it's good
> > > to him?
> > 
> > Eric, any other issues than the ones which you had mentioned (and
> > which I have addressed)?
> > 
> > Zorro, I have the patches based against for-next, and with your
> > reviewed-by tags appended, and tagged with a signed tag on the
> > for-upstream branch up on github.  Or if you like I can resend patch
> > series via e-mail.
> > 
> >       	    	       	   	- Ted
> > 
> > The following changes since commit 34c1208f601b5f22c62d0f3ed6f6c55c88aa4eff:
> > 
> >   xfs/{422,517}: kill background jobs on test termination (2022-06-25 00:27:11 +0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://github.com/tytso/xfstests tags/for-zorro
> > 
> > for you to fetch changes up to 43dec26fe614b1d8ad8f4c67aaf6f88413b7f2f8:
> > 
> >   ext4: create file systems with the encrypt feature as necessary (2022-06-29 15:11:41 -0400)
> 
> Hi Ted,
> 
> Sure, if you won't change anymore, I'll get this patchset by:
>   $ b4 am $message_id_of_this_email
> 
> If you still need to do more change, I can fetch the final version from above
> git repo you metioned. Feel free to tell me, if it's ready to be merged :)

I've made some changes that requested by Eric (sorry Eric, I showhow
missed your comments from the -v2 patch series) , and will be
reposting a V4 of this patch series.

						- Ted
						
