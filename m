Received: from mail-pf1-f196.google.com ([209.85.210.196]:37733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCWJMf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 23 Mar 2019 05:12:35 -0400
Date: Sat, 23 Mar 2019 17:12:27 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] btrfs: Extend btrfs/003 device removal test
Message-ID: <20190323091227.GU2824@desktop>
References: <20190319110404.9707-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319110404.9707-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 01:04:04PM +0200, Nikolay Borisov wrote:
> When a device is deleted/removed from a btrfs filesystem the kernel
> ensures all superblocks on said device are zeroed out. Test for this
> behavior. Since btrfs inspect-internal dump-super always return success
> I cannot test for the return value of the command. Instead there are 2
> cases to handle:
> 
>     1. When the device is smaller than the requested super block copy, i.e.
>     super block copy 2 resides at 256GB. In such cases btrfs command just
>     returns blank screen
> 
>     2. When the device is removed and a valid offset of the super block is
>     queried btrfs command returns a textual error to stderr.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I think this test deserves a new test itself, not being embedded in an
existing test randomly.

Thanks,
Eryu

> ---
> V2: 
> 	* properly assign the return value of the last command expression to ret
> 
>  tests/btrfs/003 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index 22aa57aad0b9..a805826ce891 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -161,6 +161,14 @@ _test_remove()
>  	dev_del=`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
>  	$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs device delete failed"
>  	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV 2>&1 | grep $dev_del >> $seqres.full && _fail "btrfs still shows the deleted dev"
> +	for i in {0..2}; do
> +		local output=$($BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del 2>&1)
> +		$BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del 2>&1 | grep -q "bad magic"
> +		ret=$?
> +		if [[ "$output" != "" && $ret -eq 1 ]]; then
> +			_fail "Delete dev superblocks not scratched"
> +		fi
> +	done
>  	_scratch_unmount
>  }
>  
> -- 
> 2.7.4
> 
