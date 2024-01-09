Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2B3B185
	for <fstests@vger.kernel.org>; Tue,  9 Jan 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+33cgww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A2C433C7;
	Tue,  9 Jan 2024 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704819868;
	bh=dfzDj5+7hz/AEgcCAlAnBh27jaD/cweX6ZLILhgONYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+33cgwwSNL9NLGPBacATEiYKa0W7vqNuWXeQN1fNDdWjG4BYrtIOktYLNFMkzj/K
	 hH06Ct0+kwt/rQzrSJxhDfwmVsxrBBXsTvWuPE/hhGd7kCg2wc4yDp9UkOth2nzbqS
	 3Cyh6+OGa3jagATFeImTMY6in2uItsqXBPLEpkCc6SbC0+2BKIGx6+H8nd8XD0pZl6
	 J3hBoGW2UU3V7QHRMqKIgzpf3nqly0JneTipGRw3u5/N+Qimi+nM/jKxIU34X6VpH3
	 K5SYV7DESuNLoeLGKTLWA06VViC0XySxPiyL0zjPjdj3LA9bnTVluIeUxeMucX2Dq1
	 YV8ZpZe+1fURA==
Date: Tue, 9 Jan 2024 09:04:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v3] xfstest: add detection for ext4.h presence in
 configure.ac
Message-ID: <20240109170428.GA722968@frogsfrogsfrogs>
References: <20240109111105.28836-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109111105.28836-1-disgoel@linux.ibm.com>

On Tue, Jan 09, 2024 at 04:41:05PM +0530, Disha Goel wrote:
> In some distributions, __u64 is already defined in system header files,
> causing compilation errors when building xfstest.
> 
>         # make
>             [CC]    ext4_resize
>         ext4_resize.c:17:28: error: conflicting types for '__u64'
>          typedef unsigned long long __u64;
>                                     ^~~~~
>         In file included from /usr/include/asm/types.h:26:0,
>                          from /usr/include/linux/types.h:5,
>                          from /usr/include/linux/mount.h:4,
>                          from /usr/include/sys/mount.h:32,
>                          from ext4_resize.c:15:
>         /usr/include/asm-generic/int-l64.h:30:23: note: previous declaration of '__u64' was here
>          typedef unsigned long __u64;
>                        ^~~~~
> 
> To address this issue, configure.ac now checks for the presence and
> compilability of <linux/ext4.h>. If found and compilable, the macro
> HAVE_LINUX_EXT4_H is defined. The commit also updates src/ext4_resize.c
> to conditionally include <linux/ext4.h> based on the presence of the
> header, ensuring compatibility with systems where ext4.h is either
> present or not. Also include <linux/types.h> which gets __u64
> definition on systems where ext4.h is not present. This change
> enhances the configure process and improves code consistency.
> 
> The changes were tested on various distributions on Power
> architecture, by successfully compiling xfstest. Additionally,
> verified the compatibility by running ext4/033 and ext4/056
> tests, both of which use ext4_resize and observed successful
> test execution.
> 
>         # make
>             [CC]    detached_mounts_propagation
>             [CC]    ext4_resize
>             [CC]    t_readdir_3
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---
> 
> Changelog:
> v2 -> v3
> Addressed below review comments from Darrick.
> Replaced the explicit AC_COMPILE_IFELSE block with a simplified
> check using AC_CHECK_HEADERS for <linux/ext4.h>.
> Added unconditional inclusion of <linux/types.h> regardless of
> the presence of <linux/ext4.h> in ext4_resize.c file.
> 
> v1 -> v2
> Drop usage of uint64_t to match the definition in the kernel uapi
> headers. Use <linux/ext4.h> or <linux/types.h> based on the
> presence of the header to get the __u64 definition as suggested
> by Darrick.
> 
> Link to v1:
> https://lore.kernel.org/fstests/20231221061231.44347-1-disgoel@linux.ibm.com/T/#u
> 
> Link to v2:
> https://lore.kernel.org/fstests/20240103184208.80772-1-disgoel@linux.ibm.com/T/#u
> 
>  configure.ac      | 4 ++++
>  src/ext4_resize.c | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b22fc52b..8f9fb062 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -35,6 +35,10 @@ AC_CHECK_HEADERS([	assert.h		\
>  			sys/mman.h		\
>  ])
>  
> +AC_CHECK_HEADERS([linux/ext4.h], [
> +AC_DEFINE([HAVE_LINUX_EXT4_H], [1])
> +])

<cough> Quoting the autoconf documentation
https://www.gnu.org/software/autoconf/manual/autoconf-2.61/html_node/Generic-Headers.html

 — Macro: AC_CHECK_HEADERS (header-file..., [action-if-found], [action-if-not-found], [includes = `default-includes'])

    For each given system header file header-file in the blank-separated
argument list that exists, define HAVE_header-file (in all capitals)...

--D

> +
>  AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
>  #define _GNU_SOURCE
>  #include <xfs/libxfs.h>])
> diff --git a/src/ext4_resize.c b/src/ext4_resize.c
> index 78b66432..31779225 100644
> --- a/src/ext4_resize.c
> +++ b/src/ext4_resize.c
> @@ -13,8 +13,11 @@
>  #include <string.h>
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
> +#include <linux/types.h>
>  
> -typedef unsigned long long __u64;
> +#ifdef HAVE_LINUX_EXT4_H
> +#include <linux/ext4.h>
> +#endif
>  
>  #ifndef EXT4_IOC_RESIZE_FS
>  #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
> -- 
> 2.39.1
> 
> 
