Received: from mail-pl1-f195.google.com ([209.85.214.195]:38925 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfCBJRQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 2 Mar 2019 04:17:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id b65so151079plb.6
        for <fstests@vger.kernel.org>; Sat, 02 Mar 2019 01:17:15 -0800 (PST)
Date: Sat, 2 Mar 2019 17:17:10 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 1/2] commom/rc: use the common function
 get_max_file_size
Message-ID: <20190302091710.GA2824@desktop>
References: <20190226141154.142271-1-yuyufen@huawei.com>
 <20190226141154.142271-2-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226141154.142271-2-yuyufen@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Yufen Yu <yuyufen@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 26, 2019 at 10:11:53PM +0800, Yufen Yu wrote:
> Move the function get_max_file_size() of generci/485 to common/rc,
> and add the max filesize limit to generic/299.

There should be explainations in commit log on why the max filesize
should be limited in generic/299, like your v1 patch did. I'll add them
back on commit.

> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  common/rc         | 23 +++++++++++++++++++++++
>  tests/generic/299 |  5 +++++
>  tests/generic/485 | 23 -----------------------
>  3 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index e5da6484..987f3e23 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3785,6 +3785,29 @@ _require_scratch_feature()
>  	esac
>  }
>  
> +# Get the maximum size of a file in $TEST_DIR (s_maxbytes).  On ext4 this will
> +# be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
> +get_max_file_size()

We usually name common helper functions with the leading underscore,
e.g. _get_max_file_size, I'll fix the naming and all the calls in tests
on commit.

Thanks,
Eryu

> +{
> +	local testfile=$TEST_DIR/maxfilesize.$seq
> +	local l=0
> +	local r=9223372036854775807 # LLONG_MAX
> +
> +	rm -f $testfile
> +	while (( l < r )); do
> +		# Use _math() to avoid signed integer overflow.
> +		local m=$(_math "($l + $r + 1) / 2")
> +		if $XFS_IO_PROG -f -c "truncate $m" $testfile \
> +			|& grep -q 'File too large'
> +		then
> +			r=$(( m - 1 ))
> +		else
> +			l=$m
> +		fi
> +	done
> +	echo $l
> +}
> +
>  # The maximum filesystem label length, /not/ including terminating NULL
>  _label_get_max()
>  {
> diff --git a/tests/generic/299 b/tests/generic/299
> index c4d74fc8..494bf61c 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -33,6 +33,11 @@ NUM_JOBS=$((4*LOAD_FACTOR))
>  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
>  FILE_SIZE=$((BLK_DEV_SIZE * 512))
>  
> +max_file_size=$(get_max_file_size)
> +if [ $max_file_size -lt $FILE_SIZE ]; then
> +	FILE_SIZE=$max_file_size
> +fi
> +
>  cat >$fio_config <<EOF
>  ###########
>  # $seq test fio activity
> diff --git a/tests/generic/485 b/tests/generic/485
> index e88ac2e4..d55535c2 100755
> --- a/tests/generic/485
> +++ b/tests/generic/485
> @@ -37,29 +37,6 @@ _require_xfs_io_command "falloc" "-k"
>  _require_xfs_io_command "finsert"
>  _require_xfs_io_command "truncate"
>  
> -# Get the maximum size of a file in $TEST_DIR (s_maxbytes).  On ext4 this will
> -# be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
> -get_max_file_size()
> -{
> -	local testfile=$TEST_DIR/maxfilesize.$seq
> -	local l=0
> -	local r=9223372036854775807 # LLONG_MAX
> -
> -	rm -f $testfile
> -	while (( l < r )); do
> -		# Use _math() to avoid signed integer overflow.
> -		local m=$(_math "($l + $r + 1) / 2")
> -		if $XFS_IO_PROG -f -c "truncate $m" $testfile \
> -			|& grep -q 'File too large'
> -		then
> -			r=$(( m - 1 ))
> -		else
> -			l=$m
> -		fi
> -	done
> -	echo $l
> -}
> -
>  block_size=$(_get_file_block_size $TEST_DIR)
>  max_file_size=$(get_max_file_size)
>  max_blocks=$((max_file_size / block_size))
> -- 
> 2.16.2.dirty
> 
