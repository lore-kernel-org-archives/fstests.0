Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:54814 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752932AbbCPIsA convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Mar 2015 04:48:00 -0400
From: Zhao Lei <zhaolei@cn.fujitsu.com>
References: <fb898cb6df594265e8677fc99e374e858b4cebea.1426236677.git.zhaolei@cn.fujitsu.com> <20150314165342.GN14156@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150314165342.GN14156@dhcp-13-216.nay.redhat.com>
Subject: RE: [PATCH] fix "utility required warning" with empty utility name
Date: Mon, 16 Mar 2015 16:46:55 +0800
Message-ID: <04bd01d05fc5$c1c9d390$455d7ab0$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: 'Eryu Guan' <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi, Eryu

> -----Original Message-----
> From: Eryu Guan [mailto:eguan@redhat.com]
> Sent: Sunday, March 15, 2015 12:54 AM
> To: Zhaolei
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH] fix "utility required warning" with empty utility name
> 
> On Fri, Mar 13, 2015 at 04:51:28PM +0800, Zhaolei wrote:
> > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> >
> > In generic/019, if we hadn't install fio, we will get following output:
> >  FSTYP         -- btrfs
> >  PLATFORM      -- Linux/x86_64 lenovo
> 4.0.0-rc3_HEAD_9eccca0843205f87c00404b663188b88eb248051_
> >  MKFS_OPTIONS  -- /dev/sda6
> >  MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6
> > /var/ltf/tester/scratch_mnt
> >
> >  generic/019      [not run]  utility required, skipped this test <- *
> >  Not run: generic/019
> >  Passed all 0 tests
> >
> > Reason of blank utility name is:
> > $1 and $2 are reversed in _require_command(), this patch fixed this
> > error.
> >
> > Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/rc b/common/rc
> > index 1ed9df5..febad8c 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1276,7 +1276,7 @@ _require_realtime()  #
> >  _require_command()
> >  {
> > -    [ -n "$1" ] && _cmd="$1" || _cmd="$2"
> > +    [ -n "$2" ] && _cmd="$2" || _cmd="$1"
> >      [ -n "$1" -a -x "$1" ] || _notrun "$_cmd utility required, skipped this
> test"
> 
> This doesn't work for me, I tested with generic/299 which requires fio, $_cmd
> name was still empty.
> 
Thanks for notice.
So the _require_command() is designed to show second arg
when first arg blank, and current code fits the design.

> I think the right fix is to fix _require_fio()
> 
> @@ -2302,7 +2302,7 @@ _require_fio()
>  {
>         job=$1
> 
> -       _require_command $FIO_PROG
> +       _require_command $FIO_PROG fio
Should be:
_require_command "$FIO_PROG" fio
To do right thing when first arg blank.

>         if [ -z "$1" ]; then
>                 return 1;
>         fi
> 
> There're also some other places need the second arg for _require_command,
> just grep _require_command in the source code.
> 
So the bug is misuse of _require_command(), and need fix them all.

I'll send v2 patch.

Thanks
Zhaolei


> Thanks,
> Eryu Guan
> 
> >  }
> >
> > --
> > 1.8.5.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info
> > at  http://vger.kernel.org/majordomo-info.html


