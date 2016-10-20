Received: from mx1.redhat.com ([209.132.183.28]:50372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbcJTQ4c (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Oct 2016 12:56:32 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D058C04B30E
        for <fstests@vger.kernel.org>; Thu, 20 Oct 2016 16:56:32 +0000 (UTC)
Date: Fri, 21 Oct 2016 00:56:30 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/004: Check resulting file permissions
Message-ID: <20161020165630.GM27776@eguan.usersys.redhat.com>
References: <1476874267-16499-1-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476874267-16499-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 19, 2016 at 12:51:07PM +0200, Andreas Gruenbacher wrote:
> Check the file permissions resulting from linking an O_TMPFILE file into
> the namespace: they should be the same as creating a normal file.
> 
> (Note that this patch depends on patch "xfs_io: Fix initial -m option"
> for xfsprogs.)
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

I think it's better to add a new case to do the test, the test intention
of generic/004 is to test linking O_TMPFILE opens back to namespace, not
about the permissions. And we usually don't extend existing tests to do
more tests, in case it triggers false alarm of regressions.

Thanks,
Eryu

> ---
>  tests/generic/004     | 14 +++++++++++++-
>  tests/generic/004.out |  8 ++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/004 b/tests/generic/004
> index d0926f1..f9a7520 100755
> --- a/tests/generic/004
> +++ b/tests/generic/004
> @@ -52,12 +52,24 @@ rm -f $seqres.full
>  testfile="${TEST_DIR}/tst-tmpfile-flink"
>  
>  # test creating a r/w tmpfile, do I/O and link it into the namespace
> -$XFS_IO_PROG -T \
> +echo umask 022
> +umask 022
> +$XFS_IO_PROG -T -m 0666 \
>  	-c "pwrite 0 4096" \
>  	-c "pread 0 4096" \
>  	-c "flink ${testfile}" \
>  	${TEST_DIR} | _filter_xfs_io
> +stat -c '%a' ${testfile}
> +rm ${testfile}
>  
> +echo umask 027
> +umask 027
> +$XFS_IO_PROG -T -m 0666 \
> +	-c "pwrite 0 4096" \
> +	-c "pread 0 4096" \
> +	-c "flink ${testfile}" \
> +	${TEST_DIR} | _filter_xfs_io
> +stat -c '%a' ${testfile}
>  rm ${testfile}
>  
>  # test creating a r/o tmpfile.  Should fail
> diff --git a/tests/generic/004.out b/tests/generic/004.out
> index 527b2c2..11f44e7 100644
> --- a/tests/generic/004.out
> +++ b/tests/generic/004.out
> @@ -1,6 +1,14 @@
>  QA output created by 004
> +umask 022
>  wrote 4096/4096 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 4096/4096 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +644
> +umask 027
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +640
>  TEST_DIR: Invalid argument
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
