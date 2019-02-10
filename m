Received: from mail-pf1-f194.google.com ([209.85.210.194]:45831 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJJa0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Feb 2019 04:30:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id j3so3786890pfi.12
        for <fstests@vger.kernel.org>; Sun, 10 Feb 2019 01:30:26 -0800 (PST)
Date: Sun, 10 Feb 2019 17:30:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] xfs/252: requires fallocate support for preallocation
Message-ID: <20190210093019.GS2713@desktop>
References: <20190205184816.20330-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205184816.20330-1-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 05, 2019 at 07:48:16PM +0100, Christoph Hellwig wrote:
> xfs/252 has a few feature tests, but misses checking for preallocation
> support.  Because of that it will fail instead of not being run for
> and XFS file system in always COW mode.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/252 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/252 b/tests/xfs/252
> index df795b81..42650ad1 100755
> --- a/tests/xfs/252
> +++ b/tests/xfs/252
> @@ -31,6 +31,7 @@ _supported_fs xfs
>  _supported_os Linux
>  
>  _require_test
> +_require_xfs_io_command "fallocate"

The xfs_io command should be "falloc", fixed on commit :)

Thanks,
Eryu

>  _require_xfs_io_command "fpunch"
>  _require_xfs_io_command "fiemap"
>  
> -- 
> 2.20.1
> 
