Received: from mail-pl0-f67.google.com ([209.85.160.67]:46215 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeENIvx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 May 2018 04:51:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so2124539pld.13
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 01:51:53 -0700 (PDT)
Date: Mon, 14 May 2018 16:51:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/484: add missing _require_test_program
Message-ID: <20180514085148.GU8373@desktop>
References: <1526227439-20517-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526227439-20517-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, May 13, 2018 at 07:03:59PM +0300, Amir Goldstein wrote:
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  tests/generic/484 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/484 b/tests/generic/484
> index 1c2cd96..cb55414 100755
> --- a/tests/generic/484
> +++ b/tests/generic/484
> @@ -52,6 +52,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_test_program "t_locks_execve"

Ah, I missed it in review, thanks!

Eryu

>  
>  # prepare a 4k testfile in TEST_DIR
>  $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> -- 
> 2.7.4
> 
