Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:43079 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753384AbaFQCKh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Jun 2014 22:10:37 -0400
Date: Tue, 17 Jun 2014 12:10:33 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/317,318: fail gracefully if userns not supported
Message-ID: <20140617021033.GF9508@dastard>
References: <539B6E3A.4060008@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539B6E3A.4060008@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 13, 2014 at 04:33:46PM -0500, Eric Sandeen wrote:
> generic/317 and generic/318 fail un-gracefully on older kernels
> which don't support userns; fix that by running a simple test
> as a prerequisite and fail gracefully if needed.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/generic/317 b/tests/generic/317
> index e016a42..8919db2 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -56,6 +56,8 @@ _supported_os Linux
>  [ -x $nsexec  ] || _notrun "$nsexec executable not found"
>  [ -x $lstat64 ] || _notrun "$lstat64 executable not found"
>  
> +$nsexec -U true 2>/dev/null || _notrun "user namespaces not supported by this kernel"
> +

Can you turn this into a _requires_user_namespaces()?

i.e. check for $nsexec and the kernel support in one function.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
