Received: from mga03.intel.com ([134.134.136.65]:64438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbdI2QYs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Sep 2017 12:24:48 -0400
Date: Fri, 29 Sep 2017 10:24:46 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v7] generic/413: skip dax to nondax dio test if needed
Message-ID: <20170929162446.GA17705@linux.intel.com>
References: <1506584500-867-1-git-send-email-xzhou@redhat.com>
 <1506651371-21608-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506651371-21608-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 29, 2017 at 10:16:11AM +0800, Xiong Zhou wrote:
> This test requires there is struct page backend for the
> testing dax device. But not all devices which support dax
> have that. So we give it a try, if it fails with EFAULT,
> which is the same errno with the wrong device situation,
> we skip this subtest.
> 
> This is not perfect, but it's efficient. Many devices
> support dax, and there are more coming. It's nearly
> impossible to maintain an uniq way to detect struct page
> present for all kinds of devices modes.
> 
> From testing perspectice, a testrun could cover this
> code path as a sanity check and avoid more unnecessary
> failires. If the device is compatible with the test, one
> more testrun will not hurt much.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
> 
> v7:
>   split this patch from that unrelated series.
>   minor comment fix.
> 
>  src/t_mmap_dio.c  |  2 +-
>  tests/generic/413 | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
> index 6c8ca1a..73e7648 100644
> --- a/src/t_mmap_dio.c
> +++ b/src/t_mmap_dio.c
> @@ -27,7 +27,7 @@ void err_exit(char *op, unsigned long len, char *s)
>  {
>  	fprintf(stderr, "%s(%s) len %lu %s\n",
>  		op, strerror(errno), len, s);
> -	exit(1);
> +	exit(errno);
>  }
>  
>  int main(int argc, char **argv)
> diff --git a/tests/generic/413 b/tests/generic/413
> index a1cc514..311bdc2 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -88,6 +88,18 @@ t_nondax_to_dax()
>  t_dax_to_nondax()
>  {
>  	prep_files
> +
> +	# dax to nondax dio needs struct page backend, which is
> +	# not always available among various devices. Skip this
> +	# subtest if EFAULT(14 Bad address) returned, which means
> +	# probably the device is not compatible with this test.
> +	#
> +	src/t_mmap_dio $SCRATCH_MNT/tf_s $TEST_DIR/tf_d \
> +		$1 "test" > /dev/null 2>&1
> +	if [ $? -eq 14 ] ; then
> +		return
> +	fi
> +
>  	src/t_mmap_dio $SCRATCH_MNT/tf_s \
>  		$TEST_DIR/tf_d $1 "dio dax to nondax"
>  
> -- 
> 1.8.3.1

I think you may have missed this feedback from Jeff & Eryu?  (I can't find an
online archive of fstests, so just copy-n-pasting here:

Eryu Guan <eguan@redhat.com> writes:

> On Mon, Sep 25, 2017 at 04:40:46PM +0800, Xiong Zhou wrote:
>> Since not all devices support dax has struct page backend,
>> which will not support this test.
>> 
>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> ---
>>  tests/generic/413 | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/tests/generic/413 b/tests/generic/413
>> index a1cc514..b86c10f 100755
>> --- a/tests/generic/413
>> +++ b/tests/generic/413
>> @@ -88,6 +88,14 @@ t_nondax_to_dax()
>>  t_dax_to_nondax()
>>  {
>>      prep_files
>> +    # dax to nondax dio needs struct page backend, which is
>> +    # not always avaiable among various devices. Skip this
>> +    # subtest if not compatible.
>> +    if ! src/t_mmap_dio $SCRATCH_MNT/tf_s \
>> +       $TEST_DIR/tf_d $1 "test" > /dev/null 2>&1 ; then
>> +            return
>> +    fi
>> +
>
> Then we will never get a failure from this case, even if it's a real
> bug.. We need better way to tell if there's struct page present :)

ndctl list will tell you the mode of the namespace.  If it's 'raw', then
it doesn't have struct page backing.  If it's 'memory', it should work
fine.

-Jeff
