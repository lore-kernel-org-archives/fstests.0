Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA676173
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412451; cv=none; b=M82kIwTG84mdhmghdVQ8Lu44zWfnfw7tlS0X2RV7Q6DLP5gGqEMtWSO9RpOAzPPfjUG+34osS/+kiNt/UKicqDQ5XY47DJqGgRkXCbI9l/pGFjvt7tMq9PntDXTOkE8mwlOKoE5DG6u+C5HWAvMfblxWcCk/Sp6lqFAbipbaZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412451; c=relaxed/simple;
	bh=5i66G5KQgXuVZpyekN7HwpdbU/YFvIdBcPBVShyU16M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfrXJJSHvZb4QdcwS+QlVJEdRBmpVvOCQk2AFNCqtNaAK87qYLNuHZBTe5Hh+atxBBEtcZM2OyHf2hg3Ywwlc2itd1QQsjiuWZzLFcQIBt85dF3qWH5kUaZs0QiM+cQ2khwiQciGDwPaAn/TNTz9/LU2GsimJa1TMFrx4l1MRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7pjJXhZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7pjJXhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F90C433C7;
	Tue, 26 Mar 2024 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711412451;
	bh=5i66G5KQgXuVZpyekN7HwpdbU/YFvIdBcPBVShyU16M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7pjJXhZShkq9eftsnFdhZk+j1s9N3ULcx9sKtkJX6GwMNYZGMwCp0O41F3yWJTw6
	 B36RDjxxIeB0LPx/p1fTbsLn04jMBRQjc1v5TK8Jl5gB9S1wgOEew7HIu8oGGk93U1
	 4+z4JLfKuKGLftyDSly0y42xbqlkS61RlR7taiJLHE/Cl3Bj3ojvR9HKHWOu4kQuQh
	 XYEaPidfDHSf/sgRwFGiVoLS62DsKWvjRwkkynIF9mPErWVP9l4oIEAwO5jqcp3bPh
	 UWp4+W46mb6bg7iH4JMdpg8SsIM0xbGxAigT1xCcrpPIqPEt8Y68AYhzdkY/fQ53kQ
	 r6xrNV3mT7CQQ==
Date: Mon, 25 Mar 2024 17:20:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] include libgen.h for basename API prototype
Message-ID: <20240326002050.GB6379@frogsfrogsfrogs>
References: <20240325175323.3450750-1-raj.khem@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325175323.3450750-1-raj.khem@gmail.com>

On Mon, Mar 25, 2024 at 10:53:22AM -0700, Khem Raj wrote:
> basename prototype has been removed from string.h from latest musl [1]
> compilers e.g. clang-18 flags the absense of prototype as error. therefore
> include libgen.h for providing it.
> 
> [1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

Same question as I had for your xfsdump patchset -- the manpage for
basename(3) mentions that old glibc posix implementations would modify
the argument.  Is that still true, or has that not been the case for
long enough that it's ok not to care?

--D

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  src/splice-test.c                   | 1 +
>  src/stat_test.c                     | 1 +
>  src/t_ext4_dax_inline_corruption.c  | 1 +
>  src/t_ext4_dax_journal_corruption.c | 1 +
>  src/t_mmap_collision.c              | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/src/splice-test.c b/src/splice-test.c
> index eb863673..7b7094f5 100644
> --- a/src/splice-test.c
> +++ b/src/splice-test.c
> @@ -11,6 +11,7 @@
>  #include <unistd.h>
>  #include <fcntl.h>
>  #include <err.h>
> +#include <libgen.h>
>  
>  #include <stdlib.h>
>  #include <stdio.h>
> diff --git a/src/stat_test.c b/src/stat_test.c
> index 95cfdc4f..77e1acdd 100644
> --- a/src/stat_test.c
> +++ b/src/stat_test.c
> @@ -4,6 +4,7 @@
>   * Written by David Howells (dhowells@redhat.com)
>   */
>  
> +#include <libgen.h>
>  #include <stdarg.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline_corruption.c
> index e1a39a6c..a40c5df5 100644
> --- a/src/t_ext4_dax_inline_corruption.c
> +++ b/src/t_ext4_dax_inline_corruption.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2018 Intel Corporation. */
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journal_corruption.c
> index ba7a96e4..53be10c2 100644
> --- a/src/t_ext4_dax_journal_corruption.c
> +++ b/src/t_ext4_dax_journal_corruption.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2018 Intel Corporation. */
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
> index c872f4e2..d9315fcf 100644
> --- a/src/t_mmap_collision.c
> +++ b/src/t_mmap_collision.c
> @@ -15,6 +15,7 @@
>   */
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <pthread.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> -- 
> 2.44.0
> 
> 
