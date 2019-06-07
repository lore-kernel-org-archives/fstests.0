Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51835 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFTF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jun 2019 01:19:05 -0400
From: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: btrfs/163: make readahead run on the seed device
Date: Fri, 7 Jun 2019 05:19:02 +0000
Message-ID: <SN6PR04MB52314ED3404ED19E791954CD8C100@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607023422.28928-1-naohiro.aota@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: "fdmanana@gmail.com" <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

I forgot to update the expected output. Ignore this.=0A=
=0A=
On 2019/06/07 11:34, Naohiro Aota wrote:=0A=
> There is a long lived bug that btrfs wait for readahead to finish=0A=
> indefinitely when readahead zone is inserted into seed devices.=0A=
> =0A=
> Current write size to the file "foobar" is too small to run readahead=0A=
> before the replacing on seed device. So, increase the write size to=0A=
> reproduce the issue.=0A=
> =0A=
> Following patch fixes it:=0A=
> =0A=
> 	"btrfs: start readahead also in seed devices"=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>   tests/btrfs/163 | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/tests/btrfs/163 b/tests/btrfs/163=0A=
> index 8c93e83b970a..24c725afb6b9 100755=0A=
> --- a/tests/btrfs/163=0A=
> +++ b/tests/btrfs/163=0A=
> @@ -50,7 +50,7 @@ create_seed()=0A=
>   {=0A=
>   	_mkfs_dev $dev_seed=0A=
>   	run_check _mount $dev_seed $SCRATCH_MNT=0A=
> -	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\=0A=
> +	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\=0A=
>   		/dev/null=0A=
>   	echo -- gloden --=0A=
>   	od -x $SCRATCH_MNT/foobar=0A=
> =0A=
=0A=
