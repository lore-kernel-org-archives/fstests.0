Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A3C433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A55964E89
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhCRPPP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:15:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCRPOs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Mar 2021 11:14:48 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMuMH-0001jD-Le; Thu, 18 Mar 2021 15:14:45 +0000
Date:   Thu, 18 Mar 2021 16:14:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 1/4] generic/631: add test for detached mount
 propagation
Message-ID: <20210318151444.ukfj4aqeoq5ecmwn@wittgenstein>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <20210316103627.2954121-2-christian.brauner@ubuntu.com>
 <20210318062310.GA29621@lst.de>
 <20210318150230.GF22097@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318150230.GF22097@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 18, 2021 at 08:02:30AM -0700, Darrick J. Wong wrote:
> On Thu, Mar 18, 2021 at 07:23:10AM +0100, Christoph Hellwig wrote:
> > > +/* open_tree() */
> > > +#ifndef OPEN_TREE_CLONE
> > > +#define OPEN_TREE_CLONE 1
> > > +#endif
> > > +
> > > +#ifndef OPEN_TREE_CLOEXEC
> > > +#define OPEN_TREE_CLOEXEC O_CLOEXEC
> > > +#endif
> > > +
> > > +#ifndef __NR_open_tree
> > > +	#if defined __alpha__
> > > +		#define __NR_open_tree 538
> > > +	#elif defined _MIPS_SIM
> > > +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> > > +			#define __NR_open_tree 4428
> > > +		#endif
> > > +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> > > +			#define __NR_open_tree 6428
> > > +		#endif
> > > +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> > > +			#define __NR_open_tree 5428
> > > +		#endif
> > > +	#elif defined __ia64__
> > > +		#define __NR_open_tree (428 + 1024)
> > > +	#else
> > > +		#define __NR_open_tree 428
> > > +	#endif
> > > +#endif
> > > +
> > > +/* move_mount() */
> > > +#ifndef MOVE_MOUNT_F_EMPTY_PATH
> > > +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
> > > +#endif
> > > +
> > > +#ifndef __NR_move_mount
> > > +	#if defined __alpha__
> > > +		#define __NR_move_mount 539
> > > +	#elif defined _MIPS_SIM
> > > +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> > > +			#define __NR_move_mount 4429
> > > +		#endif
> > > +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> > > +			#define __NR_move_mount 6429
> > > +		#endif
> > > +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> > > +			#define __NR_move_mount 5429
> > > +		#endif
> > > +	#elif defined __ia64__
> > > +		#define __NR_move_mount (428 + 1024)
> > > +	#else
> > > +		#define __NR_move_mount 429
> > > +	#endif
> > > +#endif
> > > +
> > > +static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
> > > +{
> > > +	return syscall(__NR_open_tree, dfd, filename, flags);
> > > +}
> > > +
> > > +static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
> > > +				 const char *to_pathname, unsigned int flags)
> > > +{
> > > +	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
> > > +}
> > 
> > Not directly new in your patch, but I wish we'd have a central header
> > for missing UAPI bits in xfstests instead of spreading it over
> > various files.
> 
> FWIW if you (or anyone else) /does/ create a src/linux_calls.h or
> similar for things like this, I will totally start adding things to it
> instead of scattering them everywhere. :)

I do usually have in my C projects two .h files (without corresponding
.c files):

1. syscall_numbers.h
   https://github.com/lxc/lxc/blob/master/src/lxc/syscall_numbers.h

   Where syscall_numbers defines the missing syscall numbers. For new
   syscalls in the style exhibited in this patch and for legacy syscalls
   it's a bit more nasty (i.e. syscalls before we unified numbering [apart
   from alpha]):
   
#ifndef __NR_memfd_create
	#if defined __i386__
		#define __NR_memfd_create 356
	#elif defined __x86_64__
		#define __NR_memfd_create 319
	#elif defined __arm__
		#define __NR_memfd_create 385
	#elif defined __aarch64__
		#define __NR_memfd_create 279
	#elif defined __s390__
		#define __NR_memfd_create 350
	#elif defined __powerpc__
		#define __NR_memfd_create 360
	#elif defined __riscv
		#define __NR_memfd_create 279
	#elif defined __sparc__
		#define __NR_memfd_create 348
	#elif defined __blackfin__
		#define __NR_memfd_create 390
	#elif defined __ia64__
		#define __NR_memfd_create 1340
	#elif defined _MIPS_SIM
		#if _MIPS_SIM == _MIPS_SIM_ABI32
			#define __NR_memfd_create 4354
		#endif
		#if _MIPS_SIM == _MIPS_SIM_NABI32
			#define __NR_memfd_create 6318
		#endif
		#if _MIPS_SIM == _MIPS_SIM_ABI64
			#define __NR_memfd_create 5314
		#endif
	#else
		#define -1
		#warning "__NR_memfd_create not defined for your architecture"
	#endif
#endif

2. syscall_wrappers.h
   https://github.com/lxc/lxc/blob/master/src/lxc/syscall_wrappers.h

   Where syscall_wrappers.h defines minimal wrappers for missing
   syscalls and their corresponding types.

#ifndef HAVE_SYS_SIGNALFD_H
struct signalfd_siginfo {
	uint32_t ssi_signo;
	int32_t ssi_errno;
	int32_t ssi_code;
	uint32_t ssi_pid;
	uint32_t ssi_uid;
	int32_t ssi_fd;
	uint32_t ssi_tid;
	uint32_t ssi_band;
	uint32_t ssi_overrun;
	uint32_t ssi_trapno;
	int32_t ssi_status;
	int32_t ssi_int;
	uint64_t ssi_ptr;
	uint64_t ssi_utime;
	uint64_t ssi_stime;
	uint64_t ssi_addr;
	uint8_t __pad[48];
};

static inline int signalfd(int fd, const sigset_t *mask, int flags)
{
	int retval;

	retval = syscall(__NR_signalfd4, fd, mask, _NSIG / 8, flags);
#ifdef __NR_signalfd
	if (errno == ENOSYS && flags == 0)
		retval = syscall(__NR_signalfd, fd, mask, _NSIG / 8);
#endif

	return retval;
}
#endif

Something like this might also work for xfstests.

Christian
