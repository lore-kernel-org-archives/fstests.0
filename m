Received: from smtp2.provo.novell.com ([137.65.250.81]:54740 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdLMOBv (ORCPT
        <rfc822;groupwise-fstests@vger.kernel.org:0:0>);
        Wed, 13 Dec 2017 09:01:51 -0500
Subject: Re: [PATCH v4 1/3] Check pwrite parameters
References: <20171207160044.8913-1-rgoldwyn@suse.de>
 <20171213110527.GB2749@eguan.usersys.redhat.com>
From: Goldwyn Rodrigues <rgoldwyn@suse.com>
Message-ID: <baa9a653-146d-541e-2714-93253d8a73f2@suse.com>
Date: Wed, 13 Dec 2017 08:01:46 -0600
MIME-Version: 1.0
In-Reply-To: <20171213110527.GB2749@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>



On 12/13/2017 05:05 AM, Eryu Guan wrote:
> On Thu, Dec 07, 2017 at 10:00:42AM -0600, Goldwyn Rodrigues wrote:
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> There are some parameters added with xfs_io. Check if the pwrite
>> parameters are available. For some cases, xfs_io now returns "command
>> -%c not supported", so added "not supported" to count as error.
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> Changes since v3:
>>  - pwrite -N check to add -V parameters to check on pwritev2()
>>
>> ---
>>  common/rc | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 4c053a53..4f4b9e10 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2035,6 +2035,7 @@ _require_xfs_io_command()
>>  	shift
>>  	local param="$*"
>>  	local param_checked=0
>> +	local opts=""
>>  
>>  	testfile=$TEST_DIR/$$.xfs_io
>>  	case $command in
>> @@ -2079,6 +2080,17 @@ _require_xfs_io_command()
>>  		echo $testio | grep -q "invalid option" && \
>>  			_notrun "xfs_io $command support is missing"
>>  		;;
>> +	"pwrite")
>> +		# -N (RWF_NOWAIT) only works with direct I/O writes
>> +		local pwrite_opts=" "
>> +		if [ "$param" == "-N" ]; then
>> +			opts+=" -d"
>> +			pwrite_opts+="-V 1 -b 4k"
>> +		fi
>> +		testio=`$XFS_IO_PROG -f $opts -c \
>> +		        "pwrite $pwrite_opts $param 0 4k" $testfile 2>&1`
>> +		param_checked=1
> 
> I think I found why xfs_io returned EOPNOTSUPP but strace showed EAGAIN
> for me. It's pwritev2 glibc wrapper that modifies the errno before
> return, please see glibc commit 852d63120783 ("posix: Set p{read,write}v2
> to return ENOTSUP (BZ#21780)").
> 

Oh yes, that explains it.

> diff --git a/sysdeps/unix/sysv/linux/pwritev2.c b/sysdeps/unix/sysv/linux/pwritev2.c
> index 72f0471f969a..8e5032fe2fed 100644
> --- a/sysdeps/unix/sysv/linux/pwritev2.c
> +++ b/sysdeps/unix/sysv/linux/pwritev2.c
> @@ -28,7 +28,7 @@ pwritev2 (int fd, const struct iovec *vector, int count, off_t offset,
>  # ifdef __NR_pwritev2
>    ssize_t result = SYSCALL_CANCEL (pwritev2, fd, vector, count,
>                                    LO_HI_LONG (offset), flags);
> -  if (result >= 0 || errno != ENOSYS)
> +  if (result >= 0)
>      return result;
>  # endif
>    /* Trying to emulate the pwritev2 syscall flags is troublesome:
> @@ -42,7 +42,7 @@ pwritev2 (int fd, const struct iovec *vector, int count, off_t offset,
>  
>    if (flags != 0)
>      {
> -      __set_errno (EOPNOTSUPP);
> +      __set_errno (ENOTSUP);
>        return -1;
>      }
>    return pwritev (fd, vector, count, offset);
> 
> So originally, pritev2 wrapper returned any error except ENOSYS, but now
> it translates all errors to ENOTSUP (EOPNOTSUPP). That's why kernel
> returned EAGAIN and strace captured EAGAIN but perror() in xfs_io still
> printed EOPNOTSUPP. It looks like a glibc bug to me.
> 
> Apparently, my Fedora rawhide system is new enough to have this glibc
> version. And I did see generic/470 pass with 4.15-rc2 kernel with that
> glibc patch reverted.
> 
> Anyway, with this additional "-V 1" in pwrite test, generic/470 would
> _notrun on buggy system.
> 
> I'll queue this patchset for next release if there's no more comments
> from other reivewers.

Thanks for your efforts.

Just to let you know that generic/471 does not pass as yet. IOW, direct
I/O write() writes the data to the file _and_ returns -ENOSPC. I have
sent a patch upstream [1] which fixes the bug but it has not been
incorporated as yet. In any case, the write() should either write and
return number of bytes written or return -ENOSPC and not write anything
at all. Following semantics, it should be the former.

[1] https://patchwork.kernel.org/patch/10070399/

-- 
Goldwyn
