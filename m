Received: from mx1.redhat.com ([209.132.183.28]:38658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdI0JuG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 05:50:06 -0400
Date: Wed, 27 Sep 2017 17:50:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v5 2/3] generic/413: skip dax to nondax dio test if needed
Message-ID: <20170927095004.GP8034@eguan.usersys.redhat.com>
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-3-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506328847-1669-3-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 25, 2017 at 04:40:46PM +0800, Xiong Zhou wrote:
> Since not all devices support dax has struct page backend,
> which will not support this test.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/generic/413 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/generic/413 b/tests/generic/413
> index a1cc514..b86c10f 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -88,6 +88,14 @@ t_nondax_to_dax()
>  t_dax_to_nondax()
>  {
>  	prep_files
> +	# dax to nondax dio needs struct page backend, which is
> +	# not always avaiable among various devices. Skip this
> +	# subtest if not compatible.
> +	if ! src/t_mmap_dio $SCRATCH_MNT/tf_s \
> +	   $TEST_DIR/tf_d $1 "test" > /dev/null 2>&1 ; then
> +		return
> +	fi
> +

Then we will never get a failure from this case, even if it's a real
bug.. We need better way to tell if there's struct page present :)

Thanks,
Eryu

>  	src/t_mmap_dio $SCRATCH_MNT/tf_s \
>  		$TEST_DIR/tf_d $1 "dio dax to nondax"
>  
> -- 
> 1.8.3.1
> 
