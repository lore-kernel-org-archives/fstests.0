Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:57330 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676AbbEUBGu (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 May 2015 21:06:50 -0400
Message-ID: <555D2FA9.3060107@sandeen.net>
Date: Wed, 20 May 2015 20:06:49 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfstests: correct comment in generic/135
References: <1432168977-4330-1-git-send-email-shhuiw@foxmail.com>
In-Reply-To: <1432168977-4330-1-git-send-email-shhuiw@foxmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Wang Sheng-Hui <shhuiw@foxmail.com>, fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On 5/20/15 7:42 PM, Wang Sheng-Hui wrote:
> xfs_io '-d' specifies direct IO, not sync IO.
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>

Ok, sure.  :)

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/generic/135 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/135 b/tests/generic/135
> index 79558f5..2444803 100755
> --- a/tests/generic/135
> +++ b/tests/generic/135
> @@ -63,7 +63,7 @@ $XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x12 0 4k' async_file > /dev/null
>  # create file with sync I/O
>  $XFS_IO_PROG -f -s -c 'pwrite -b 4k -S 0x34 0 4k' sync_file > /dev/null
>  
> -# create file with sync I/O
> +# create file with direct I/O
>  $XFS_IO_PROG -f -d -c 'pwrite -b 4k -S 0x56 0 4k' direct_file > /dev/null
>  
>  # create file, truncate and then dirty again
> 

