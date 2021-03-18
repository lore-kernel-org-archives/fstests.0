Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8636C433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AF164F24
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCRPCw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhCRPCb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Mar 2021 11:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11A264E83;
        Thu, 18 Mar 2021 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616079751;
        bh=9JOvv4wj+L4rwWMJ8dPhPfdbdRO8EcyNBWDdaDcnL9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHVHYAkdRMkZkr7dOptb1s7RJXhs0ByZ5I2lYsMp3RGxkCqZHgylxWjnu0ANaiaR/
         OWm+xRevIupnrPyKIMl9Ob4bkt3sQILlDalHXFVM9CPl62bfzJjU/BLOAX6NzQH2Kk
         caJAETfOel+ALO0hn0nVHCHvjLSGfj48aUN0OLhXAkOYym5+uONVy9r7l2CjNtCYHp
         gz4elNJbKHqdKcjD44+6W77UGSB6xHX11aODCvHTAAig2+bC4FMTLw6VrEpvB7gMQc
         fKVRMZ1aBqN+mgKfl9e6WGN1soog3DCr2O69j3/h0YwlpnGzCfDJqKPmb+T0frJYmL
         zYpwtLKpWl4GA==
Date:   Thu, 18 Mar 2021 08:02:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        fstests@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 1/4] generic/631: add test for detached mount
 propagation
Message-ID: <20210318150230.GF22097@magnolia>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <20210316103627.2954121-2-christian.brauner@ubuntu.com>
 <20210318062310.GA29621@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318062310.GA29621@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 18, 2021 at 07:23:10AM +0100, Christoph Hellwig wrote:
> > +/* open_tree() */
> > +#ifndef OPEN_TREE_CLONE
> > +#define OPEN_TREE_CLONE 1
> > +#endif
> > +
> > +#ifndef OPEN_TREE_CLOEXEC
> > +#define OPEN_TREE_CLOEXEC O_CLOEXEC
> > +#endif
> > +
> > +#ifndef __NR_open_tree
> > +	#if defined __alpha__
> > +		#define __NR_open_tree 538
> > +	#elif defined _MIPS_SIM
> > +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> > +			#define __NR_open_tree 4428
> > +		#endif
> > +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> > +			#define __NR_open_tree 6428
> > +		#endif
> > +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> > +			#define __NR_open_tree 5428
> > +		#endif
> > +	#elif defined __ia64__
> > +		#define __NR_open_tree (428 + 1024)
> > +	#else
> > +		#define __NR_open_tree 428
> > +	#endif
> > +#endif
> > +
> > +/* move_mount() */
> > +#ifndef MOVE_MOUNT_F_EMPTY_PATH
> > +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
> > +#endif
> > +
> > +#ifndef __NR_move_mount
> > +	#if defined __alpha__
> > +		#define __NR_move_mount 539
> > +	#elif defined _MIPS_SIM
> > +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> > +			#define __NR_move_mount 4429
> > +		#endif
> > +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> > +			#define __NR_move_mount 6429
> > +		#endif
> > +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> > +			#define __NR_move_mount 5429
> > +		#endif
> > +	#elif defined __ia64__
> > +		#define __NR_move_mount (428 + 1024)
> > +	#else
> > +		#define __NR_move_mount 429
> > +	#endif
> > +#endif
> > +
> > +static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
> > +{
> > +	return syscall(__NR_open_tree, dfd, filename, flags);
> > +}
> > +
> > +static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
> > +				 const char *to_pathname, unsigned int flags)
> > +{
> > +	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
> > +}
> 
> Not directly new in your patch, but I wish we'd have a central header
> for missing UAPI bits in xfstests instead of spreading it over
> various files.

FWIW if you (or anyone else) /does/ create a src/linux_calls.h or
similar for things like this, I will totally start adding things to it
instead of scattering them everywhere. :)

--D

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
