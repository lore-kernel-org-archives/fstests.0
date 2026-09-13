Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AE390C9A;
	Sun, 13 Sep 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789309792; cv=none; b=hykqm+ZcLKBBrNDpB8mB/kDUt7TWBdl1OM8pVak5+VIt5oWt1p9dDED+E98rfwi48o0u9bW0SgAhVGW1jyJ3runDl2YyQlsrd80KQ8aewyODuJUoAQXgQMtTjY1Jq/0gfJmY5UG6yxejByyxQeAfo5O8MAcTE4D9oiyC1zK/ePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789309792; c=relaxed/simple;
	bh=kcjV8Xyir10x3PUV8FcSeTKcU3sjD3TgbMdtdqAHfuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/i76UrO0mwTHpml44D9Qt3vL5Uwe/5WLE0Pv3/9qIbZ/OK9NgUqcjnuLWYimEcwvI0bGb/tfc2njrKzMqBkQ/JzHN5Ia1WHpxVPw1AANQN31o+ceDd/i5pVjUNSZFYaPUjmqCRSDSfMnKT4Kp/DfheEqisQ3Sd4ksqsWJEtnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqCBi686; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqCBi686"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E41F000FF;
	Sun, 13 Sep 2026 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789309789;
	bh=DIJBQJYOZatXn8D8yoWJAnCutOw1DgwGaEIaupxWwd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kqCBi68643CUNPTYSZqlb+T3SwJb8i58+GtsFMysLN00Jk/SPxo3cDch89NI3bl7o
	 MMCV/qvp4M0yd6+XWWDX6FIly5gH6hvs+BooQa9uxm6b6jKmm/8OOnUMQsxSwjCMhN
	 QafDz0l0gkJ1Koz4D6Xw6yMxywGPW9RIyzX9G5bKPFzyOYo0fdfAkP22lFhgJAwHSc
	 vid16sEqZ1/ua1EQkhMS8Fj5gcgaykIe7JEpSNN7jpRKG90eFjDbMcmBDwEX9nezEp
	 ZoTiTwMu1/9SmMu2FO1BtMdIhxOvR30QlTRMac/0Li9rDieoxr7u0LvVm8I/AXDWMe
	 MJLj4BqYOJtAw==
Date: Sun, 13 Sep 2026 22:29:43 +0800
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] src/locktest.c: fix build failure of struct delegation
Message-ID: <aqaxjGZ6rSR1mZCf@zlang-mailbox>
Mail-Followup-To: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260813150846.280498-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813150846.280498-1-zlang@kernel.org>

