Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:33380 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbbCKOIW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 10:08:22 -0400
Message-ID: <55004C56.9040004@sandeen.net>
Date: Wed, 11 Mar 2015 10:08:22 -0400
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] generic/027: discard mkdir error message
References: <1426072534-12246-1-git-send-email-eguan@redhat.com> <1426072534-12246-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-3-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/11/15 7:15 AM, Eryu Guan wrote:
> mkdir fails due to ENOSPC occasionally and will fail the whole test.
> Redirect stdout and stderr to /dev/null.
> 
> Also fix the code style in _cleanup to use single tab.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/generic/027 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/027 b/tests/generic/027
> index 8dab117..d2e59d6 100755
> --- a/tests/generic/027
> +++ b/tests/generic/027
> @@ -36,8 +36,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
>  {
> -    cd /
> -    rm -f $tmp.*
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  create_file()
> @@ -46,7 +46,7 @@ create_file()
>  	local direct=$2
>  	local i=0
>  
> -	mkdir -p $dir
> +	mkdir -p $dir >/dev/null 2>&1
>  	while $XFS_IO_PROG -f $direct -c "pwrite 0 1k" $dir/file_$i >/dev/null 2>&1; do
>  		let i=$i+1
>  	done
> 

