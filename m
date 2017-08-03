Received: from sandeen.net ([63.231.237.45]:42554 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdHCO5h (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Aug 2017 10:57:37 -0400
Subject: Re: [PATCH] xfs/424: add check for crc and finobt
References: <1501761914-16445-1-git-send-email-yangx.jy@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net>
Date: Thu, 3 Aug 2017 09:57:36 -0500
MIME-Version: 1.0
In-Reply-To: <1501761914-16445-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/3/17 7:05 AM, Xiao Yang wrote:
> 1) When crc is not supported or disabled, this case could not indicate
>    any expected error.  Running all tests without crc makes no sense.

It's still fine to run the test.  The description indicates
that errors may be seen on crc filesystems, but there's nothing
wrong with a test which iterates over "type" commands in xfs_db,
even without crcs.  It's possible that some other error could
be found in the future.

So perhaps the description should be updated; it does not "check for
that false crc error," it simply checks that setting types causes
/no/ error.
 
> 2) When finobt is disabled, xfs_db fails to get current address of
>    free_root, as below:
>    xfs_db -c "agi" -c "addr free_root" -c "daddr" /dev/sda11
>    Metadata CRC error detected at xfs_inobt block 0x0/0x1000
>    ...

I agree that the test should not be trying to set types that do
not exist on the filesystem.

But I think the right approach is to let the test run over whatever
MKFS_OPTIONS have been specified, and be sure that the test can handle
it properly, rather than forcing the test to run only with a certain
set of options enabled.

Thanks,
-Eric

>    Running related tests without finobt makes no sense.
> 
> We add check to fix it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/424 | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/424 b/tests/xfs/424
> index 0a1eef9..165c390 100755
> --- a/tests/xfs/424
> +++ b/tests/xfs/424
> @@ -55,9 +55,15 @@ rm -f $seqres.full
>  _supported_os Linux
>  _supported_fs xfs
>  _require_scratch
> +_require_xfs_mkfs_crc
>  
>  echo "Silence is golden."
>  
> +crc_finobt_enabled="crc=1,finobt=0"
> +
> +[ _scratch_mkfs_xfs_supported -m crc=1,finobt=1 >/dev/null 2>&1 ] && \
> +	crc_finobt_enabled="crc=1,finobt=1"
> +
>  # real QA test starts here
>  
>  # for different sector sizes, ensure no CRC errors are falsely reported.
> @@ -77,7 +83,7 @@ while [ $sec_sz -le 4096 ]; do
>  done
>  
>  for SECTOR_SIZE in $sector_sizes; do
> -	$MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
> +	$MKFS_XFS_PROG -f -m "$crc_finobt_enabled" -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
>  
>  	for TYPE in agf agi agfl sb; do
>  		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
> @@ -96,9 +102,11 @@ for SECTOR_SIZE in $sector_sizes; do
>  	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
>  		filter_dbval`
>  	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
> -	DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
> -		filter_dbval`
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
> +	if [[ "$crc_finobt_enabled" =~ 'finobt=1' ]]; then
> +		DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
> +			filter_dbval`
> +		_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
> +	fi
>  
>  	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
>  	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
> 
