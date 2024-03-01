Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279920DCB
	for <fstests@vger.kernel.org>; Fri,  1 Mar 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316392; cv=none; b=a7lFkgp9IR++2WjmkJAkDExvt244qdlIIRz5VHSVTClSwonW1tYWmhgNIhrRSrurpL2XelCXD8v8wjb9SvKoJmDOBagHMPzyBUTH+4rYb3uGWw317TrK+8HcDpZCczZHNWUrFYf0tpnxEI2PW5Tf19X/+LRXDj14xtT+4m9SK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316392; c=relaxed/simple;
	bh=SHpbBHzsd6RmrbLS3iETdVX177OY4l2TrVGPKYPhMyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG7iPJdjqiJnr8AM7ZLXjGX32B7St/Bchl9Qv4xiPM7OLVsAVLUg1nsJ3+jVaLtJx3SPSjrQla2NET0CNdBY3FUj0bdEja9qYpyKxdczTkEdySPJBqkgdGGfTNs1sth26Fzz+QYaRrSEjj5Viz2zGb1vIV3tUxLfv6VKald4wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUQPb/J7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUQPb/J7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31720C433C7;
	Fri,  1 Mar 2024 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709316392;
	bh=SHpbBHzsd6RmrbLS3iETdVX177OY4l2TrVGPKYPhMyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUQPb/J7mUfzxTvx2qDHJuAOU9kOkvKcuBAVtIrzyYhPROueix2txawRIL5NbamOf
	 cpGPQFWaT8cVz5HpCBZSUATpuD8G9N5/j35o4w7svMS7RQkt9br6qDZfQWzbAMAh3l
	 3hExxQju7ui1N/SZcjKA+N5XOLxTVvACLq3zwCpW7EAaWrZSVHXuuZaTyIThmM8H65
	 rwBX97QmOJV+5c0MHjmDBDqb0xJCGiJsrvNk1OZXPEcCsZf0lMoVJBgvnV5smkref2
	 LrnG44EhDG7DeM+qfJrzEknFSFnd4q1FDb1m3coOgj9kFs99opXhMRVoFS5qAjypM3
	 6Uk6lKoYLh0pw==
Date: Fri, 1 Mar 2024 10:06:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4] xfstest: add detection for ext4.h presence in
 configure.ac
Message-ID: <20240301180631.GX6188@frogsfrogsfrogs>
References: <20240301081540.30236-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301081540.30236-1-disgoel@linux.ibm.com>

On Fri, Mar 01, 2024 at 01:45:40PM +0530, Disha Goel wrote:
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
> 	checking linux/ext4.h usability... yes
>         checking linux/ext4.h presence... yes
>         checking for linux/ext4.h... yes
>             [CC]    detached_mounts_propagation
>             [CC]    ext4_resize
>             [CC]    t_readdir_3
> 
>         # make
>         checking linux/ext4.h usability... no
>         checking linux/ext4.h presence... no
>         checking for linux/ext4.h... no
>             [CC]    detached_mounts_propagation
>             [CC]    ext4_resize
>             [CC]    t_snapshot_deleted_subvolume
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>

Looks great, thank you for getting this done!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> Changelog:
> v3 -> v4
> Addressed review comment from Darrick by incorporating autoconf
> best practices by only using AC_CHECK_HEADERS which is by default
> going to define header file, to align with autoconf documentation.
> 
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
> Link to v3:
> https://lore.kernel.org/fstests/20240109111105.28836-1-disgoel@linux.ibm.com/
> 
>  configure.ac      | 1 +
>  src/ext4_resize.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b22fc52b..f45bc68e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -33,6 +33,7 @@ AC_CHECK_HEADERS([	assert.h		\
>  			btrfs/ioctl.h		\
>  			cifs/ioctl.h		\
>  			sys/mman.h		\
> +			linux/ext4.h		\
>  ])
>  
>  AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
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
