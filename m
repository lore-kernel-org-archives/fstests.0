Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C903C433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5B764F41
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 06:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCRGXe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Mar 2021 02:23:34 -0400
Received: from verein.lst.de ([213.95.11.211]:40210 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhCRGXN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Mar 2021 02:23:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A34A68C65; Thu, 18 Mar 2021 07:23:10 +0100 (CET)
Date:   Thu, 18 Mar 2021 07:23:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 1/4] generic/631: add test for detached mount
 propagation
Message-ID: <20210318062310.GA29621@lst.de>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com> <20210316103627.2954121-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316103627.2954121-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> +/* open_tree() */
> +#ifndef OPEN_TREE_CLONE
> +#define OPEN_TREE_CLONE 1
> +#endif
> +
> +#ifndef OPEN_TREE_CLOEXEC
> +#define OPEN_TREE_CLOEXEC O_CLOEXEC
> +#endif
> +
> +#ifndef __NR_open_tree
> +	#if defined __alpha__
> +		#define __NR_open_tree 538
> +	#elif defined _MIPS_SIM
> +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> +			#define __NR_open_tree 4428
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> +			#define __NR_open_tree 6428
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> +			#define __NR_open_tree 5428
> +		#endif
> +	#elif defined __ia64__
> +		#define __NR_open_tree (428 + 1024)
> +	#else
> +		#define __NR_open_tree 428
> +	#endif
> +#endif
> +
> +/* move_mount() */
> +#ifndef MOVE_MOUNT_F_EMPTY_PATH
> +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
> +#endif
> +
> +#ifndef __NR_move_mount
> +	#if defined __alpha__
> +		#define __NR_move_mount 539
> +	#elif defined _MIPS_SIM
> +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> +			#define __NR_move_mount 4429
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> +			#define __NR_move_mount 6429
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> +			#define __NR_move_mount 5429
> +		#endif
> +	#elif defined __ia64__
> +		#define __NR_move_mount (428 + 1024)
> +	#else
> +		#define __NR_move_mount 429
> +	#endif
> +#endif
> +
> +static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
> +{
> +	return syscall(__NR_open_tree, dfd, filename, flags);
> +}
> +
> +static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
> +				 const char *to_pathname, unsigned int flags)
> +{
> +	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
> +}

Not directly new in your patch, but I wish we'd have a central header
for missing UAPI bits in xfstests instead of spreading it over
various files.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
