Received: from mx2.suse.de ([195.135.220.15]:56682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbfDIP57 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Apr 2019 11:57:59 -0400
Date: Tue, 9 Apr 2019 17:57:57 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] generic/230: reset grace time before overcome hardlimit
Message-ID: <20190409155757.GD1426@quack2.suse.cz>
References: <1554807874-135913-1-git-send-email-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554807874-135913-1-git-send-email-yi.zhang@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Tue 09-04-19 19:04:34, zhangyi (F) wrote:
> Currently, we call repquota to report the latest quota information
> after each test case. But repquota will invoke Q_SYNC on the ext4 file
> system with old quota, which may be time consuming on the low speed or
> busy scratch device. If we call repquota between the "overcome
> softlimit" and the "overcome hardlimit" cases, the softlimit grace time
> may be exceed after repquota return, and lead to test failure.
> 
> Now, we capture the following failure when the disk is busy:
> 
>    pwrite: Disk quota exceeded
>    Touch 3+4
>    Touch 5+6
>   +touch: cannot touch 'SCRATCH_MNT/file5': Disk quota exceeded
>    touch: cannot touch 'SCRATCH_MNT/file6': Disk quota exceeded
>    Touch 5
>    touch: cannot touch 'SCRATCH_MNT/file5': Disk quota exceeded
> 
> This patch reset grace time before the "overcome hardlimit" case to
> avoid this failure.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Looks good to me. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tests/generic/230 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/generic/230 b/tests/generic/230
> index e0a876ba..405581b3 100755
> --- a/tests/generic/230
> +++ b/tests/generic/230
> @@ -54,6 +54,10 @@ test_enforcement()
>  		_filter_xfs_io_error | tee -a $seqres.full
>  	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
>  	# Now try to overcome block hardlimit
> +	# Reset grace time here due to the repquota will invoke Q_SYNC on
> +	# old quota which may be time consuming on the low speed or busy
> +	# scratch device that may leed to grace time exceed.
> +	setquota -$type $qa_user -T $grace $grace $SCRATCH_MNT 2>/dev/null
>  	echo "Write 250 blocks..."
>  	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 $((250 * $BLOCK_SIZE))' -c fsync \
>  		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | \
> @@ -75,6 +79,10 @@ test_enforcement()
>  		2>&1 >>$seqres.full | _filter_scratch | tee -a $seqres.full
>  	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
>  	# Try to exceed inode hardlimit
> +	# Reset grace time here due to the repquota will invoke Q_SYNC on
> +	# old quota which may be time consuming on the low speed or busy
> +	# scratch device that may leed to grace time exceed.
> +	setquota -$type $qa_user -T $grace $grace $SCRATCH_MNT 2>/dev/null
>  	echo "Touch 5+6"
>  	su $qa_user -c "touch $SCRATCH_MNT/file5 $SCRATCH_MNT/file6" \
>  		2>&1 >>$seqres.full | _filter_scratch | tee -a $seqres.full
> -- 
> 2.13.6
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
