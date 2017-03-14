Received: from mga14.intel.com ([192.55.52.115]:15402 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbdCNOoK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 10:44:10 -0400
Date: Tue, 14 Mar 2017 08:44:03 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] DAX DIO: DAX mapped area DIO to non-DAX expected failure
Message-ID: <20170314144403.GA25951@linux.intel.com>
References: <1489463960-3579-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489463960-3579-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 14, 2017 at 11:59:20AM +0800, Xiong Zhou wrote:
> It's not supported on raw mode nvdimm, brd ramdisk:
> https://lists.01.org/pipermail/linux-nvdimm/2017-February/008959.html
> 
> It's working on "memory mode" nvdimm, memmap ramdisk.
> 
> Mute output of this subtest to stop the fake failure. Keep this
> routine for sanity check.
> 
> Updating generic/413 and xfs/260.

I don't understand how we can mute the errors that are due to DAX direct I/O
being used in unsupported configurations (raw mode nvdimm, brd ramdisk)
without also muting real errors that happen for supported configs (memory mode
nvidmm)?

It seems like for this test to give us proper coverage, we need to see this
output in all cases, and we just need to document to the user that this test
is expected to fail if you run it against brd or raw mode nvdimms?

Or am I missing something?

- Ross

> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/generic/413 | 6 ++++--
>  tests/xfs/260     | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/413 b/tests/generic/413
> index a1cc514..828ef79 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -89,11 +89,13 @@ t_dax_to_nondax()
>  {
>  	prep_files
>  	src/t_mmap_dio $SCRATCH_MNT/tf_s \
> -		$TEST_DIR/tf_d $1 "dio dax to nondax"
> +		$TEST_DIR/tf_d $1 "dio dax to nondax" \
> +		> /dev/null 2>&1
>  
>  	prep_files
>  	src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
> -		$TEST_DIR/tf_d $1 "buffered dax to nondax"
> +		$TEST_DIR/tf_d $1 "buffered dax to nondax" \
> +		> /dev/null 2>&1
>  }
>  
>  t_both_nondax()
> diff --git a/tests/xfs/260 b/tests/xfs/260
> index e613cc0..ff7eed2 100755
> --- a/tests/xfs/260
> +++ b/tests/xfs/260
> @@ -94,13 +94,15 @@ t_dax_to_nondax()
>  	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
>  	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
>  	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> -		$1 "dio dax to nondax"
> +		$1 "dio dax to nondax" \
> +		> /dev/null 2>&1
>  
>  	prep_files
>  	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
>  	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
>  	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> -		$1 "buffered dax to nondax"
> +		$1 "buffered dax to nondax" \
> +		> /dev/null 2>&1
>  }
>  
>  t_both_nondax()
> -- 
> 1.8.3.1
> 
