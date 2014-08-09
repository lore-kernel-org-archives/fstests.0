Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:35889 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbaHIN3Y (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 9 Aug 2014 09:29:24 -0400
Message-ID: <53E62233.50807@sandeen.net>
Date: Sat, 09 Aug 2014 08:29:23 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/077: fall back to /usr if /lib/modules doesn't
 exist
References: <1407562753-11033-1-git-send-email-tytso@mit.edu>
In-Reply-To: <1407562753-11033-1-git-send-email-tytso@mit.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/9/14, 12:39 AM, Theodore Ts'o wrote:
> We need a source of "filler" that can fill up a 50M file system.
> Unfortunately, on some systems /lib/modules might not exist at all.
> In that case, use /usr instead.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Seems reasonable.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/generic/077 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/077 b/tests/generic/077
> index 172ce6e..0d6aec7 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -32,6 +32,9 @@ status=1
>  # Something w/ enough data to fill 50M of fs...
>  filler=/lib/modules/
>  
> +# fall back in case /lib/modules doesn't exist
> +[ -d $filler ] || filler=/usr
> +
>  _cleanup()
>  {
>  	cd /
> 

