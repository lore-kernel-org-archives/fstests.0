Received: from sandeen.net ([63.231.237.45]:48670 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbcIINPO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 9 Sep 2016 09:15:14 -0400
Subject: Re: [PATCH] xfs/263: skip test if Q_XGETQSTATV hasn't been supported
 by kernel or xfsprogs
References: <1473410864-7780-1-git-send-email-yangx.jy@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5863fb55-a0d6-8848-2297-5c15f68b3154@sandeen.net>
Date: Fri, 9 Sep 2016 08:15:12 -0500
MIME-Version: 1.0
In-Reply-To: <1473410864-7780-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
Cc: sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On 9/9/16 3:47 AM, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/263 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index 1dc47ae..07f7ebc 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -58,6 +58,10 @@ _require_xfs_quota
>  _require_xfs_mkfs_crc
>  _require_xfs_crc
>  
> +# check if Q_XGETQSTATV has been supported by kernel and xfsprogs
> +grep -q 'Q_XGETQSTATV' /usr/include/linux/dqblk_xfs.h || _notrun "Q_XGETQSTATV hasn't been supported by kernel"
> +grep -q 'Q_XGETQSTATV' /usr/include/xfs/xqm.h || _notrun "Q_XGETQSTATV hasn't been supported by xfsprogs"

The installed headers may not even exist; if they are, they
won't tell us anything about the binaries we're running.  If
you really want to test for its presence, you'd need to somehow
directly test both the running kernel and the installed xfs_quota
binary.

But whether or not we should run the test if XGETQSTATV is not
present is another question; adding XGETQSTATV fixed a problem
of incorrect reporting; if the test fails, we know the environment
is not capable of that, and is reporting bad information.

So it comes down to whether the test is intended to verify
that the "xfs_quota -c state" command is working, or whether
the XGETQSTATV interface is working, etc.

Generally, we don't restrict test runs to environments where we
know the test will pass.  So I would say that allowing this to
run and fail is the correct option; it tells us that the installed
kernel+xfsprogs will report bad information from the "state" command,
and that is useful information to the tester.

-Eric

> +
>  rm -f $seqres.full
>  
>  function option_string()
> 
