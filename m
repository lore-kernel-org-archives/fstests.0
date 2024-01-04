Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB5828DC1
	for <fstests@vger.kernel.org>; Thu,  4 Jan 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adzsb9Co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90723C433C7;
	Thu,  4 Jan 2024 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704391934;
	bh=DGqUbCCD1prxrR3TqHRvPraM0/tkn1jJYtxuvWLDE/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Adzsb9Co4PZdj5QxVPHwIfWx64RzEiX8uUZsf1nioO7DitHKeuom9b44UN3hiA6fL
	 KlA8Z7ZGfcdNcjUoq61tGRIpfEbmNEoMXUvadZS+Zh8ZmpdvyHZ2yN7dyw/FR6Uw5Z
	 RFfy0++wTYrfzpNh48u0DnB3ttI1TOmXHNLqo5KCl6CaPgOEjszmFtZFHfy/IHqXLv
	 51rb8QPHAXdysBObHKmOR88DwxqeKVLllow2nc8UCcMw66OCNph1O6lQq2RR12r+Ik
	 DA4fiuHeK0RcfkMn3/npt2kKm4uimOxML7gVCpIjlqOfTY4Q9w+LR78qO/5AkbhUHL
	 p3JEO2fyzAPWg==
Date: Thu, 4 Jan 2024 10:12:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2] xfstest: add detection for ext4.h presence in
 configure.ac
Message-ID: <20240104181213.GE241128@frogsfrogsfrogs>
References: <20240103184208.80772-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103184208.80772-1-disgoel@linux.ibm.com>

On Thu, Jan 04, 2024 at 12:12:08AM +0530, Disha Goel wrote:
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
> To address this issue, configure.ac now checks for the presence
> and compilability of <linux/ext4.h>. If found and compilable, the
> macro HAVE_LINUX_EXT4_H is defined. If not, a warning message
> is displayed. The commit also updates src/ext4_resize.c to
> conditionally include <linux/ext4.h> based on the presence of
> the header, ensuring compatibility with systems where ext4.h
> is either present or not. This change enhances the configure
> process and improves code consistency.
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
> v1 -> v2
> Drop usage of uint64_t to match the definition in the kernel uapi
> headers. Use <linux/ext4.h> or <linux/types.h> based on the
> presence of the header to get the __u64 definition as suggested
> by Darrick.
> 
> Link to v1:
> https://lore.kernel.org/fstests/20231221061231.44347-1-disgoel@linux.ibm.com/T/#u
> 
>  configure.ac      | 8 ++++++++
>  src/ext4_resize.c | 6 +++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b22fc52b..76378e6d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -35,6 +35,14 @@ AC_CHECK_HEADERS([	assert.h		\
>  			sys/mman.h		\
>  ])
>  
> +AC_COMPILE_IFELSE([
> +    AC_LANG_PROGRAM([#include <linux/ext4.h>], [])
> +], [
> +    AC_DEFINE([HAVE_LINUX_EXT4_H], [1], [Define if ext4.h is present])
> +], [
> +    AC_MSG_WARN([ext4.h not found or not compilable.])
> +])

AC_CHECK_HEADERS does this.

> +
>  AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
>  #define _GNU_SOURCE
>  #include <xfs/libxfs.h>])
> diff --git a/src/ext4_resize.c b/src/ext4_resize.c
> index 78b66432..51bd8d78 100644
> --- a/src/ext4_resize.c
> +++ b/src/ext4_resize.c
> @@ -14,7 +14,11 @@
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
>  
> -typedef unsigned long long __u64;
> +#ifdef HAVE_LINUX_EXT4_H
> +#include <linux/ext4.h>
> +#else
> +#include <linux/types.h>

You might as well include this unconditionally; there's no penalty
for including it multiple times.

--D

> +#endif
>  
>  #ifndef EXT4_IOC_RESIZE_FS
>  #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
> -- 
> 2.39.1
> 
