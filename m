Received: from userp2130.oracle.com ([156.151.31.86]:39294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfE3P2b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 May 2019 11:28:31 -0400
Date: Thu, 30 May 2019 08:26:06 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/517: notrun on NFS due to unaligned dedupe in
 test
Message-ID: <20190530152606.GA5383@magnolia>
References: <20190530094147.14512-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530094147.14512-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Murphy Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 30, 2019 at 05:41:47PM +0800, Murphy Zhou wrote:
> NFSv4.2 could pass _require_scratch_dedupe, since the test offset and
> size are aligned, while generic/517 is performing unaligned dedupe.
> NFS does not support unaligned dedupe now, returns EINVAL.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  tests/generic/517 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/517 b/tests/generic/517
> index 601bb24e..23665782 100755
> --- a/tests/generic/517
> +++ b/tests/generic/517
> @@ -30,6 +30,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_dedupe
> +$FSTYP == "nfs"  && _notrun "NFS can't handle unaligned deduplication"

Uh... NFS supports dedupe??

Let's see, we pass REMAP_FILE_DEDUP to nfs42_remap_file_range via
@remap_flags.  That function checks remap_flags but never touches it
again.  It's not passed to nfs42_proc_clone, which (AFAICT) means that
the nfs client sends a CLONE request to the server on behalf of a
FS_IOC_EXTENT_SAME ioctl.  That seems suspicious to me...

The nfs client also doesn't lock and compare the file contents itself
(the server should be doing that anyway, right?) which means that dedupe
doesn't fail if the file contents are different?

Oh, I see... Xiaoli Feng turned on dedupe for cifs (b073a08016a10f0) and
nfs (ce96e888fe48e) even though (the last I heard) neither protocol
supports dedupe and now will corrupt data in doing so.

Let's hold off on this for now while I go email Anna & Steve about
whether or not nfs and cifs support dedupe.

--D

>  
>  rm -f $seqres.full
>  
> -- 
> 2.21.0
> 
