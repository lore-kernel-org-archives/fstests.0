Received: from mx1.redhat.com ([209.132.183.28]:49669 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbcGRIrR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Jul 2016 04:47:17 -0400
Date: Mon, 18 Jul 2016 16:47:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/071: require falloc -k
Message-ID: <20160718084714.GD27776@eguan.usersys.redhat.com>
References: <1468829204-24593-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468829204-24593-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 11:06:44AM +0300, Christoph Hellwig wrote:
> NFSv4.2 supports fallocate, but not the FALLOC_FL_KEEP_SIZE option.
> To avoid a spurious failure test for the correct command.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/071 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/071 b/tests/generic/071
> index 65ed0c7..9d0d136 100755
> --- a/tests/generic/071
> +++ b/tests/generic/071
> @@ -46,7 +46,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> -_require_xfs_io_command "falloc"
> +_require_xfs_io_command "falloc" "-k"

This stops generic/071 from running no matter what filesystem it's
testing, this is because _require_xfs_io_command only checks whether
xfs_io knows the option (-k) by searching it in help message, not really
running it, i.e.

xfs_io -c "help falloc" | grep -q "^ -k --"

but "help falloc" doesn't follow the normal xfs_io command help format

# xfs_io -c "help falloc"
falloc [-c] [-k] [-p] off len -- allocates space associated with part of a file via fallocate

So the check always returns false, and test always _notrun, with the
additional "-k" switch.

Perhaps we should update _require_xfs_io_command to actually run the
command with the provided additional option?

Thanks,
Eryu
