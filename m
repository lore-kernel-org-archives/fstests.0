Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF1197A8E
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881971; cv=none; b=k8d+E38LCsKgnsITyKNu/ycEv+6SVMsdjMUJmcIcAPIpQCB5sGjdsR1SvnKrYUTmp7oNxTMx9U5UxcHlpeXNm1O4K0NdVtKHej5OW4lNyfTR95jeNl9FputKf9jcSleiZL/HmypbxJK2jKpza8/1oud4eKixBqThfJoGHxERDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881971; c=relaxed/simple;
	bh=LTkJun6NpKfvrOfEiDIHHKEDnJE6Z5N4ZWQwVsV447s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK3qwAb1vkkeyvXs9rdGmJRf4pugqvBvAig9wBT5nOWgeXM//XE4VI5XEgrtUP+QfVMxuOkGHEBunWD7kbiGq6RS7XYR81UdqluJEufIq4yxwPHHGDS1aE9ZlMUqXseTzcOLqXXeunjhkbram4QfHcEUY/bQhfgb0Xai3Rnf9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA6uzCnp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA6uzCnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BBCC4CEDD;
	Thu,  6 Feb 2025 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738881971;
	bh=LTkJun6NpKfvrOfEiDIHHKEDnJE6Z5N4ZWQwVsV447s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AA6uzCnp+iday4SjzdGfW9CQS9fqrvjkpuDIVkHG611xWToXlP13n1aemPlGC/WMK
	 3ZSf/pX7tlTuO8x+CvrdkT/kPpahj0YCx83tHSlqH+NMl6MBE2q78TeDxjBlH7CeXZ
	 3FbOBxgFhm6HssKXwobeoSsj9VswgkWsTJ9OeXoMRezo6Nf5ZynY+o/yFut1N2Ij8Y
	 Ch5BzPJlpcecQesMtg1Ofsf1RhOE4+83ZGCBq4UuBIcqObZOi+k8D+/gK/O/W7g6s2
	 nLE/eojh2Wa7TnBTNW826He7OJv3EOmocp8kvTeuHodZvuXXmptSIZmkELMrM84m2p
	 /3dCvaCuz7rew==
Date: Thu, 6 Feb 2025 14:46:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 5/7] lib: replace aiocb_t with struct aiocb
Message-ID: <20250206224610.GR21799@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-6-sandeen@redhat.com>

On Thu, Feb 06, 2025 at 03:20:00PM -0600, Eric Sandeen wrote:
> aiocb_t isn't defined anywhere, use struct aiocb instead,
> to make sparse happy.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

libaio<shudder>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/tlibio.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index 19192b38..22ff1adc 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -42,6 +42,7 @@
>   *
>   */
>  
> +#include <aio.h>
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <fcntl.h>
> @@ -810,7 +811,7 @@ lio_read_buffer(
>   * (rrl 04/96)
>   ***********************************************************************/
>  int
> -lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method)
> +lio_check_asyncio(char *io_type, int size, const struct aiocb *aiocbp, int method)
>  {
>      int ret;
>      int cnt = 1;
> @@ -895,9 +896,10 @@ lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method)
>   * (rrl 04/96)
>   ***********************************************************************/
>  int
> -lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp)
> +lio_wait4asyncio(int method, int fd, const struct aiocb *aiocbp)
>  {
> -    int cnt;
> +    struct aiocb *const aioary[1];
> +    int cnt, ret;
>  
>      if ( (method & LIO_WAIT_RECALL)
>  	|| ((method & LIO_WAIT_TYPES) == 0) ){
> -- 
> 2.48.0
> 
> 
