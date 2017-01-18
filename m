Received: from mail-pf0-f196.google.com ([209.85.192.196]:34821 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbdARKvl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jan 2017 05:51:41 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so916268pfa.2
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2017 02:51:41 -0800 (PST)
Subject: Re: [PATCH] README: fix the typo of local.config.example
References: <83ca1aaa-7f30-bece-87e1-4faab1ebdc72@gmail.com>
From: Kinglong Mee <kinglongmee@gmail.com>
Message-ID: <dd0f58ba-01e8-64f5-b0dd-8d2835b29616@gmail.com>
Date: Wed, 18 Jan 2017 18:51:28 +0800
MIME-Version: 1.0
In-Reply-To: <83ca1aaa-7f30-bece-87e1-4faab1ebdc72@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
Cc: sandeen@redhat.com, Kinglong Mee <kinglongmee@gmail.com>
List-ID: <fstests@vger.kernel.org>

I find Lakshmipathi.G have send it yesterday, please ignore it.
Sorry for the noise.

On 1/18/2017 18:33, Kinglong Mee wrote:
> Commit b7d908a0e8eb "README: document Fedora, RHEL, and
>  CentOS dependencies" adds a typo of local.config.example 
> to config.local.example, fix it.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
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
>  	Or:
>          - setenv TEST_DEV "device containing TEST PARTITION"
>          - setenv TEST_DIR "mount point of TEST PARTITION"   
> 
