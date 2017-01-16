Received: from sandeen.net ([63.231.237.45]:60368 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdAPXbf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jan 2017 18:31:35 -0500
Subject: Re: [PATCH] README: Fix Quick start typo
References: <20170116231341.GA866@giis.co.in>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <90653800-ad6a-758b-0fe9-bf08f26d3cca@sandeen.net>
Date: Mon, 16 Jan 2017 17:30:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170116231341.GA866@giis.co.in>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Lakshmipathi.G" <Lakshmipathi.G@giis.co.in>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 1/16/17 5:13 PM, Lakshmipathi.G wrote:
> Signed-off-by: Lakshmipathi.G <Lakshmipathi.G@giis.co.in>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 400e902..f788e71 100644
> --- a/README
> +++ b/README
> @@ -63,7 +63,7 @@ Preparing system for tests (IRIX and Linux):
>                
>      - setup your environment
>  	Quick start:
> -	- copy config.local.example to config.local and edit as needed
> +	- copy local.config.example to local.config and edit as needed

Whoops, that might be my fault!

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

>  	Or:
>          - setenv TEST_DEV "device containing TEST PARTITION"
>          - setenv TEST_DIR "mount point of TEST PARTITION"   
> 
