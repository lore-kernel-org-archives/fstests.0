Received: from sandeen.net ([63.231.237.45]:54896 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933054AbeGFOuL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Jul 2018 10:50:11 -0400
Subject: Re: [PATCH] xfs: skip copy fs test on large device
References: <20180706060728.6606-1-zlang@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <ab00ab99-117b-353b-7f47-eeb127f298ad@sandeen.net>
Date: Fri, 6 Jul 2018 09:50:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180706060728.6606-1-zlang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 7/6/18 1:07 AM, Zorro Lang wrote:
> When test on large SCRATCH_DEV, copy a huge size XFS to TEST_DIR
> will fill the TEST_DIR soon, and xfs_copy process will be blocked
> there. Due to copy LARGE_SCRATCH_DEV won't add any more test
> coverage, so skip this kind of tests if LARGE_SCRATCH_DEV is yes.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Seems reasonable.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
> 
> Refer to "a82e9464 xfs: skip growfs test on large device", xfs_copy a
> huge size XFS will be blocked, so skip this kind of tests too.
> 
> Thanks,
> Zorro
> 
>  tests/xfs/077 | 1 +
>  tests/xfs/284 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/xfs/077 b/tests/xfs/077
> index 3eaa5ffd..02bcc9f7 100755
> --- a/tests/xfs/077
> +++ b/tests/xfs/077
> @@ -38,6 +38,7 @@ _supported_os Linux
>  # xfs_copy does not support realtime devices
>  _require_no_realtime
>  _require_scratch
> +_require_no_large_scratch_dev
>  _require_xfs_crc
>  _require_meta_uuid
>  
> diff --git a/tests/xfs/284 b/tests/xfs/284
> index fc51af0e..07f71031 100755
> --- a/tests/xfs/284
> +++ b/tests/xfs/284
> @@ -38,6 +38,7 @@ _supported_os Linux
>  _require_no_realtime
>  _require_test
>  _require_scratch
> +_require_no_large_scratch_dev
>  
>  function filter_mounted()
>  {
> 
