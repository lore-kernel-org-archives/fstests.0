Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:33222 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbCKN7d (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 09:59:33 -0400
Message-ID: <55004A45.7010002@sandeen.net>
Date: Wed, 11 Mar 2015 09:59:33 -0400
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] new: fix template for new case to use a single tab
 not four spaces
References: <1426072534-12246-1-git-send-email-eguan@redhat.com> <1426072534-12246-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-2-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/11/15 7:15 AM, Eryu Guan wrote:
> So we have preferred code style for all new test cases.

Sure, makes sense.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  new | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/new b/new
> index 86f9075..d1f8939 100755
> --- a/new
> +++ b/new
> @@ -148,8 +148,8 @@ trap "_cleanup; exit \\\$status" 0 1 2 3 15
>  
>  _cleanup()
>  {
> -    cd /
> -    rm -f \$tmp.*
> +	cd /
> +	rm -f \$tmp.*
>  }
>  
>  # get standard environment, filters and checks
> 

