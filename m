Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E274F8B0
	for <fstests@vger.kernel.org>; Tue, 26 Dec 2023 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrA8V6q/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF28C433C8;
	Tue, 26 Dec 2023 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703613154;
	bh=r68UuZdny/9Sm6VO2+r876Zb4LV4t5UQ++FgrlS6Jis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WrA8V6q/DID7aP/Qt8YQje7uUva3pEGRxq1VERgMLX37P+HDVg79wh+a9bTdrcVow
	 gtFxw6pGfn287ZbA9m0CpZVsbtqWpTcwMDYcw1HNJ5W2k3Li+YWLWxjMopRuXeR0SD
	 GmI+OlSZSOz6EPcKowIHuN6M5W0dUx671jTPpKCMttunMioPNsem+3k5Aow5qK/f7v
	 Vd3DYFHej9NA+czxD/LBxFT2gEbjy0rxO3CYlbgAepNDkyDkAsnrDPoJcumSBH3CzH
	 GM/Or6IUVVm7AxBCZZPEjr3vjhIn7P5zAodDwVFCUlzXAp+tuCU6PmWjjXVbSGMZiO
	 xgduQfQgScvIA==
Date: Tue, 26 Dec 2023 09:52:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH] xfstests: replace custom __u64 definition with uint64_t
Message-ID: <20231226175233.GC108281@frogsfrogsfrogs>
References: <20231221061231.44347-1-disgoel@linux.ibm.com>
 <20231221171247.GB108281@frogsfrogsfrogs>
 <6aff22ec-f072-48f5-997f-9ef6a951a0e0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aff22ec-f072-48f5-997f-9ef6a951a0e0@linux.ibm.com>

On Tue, Dec 26, 2023 at 02:14:38PM +0530, Disha Goel wrote:
> On 21/12/23 10:42 pm, Darrick J. Wong wrote:
> 
> > On Thu, Dec 21, 2023 at 11:42:31AM +0530, Disha Goel wrote:
> > > In some distributions, __u64 is already defined in system header files,
> > > causing compilation errors when building xfstest.
> > > 
> > > 	# make
> > > 	    [CC]    ext4_resize
> > > 	ext4_resize.c:17:28: error: conflicting types for '__u64'
> > > 	 typedef unsigned long long __u64;
> > > 	                            ^~~~~
> > > 	In file included from /usr/include/asm/types.h:26:0,
> > > 	                 from /usr/include/linux/types.h:5,
> > > 	                 from /usr/include/linux/mount.h:4,
> > > 	                 from /usr/include/sys/mount.h:32,
> > > 	                 from ext4_resize.c:15:
> > > 	/usr/include/asm-generic/int-l64.h:30:23: note: previous declaration of '__u64' was here
> > > 	 typedef unsigned long __u64;
> > >                         ^~~~~
> > > 
> > > To address this issue, replace the custom definition of __u64 with the
> > > standard uint64_t type from <stdint.h>. uint64_t is part of the C99
> > > standard, offering a standardised approach for representing unsigned
> > > 64-bit integers. This modification enhances code consistency and
> > > ensures compatibility with standard types.
> > ...but isn't consistent with the definition in the kernel uapi headers.
> > ioctls explicitly use __u64, not uint64_t, and there are a few arches
> > (apparently) where __u64 ends up an unsigned long long but uint64_t ends
> > up an unsigned long, and the reverse.
> 
> Thanks for reviewing the patch. I will take care of this and address in v2.
> 
> > > Tested on various distributions on Power architecture, by successfully
> > > compiling xfstest. Additionally, verified the compatibility by running
> > > ext4/033 and ext4/056 tests, both of which use ext4_resize and
> > > observed successful test execution.
> > > 
> > >          # make
> > >              [CC]    detached_mounts_propagation
> > >              [CC]    ext4_resize
> > >              [CC]    t_readdir_3
> > > 
> > > Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> > > ---
> > >   src/ext4_resize.c | 6 ++----
> > >   1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/src/ext4_resize.c b/src/ext4_resize.c
> > > index 78b66432..6e60ee5b 100644
> > > --- a/src/ext4_resize.c
> > > +++ b/src/ext4_resize.c
> > > @@ -14,10 +14,8 @@
> > >   #include <sys/ioctl.h>
> > >   #include <sys/mount.h>
> > Why not #include <linux/ext4.h>, which gets you both the __u64 typedef
> > and EXT4_IOC_RESIZE_FS?
> > 
> > --D
> > 
> The #include <linux/ext4.h> got added in kernel 6.4 and distros which
> I'm testing does not have <linux/ext4.h> present in kernel headers.
> We can add #include <linux/types.h> which also gets the __u64 typedef.
> 
> Let me know your thoughts.

Ah, linux/ext4.h didn't exist until 6.4.  Heh.  Well, in the long run
fstests really ought to pull in kernel ioctl definitions whenever
possible.  So:

I suppose this program should #include <linux/types.h> to get the __u64
definition, after which this can go away:

> > > -typedef unsigned long long __u64;

And then you'd need to add some m4/autoconf AC_CHECK_HEADERS magic for
configure to detect when #include <linux/ext4.h> actually results in a
compilable program; and set some make variable accordingly.

Then this program can grow a:

#ifdef HAVE_LINUX_EXT4_H
# include <linux/ext4.h>
#endif

After which this existing bit of cpp magic:

#ifndef EXT4_IOC_RESIZE_FS
# define EXT4_IOC_RESIZE_FS			_IOW('f', 16, __u64)
#endif

should work for everyone.

--D

> > > -
> > >   #ifndef EXT4_IOC_RESIZE_FS
> > > -#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
> > > +#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, uint64_t)
> > >   #endif
> > >   #define pr_error(fmt, ...) do { \
> > > @@ -31,7 +29,7 @@ static void usage(void)
> > >   int main(int argc, char **argv)
> > >   {
> > > -	__u64	new_size;
> > > +	uint64_t	new_size;
> > >   	int	error, fd;
> > >   	char	*mnt_dir = NULL, *tmp = NULL;
> > > -- 
> > > 2.39.1
> > > 
> > > 
> 
