Received: from sandeen.net ([63.231.237.45]:47804 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGUvN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Aug 2019 16:51:13 -0400
Subject: Re: [PATCH] xfs/097: Add suitable metadata options in mkfs when test
 finobt
References: <6032f83fcdfc4291875b07a8ee4cac52MN2PR18MB3437AD56AD6901531FEF5626DBD40@MN2PR18MB3437.namprd18.prod.outlook.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <2f049a05-6a03-985b-ef1b-ec0512773251@sandeen.net>
Date: Wed, 7 Aug 2019 15:51:11 -0500
MIME-Version: 1.0
In-Reply-To: <6032f83fcdfc4291875b07a8ee4cac52MN2PR18MB3437AD56AD6901531FEF5626DBD40@MN2PR18MB3437.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Yong Sun <YoSun@suse.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 8/7/19 4:21 AM, Yong Sun wrote:
> Hi all,
> 
> When test xfs/097 in my test machine, it always skips and print "[not run] finobt not enabled". I add one line change, and this test could runs OK.

This should be safe, because the test already does:

_require_xfs_mkfs_finobt
_require_xfs_finobt

and that first _require ensures that crc=1,finobt=1 will work
even if it's not on by default in mkfs.

> 
> Signed-off-by: Yong Sun <yosun@suse.com>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/xfs/097 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/097 b/tests/xfs/097
> index 68eae1d4..1cb7d69c 100755
> --- a/tests/xfs/097
> +++ b/tests/xfs/097
> @@ -46,7 +46,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
>  TESTFILE="${TESTDIR}/testfile"
> 
>  echo "+ create scratch fs"
> -_scratch_mkfs_xfs > /dev/null
> +_scratch_mkfs_xfs -m crc=1,finobt=1 > /dev/null
> 
>  echo "+ mount fs image"
>  _scratch_mount
> 