On Thu, Aug 13, 2026 at 11:08:46PM +0800, Zorro Lang wrote:
> Since glibc commit f2e3dacbff88 ("Add new constants from Linux 6.12,
> 6.18 and 6.19 to bits/fcntl-linux.h"), the F_GETDELEG and F_SETDELEG
> constants from Linux 6.19 have been added directly into <fcntl.h>.
> However, the corresponding full definition for 'struct delegation'
> was not included in glibc's userspace wrapper. That causes below
> build error:
> 
>  locktest.c:1065:16: error: variable 'deleg' has initializer but incomplete type
>   1065 |         struct delegation deleg = { .d_type = F_UNLCK };
>  ...
> 
> Fix this by isolating the definition of 'struct delegation' from the
> command macros via autoconf capability probing:
> 
> 1. Add an AC_CHECK_TYPES check for 'struct delegation' in configure.ac.
> 2. In locktest.c, unbind 'struct delegation' from the '#ifndef F_GETDELEG'
>    guard and wrap it with '#ifndef HAVE_STRUCT_DELEGATION' instead.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> fstests currently fails to build against the latest glibc, with the root
> cause detailed in the commit log above.
> 
> The glibc now defines F_GETDELEG and F_SETDELEG, but leaves out the actual
> 'struct delegation' definition. The complete struct is available in <linux/fcntl.h>,
> but we cannot simply include both <fcntl.h> and <linux/fcntl.h> due to nasty
> namespace redefinition conflicts.
> 
> I am not entirely sure if glibc will bring in 'struct delegation', so for now,
> I chose to decouple and handle the structure definition independently via
> autoconf.
> 
> Any thoughts or better suggestions on how we should handle this transition?

Friendly ping...

Am I the only one seeing this? Without this patch, xfstests won't compile on
the latest Fedora：
  glibc-devel-2.44.9000-1.fc46.x86_64
  gcc-16.2.1-2.fc46.x86_64

I keep running into the build error below [1].

Thanks,
Zorro

[1]
locktest.c: In function 'initialize':
locktest.c:1018:17: warning: variable 'offset' set but not used [-Wunused-but-set-variable=]
 1018 |     int         offset = 0;
      |                 ^~~~~~
locktest.c: In function 'release_lease':
locktest.c:1065:16: error: variable 'deleg' has initializer but incomplete type
 1065 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                ^~~~~~~~~~
locktest.c:1065:38: error: 'struct delegation' has no member named 'd_type'
 1065 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                                      ^~~~~~
locktest.c:1065:47: warning: excess elements in struct initializer
 1065 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                                               ^~~~~~~
locktest.c:1065:47: note: (near initialization for 'deleg')
locktest.c:1065:27: error: storage size of 'deleg' isn't known
 1065 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                           ^~~~~
locktest.c:1065:27: warning: unused variable 'deleg' [-Wunused-variable]
locktest.c: In function 'do_deleg':
locktest.c:1365:12: error: variable 'deleg' has initializer but incomplete type
 1365 |     struct delegation deleg = { .d_type = arg };
      |            ^~~~~~~~~~
locktest.c:1365:34: error: 'struct delegation' has no member named 'd_type'
 1365 |     struct delegation deleg = { .d_type = arg };
      |                                  ^~~~~~
locktest.c:1365:43: warning: excess elements in struct initializer
 1365 |     struct delegation deleg = { .d_type = arg };
      |                                           ^~~
locktest.c:1365:43: note: (near initialization for 'deleg')
locktest.c:1365:23: error: storage size of 'deleg' isn't known
 1365 |     struct delegation deleg = { .d_type = arg };
      |                       ^~~~~
locktest.c:1365:23: warning: unused variable 'deleg' [-Wunused-variable]
locktest.c: In function 'main':
locktest.c:1615:16: error: variable 'deleg' has initializer but incomplete type
 1615 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                ^~~~~~~~~~
locktest.c:1615:38: error: 'struct delegation' has no member named 'd_type'
 1615 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                                      ^~~~~~
locktest.c:1615:47: warning: excess elements in struct initializer
 1615 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                                               ^~~~~~~
locktest.c:1615:47: note: (near initialization for 'deleg')
locktest.c:1615:27: error: storage size of 'deleg' isn't known
 1615 |         struct delegation deleg = { .d_type = F_UNLCK };
      |                           ^~~~~
locktest.c:1615:27: warning: unused variable 'deleg' [-Wunused-variable]
    [CC]    chprojid_fail
    [CC]    detached_mounts_propagation
gmake[2]: *** [Makefile:139: locktest] Error 1
gmake[2]: *** Waiting for unfinished jobs....
gmake[1]: *** [include/buildrules:30: src] Error 2
make: *** [Makefile:65: default] Error 2

> 
> Thanks,
> Zorro
> 
>  configure.ac   | 4 ++++
>  src/locktest.c | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index feb24ddd..6d7ff3ba 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -111,6 +111,10 @@ AC_CHECK_TYPES([struct btrfs_ioctl_received_subvol_args], [], [], [[
>  #include <stddef.h>
>  #include <linux/btrfs.h>
>  ]])
> +AC_CHECK_TYPES([struct delegation], [], [], [[
> +#include <stddef.h>
> +#include <fcntl.h>
> +]])
>  AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
>  AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
>  #include <stddef.h>
> diff --git a/src/locktest.c b/src/locktest.c
> index 54ee1f07..d0264c94 100644
> --- a/src/locktest.c
> +++ b/src/locktest.c
> @@ -80,7 +80,9 @@ extern int h_errno;
>  #ifndef F_GETDELEG
>  #define F_GETDELEG	(1024 + 15)
>  #define F_SETDELEG	(1024 + 16)
> +#endif
>  
> +#ifndef HAVE_STRUCT_DELEGATION
>  struct delegation {
>  	uint32_t d_flags;
>  	uint16_t d_type;
> -- 
> 2.55.0
> 
> 
